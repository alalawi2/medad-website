-- Medad Work Log System
-- Multi-project team work tracking

-- 1. Team members
CREATE TABLE team_members (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  auth_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  email TEXT UNIQUE,
  display_name TEXT NOT NULL,
  title TEXT,          -- e.g. 'Specialist', 'Consultant', 'Resident'
  specialty TEXT,      -- e.g. 'Haematology', 'Internal Medicine'
  institution TEXT,    -- e.g. 'SQUH', 'OMSB'
  role TEXT NOT NULL DEFAULT 'member' CHECK (role IN ('admin', 'member')),
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Work categories (hierarchical: parent → child)
CREATE TABLE work_categories (
  id SERIAL PRIMARY KEY,
  parent_id INT REFERENCES work_categories(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  sort_order INT DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  UNIQUE(parent_id, name)
);

-- Index for fast subcategory lookup
CREATE INDEX idx_work_categories_parent ON work_categories(parent_id);

-- 3. Work logs
CREATE TABLE work_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  member_id UUID NOT NULL REFERENCES team_members(id) ON DELETE CASCADE,
  category_id INT NOT NULL REFERENCES work_categories(id),
  entry_date DATE NOT NULL,
  hours_spent NUMERIC(5,2) NOT NULL CHECK (hours_spent > 0 AND hours_spent <= 24),
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_work_logs_member ON work_logs(member_id);
CREATE INDEX idx_work_logs_date ON work_logs(entry_date);
CREATE INDEX idx_work_logs_category ON work_logs(category_id);

-- 4. Hour estimation guide
CREATE TABLE hour_guides (
  id SERIAL PRIMARY KEY,
  category_id INT REFERENCES work_categories(id) ON DELETE CASCADE,
  activity_example TEXT NOT NULL,
  typical_hours TEXT NOT NULL,  -- e.g. '1-2 hours', '0.5 hours'
  notes TEXT
);

-- ============================================
-- ROW LEVEL SECURITY
-- ============================================

ALTER TABLE team_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE work_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE work_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE hour_guides ENABLE ROW LEVEL SECURITY;

-- Helper: get current member
CREATE OR REPLACE FUNCTION public.get_current_member_id()
RETURNS UUID AS $$
  SELECT id FROM team_members WHERE auth_id = auth.uid() LIMIT 1;
$$ LANGUAGE SQL SECURITY DEFINER STABLE;

-- Helper: check if current user is admin
CREATE OR REPLACE FUNCTION public.is_worklog_admin()
RETURNS BOOLEAN AS $$
  SELECT EXISTS(
    SELECT 1 FROM team_members WHERE auth_id = auth.uid() AND role = 'admin'
  );
$$ LANGUAGE SQL SECURITY DEFINER STABLE;

-- Categories: everyone can read
CREATE POLICY "Anyone can read categories" ON work_categories
  FOR SELECT USING (true);

-- Hour guides: everyone can read
CREATE POLICY "Anyone can read hour guides" ON hour_guides
  FOR SELECT USING (true);

-- Team members: see all members, update own
CREATE POLICY "Authenticated users can view members" ON team_members
  FOR SELECT USING (auth.uid() IS NOT NULL);

CREATE POLICY "Admin can manage members" ON team_members
  FOR ALL USING (public.is_worklog_admin());

-- Work logs: members see own, admin sees all
CREATE POLICY "Members see own logs" ON work_logs
  FOR SELECT USING (
    member_id = public.get_current_member_id()
    OR public.is_worklog_admin()
  );

CREATE POLICY "Members insert own logs" ON work_logs
  FOR INSERT WITH CHECK (
    member_id = public.get_current_member_id()
  );

CREATE POLICY "Members update own logs" ON work_logs
  FOR UPDATE USING (
    member_id = public.get_current_member_id()
  );

CREATE POLICY "Members delete own logs" ON work_logs
  FOR DELETE USING (
    member_id = public.get_current_member_id()
    OR public.is_worklog_admin()
  );

-- Admin can manage categories
CREATE POLICY "Admin can manage categories" ON work_categories
  FOR ALL USING (public.is_worklog_admin());

CREATE POLICY "Admin can manage hour guides" ON hour_guides
  FOR ALL USING (public.is_worklog_admin());

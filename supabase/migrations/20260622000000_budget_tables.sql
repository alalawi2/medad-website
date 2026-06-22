-- Medad Budget Management System
-- Hierarchical budget tracking for the project

-- 1. Budget categories (hierarchical like work_categories)
CREATE TABLE budget_categories (
  id SERIAL PRIMARY KEY,
  parent_id INT REFERENCES budget_categories(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  sort_order INT DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  UNIQUE(parent_id, name)
);

CREATE INDEX idx_budget_categories_parent ON budget_categories(parent_id);

-- 2. Budget entries (actual expenses)
CREATE TABLE budget_entries (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  member_id UUID REFERENCES team_members(id) ON DELETE SET NULL,
  category_id INT NOT NULL REFERENCES budget_categories(id),
  entry_date DATE NOT NULL,
  amount DECIMAL(10,3) NOT NULL,
  currency TEXT DEFAULT 'OMR',
  original_amount DECIMAL(10,3),
  original_currency TEXT,
  description TEXT,
  paid_by TEXT NOT NULL,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'paid', 'reimbursed')),
  receipt_ref TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_budget_entries_member ON budget_entries(member_id);
CREATE INDEX idx_budget_entries_date ON budget_entries(entry_date);
CREATE INDEX idx_budget_entries_category ON budget_entries(category_id);
CREATE INDEX idx_budget_entries_status ON budget_entries(status);
CREATE INDEX idx_budget_entries_paid_by ON budget_entries(paid_by);

-- ============================================
-- ROW LEVEL SECURITY
-- ============================================

ALTER TABLE budget_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE budget_entries ENABLE ROW LEVEL SECURITY;

-- Categories: all authenticated can read
CREATE POLICY "Anyone can read budget categories" ON budget_categories
  FOR SELECT USING (auth.uid() IS NOT NULL);

-- Admin can manage categories
CREATE POLICY "Admin can manage budget categories" ON budget_categories
  FOR ALL USING (public.is_worklog_admin());

-- Budget entries: all authenticated can read
CREATE POLICY "Members can read all budget entries" ON budget_entries
  FOR SELECT USING (auth.uid() IS NOT NULL);

-- Members can insert entries with their own member_id
CREATE POLICY "Members insert own budget entries" ON budget_entries
  FOR INSERT WITH CHECK (
    member_id = public.get_current_member_id()
  );

-- Admin can update any entries
CREATE POLICY "Admin can update budget entries" ON budget_entries
  FOR UPDATE USING (public.is_worklog_admin());

-- Admin can delete any entries
CREATE POLICY "Admin can delete budget entries" ON budget_entries
  FOR DELETE USING (public.is_worklog_admin());

-- ============================================
-- SEED BUDGET CATEGORIES
-- ============================================

-- A. Hardware
INSERT INTO budget_categories (name, sort_order) VALUES ('A. Hardware', 1);
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'A. Hardware' AND parent_id IS NULL), 'Workstations', 1),
  ((SELECT id FROM budget_categories WHERE name = 'A. Hardware' AND parent_id IS NULL), 'Recording Equipment', 2),
  ((SELECT id FROM budget_categories WHERE name = 'A. Hardware' AND parent_id IS NULL), 'Storage & Cards', 3),
  ((SELECT id FROM budget_categories WHERE name = 'A. Hardware' AND parent_id IS NULL), 'Peripherals', 4),
  ((SELECT id FROM budget_categories WHERE name = 'A. Hardware' AND parent_id IS NULL), 'Cables & Adapters', 5);

-- B. Research Assistants
INSERT INTO budget_categories (name, sort_order) VALUES ('B. Research Assistants', 2);
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'B. Research Assistants' AND parent_id IS NULL), 'AI Engineer', 1),
  ((SELECT id FROM budget_categories WHERE name = 'B. Research Assistants' AND parent_id IS NULL), 'Clinical RA', 2),
  ((SELECT id FROM budget_categories WHERE name = 'B. Research Assistants' AND parent_id IS NULL), 'Annotation RA', 3),
  ((SELECT id FROM budget_categories WHERE name = 'B. Research Assistants' AND parent_id IS NULL), 'Upwork/Freelance', 4),
  ((SELECT id FROM budget_categories WHERE name = 'B. Research Assistants' AND parent_id IS NULL), 'Field Assistant', 5);

-- C. AI & Software (top-level)
INSERT INTO budget_categories (name, sort_order) VALUES ('C. AI & Software', 3);

-- C1. LLM & AI APIs
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'C. AI & Software' AND parent_id IS NULL), 'C1. LLM & AI APIs', 1);
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'C1. LLM & AI APIs'), 'Anthropic/Claude', 1),
  ((SELECT id FROM budget_categories WHERE name = 'C1. LLM & AI APIs'), 'OpenAI', 2),
  ((SELECT id FROM budget_categories WHERE name = 'C1. LLM & AI APIs'), 'Manus AI', 3);

-- C2. GPU Compute
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'C. AI & Software' AND parent_id IS NULL), 'C2. GPU Compute', 2);
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'C2. GPU Compute'), 'RunPod', 1),
  ((SELECT id FROM budget_categories WHERE name = 'C2. GPU Compute'), 'Lambda', 2),
  ((SELECT id FROM budget_categories WHERE name = 'C2. GPU Compute'), 'Local GPU', 3);

-- C3. Hosting & Infra
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'C. AI & Software' AND parent_id IS NULL), 'C3. Hosting & Infra', 3);
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'C3. Hosting & Infra'), 'Vercel', 1),
  ((SELECT id FROM budget_categories WHERE name = 'C3. Hosting & Infra'), 'Supabase', 2),
  ((SELECT id FROM budget_categories WHERE name = 'C3. Hosting & Infra'), 'Cloudflare', 3);

-- C4. Productivity
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'C. AI & Software' AND parent_id IS NULL), 'C4. Productivity', 4);
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'C4. Productivity'), 'Zoom', 1),
  ((SELECT id FROM budget_categories WHERE name = 'C4. Productivity'), 'GitHub', 2),
  ((SELECT id FROM budget_categories WHERE name = 'C4. Productivity'), 'Google Workspace', 3);

-- C5. Research Tools
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'C. AI & Software' AND parent_id IS NULL), 'C5. Research Tools', 5);
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'C5. Research Tools'), 'Endnote', 1),
  ((SELECT id FROM budget_categories WHERE name = 'C5. Research Tools'), 'Consensus', 2),
  ((SELECT id FROM budget_categories WHERE name = 'C5. Research Tools'), 'Co-Evidence', 3);

-- C6. Marketing
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'C. AI & Software' AND parent_id IS NULL), 'C6. Marketing', 6);
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'C6. Marketing'), 'Resend', 1),
  ((SELECT id FROM budget_categories WHERE name = 'C6. Marketing'), 'Domains', 2),
  ((SELECT id FROM budget_categories WHERE name = 'C6. Marketing'), 'Social Media', 3);

-- C7. TTS & Media
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'C. AI & Software' AND parent_id IS NULL), 'C7. TTS & Media', 7);
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'C7. TTS & Media'), 'Replica', 1),
  ((SELECT id FROM budget_categories WHERE name = 'C7. TTS & Media'), 'OpenAI TTS', 2);

-- C8. Other Software
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'C. AI & Software' AND parent_id IS NULL), 'C8. Other Software', 8);

-- D. Operational
INSERT INTO budget_categories (name, sort_order) VALUES ('D. Operational', 4);
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'D. Operational' AND parent_id IS NULL), 'Field Supplies', 1),
  ((SELECT id FROM budget_categories WHERE name = 'D. Operational' AND parent_id IS NULL), 'Printing', 2),
  ((SELECT id FROM budget_categories WHERE name = 'D. Operational' AND parent_id IS NULL), 'Refreshments', 3),
  ((SELECT id FROM budget_categories WHERE name = 'D. Operational' AND parent_id IS NULL), 'Transport', 4),
  ((SELECT id FROM budget_categories WHERE name = 'D. Operational' AND parent_id IS NULL), 'Petty Cash', 5);

-- E. Publication Pool
INSERT INTO budget_categories (name, sort_order) VALUES ('E. Publication Pool', 5);
INSERT INTO budget_categories (parent_id, name, sort_order) VALUES
  ((SELECT id FROM budget_categories WHERE name = 'E. Publication Pool' AND parent_id IS NULL), 'APC Fees', 1),
  ((SELECT id FROM budget_categories WHERE name = 'E. Publication Pool' AND parent_id IS NULL), 'Language Editing', 2),
  ((SELECT id FROM budget_categories WHERE name = 'E. Publication Pool' AND parent_id IS NULL), 'Figure Design', 3),
  ((SELECT id FROM budget_categories WHERE name = 'E. Publication Pool' AND parent_id IS NULL), 'Refunds Received', 4);

-- ============================================
-- 3. FUNDERS TABLE
-- ============================================

CREATE TABLE budget_funders (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  short_name TEXT NOT NULL,
  allocated DECIMAL(10,3) NOT NULL DEFAULT 0,
  type TEXT NOT NULL DEFAULT 'cash' CHECK (type IN ('cash', 'in-kind')),
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('received', 'approved', 'pending', 'in-kind')),
  deadline DATE,
  grant_code TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE budget_funders ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Anyone can read funders" ON budget_funders
  FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "Admin can manage funders" ON budget_funders
  FOR ALL USING (public.is_worklog_admin());

-- Add funder_id to budget_entries
ALTER TABLE budget_entries ADD COLUMN funder_id INT REFERENCES budget_funders(id);
CREATE INDEX idx_budget_entries_funder ON budget_entries(funder_id);

-- Seed funders
INSERT INTO budget_funders (name, short_name, allocated, type, status, deadline, grant_code, notes) VALUES
  ('IG Medical Research Center', 'IG', 6000, 'cash', 'received', NULL, 'IG/--/DVC/MRC/26/449', 'Internal Grant — fully received Nov 2025'),
  ('SRP Strategic Research Program', 'SRP', 19500, 'cash', 'approved', '2028-02-28', 'RC-SR-DVC-MRC-25-643', 'Claims by 28 Feb 2028. Reimburses Abdullah pending expenses.'),
  ('University Medical City', 'UMC', 25000, 'in-kind', 'in-kind', NULL, NULL, 'Clinic space, equipment access. Not included in cash calculations.');

-- ============================================
-- 4. PUBLICATIONS TABLE
-- ============================================

CREATE TABLE publications (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  journal TEXT NOT NULL,
  authors TEXT,
  pmid TEXT,
  doi TEXT,
  pub_status TEXT NOT NULL DEFAULT 'submitted' CHECK (pub_status IN ('submitted', 'under_review', 'accepted', 'published', 'rejected')),
  pub_date DATE,
  -- Payment info
  apc_fee DECIMAL(10,3),
  apc_currency TEXT DEFAULT 'OMR',
  apc_original_amount DECIMAL(10,3),
  apc_original_currency TEXT,
  paid_by TEXT,
  paid_date DATE,
  -- Reimbursement
  reimburse_source TEXT, -- 'SQU Pub Support', 'TRC', 'OMSB', 'None'
  reimburse_status TEXT DEFAULT 'not_applied' CHECK (reimburse_status IN ('not_applied', 'applied', 'approved', 'received', 'rejected', 'partial')),
  reimburse_amount DECIMAL(10,3) DEFAULT 0,
  reimburse_date DATE,
  reimburse_plan TEXT, -- notes on how/when to claim
  -- Linking
  funder_id INT REFERENCES budget_funders(id),
  related_project TEXT, -- 'Medad', 'Burnout', 'Readmission', etc.
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_publications_status ON publications(pub_status);
CREATE INDEX idx_publications_reimburse ON publications(reimburse_status);

ALTER TABLE publications ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Anyone can read publications" ON publications
  FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "Admin can manage publications" ON publications
  FOR ALL USING (public.is_worklog_admin());

-- Seed publications from known data
INSERT INTO publications (title, journal, authors, pub_status, pub_date, apc_fee, apc_currency, paid_by, paid_date, reimburse_source, reimburse_status, reimburse_amount, reimburse_plan, related_project, notes) VALUES
  ('BMJ Melatonin Trial', 'BMJ', NULL, 'published', NULL, 1233, 'OMR', 'Publication Pool', NULL, 'SQU Pub Support', 'partial', 1000, 'Partial refund 1,000 OMR received from SQU Publication Support', 'Medad', 'Remaining 233 OMR not refunded'),
  ('Advanced ML Prediction', 'MDPI', NULL, 'published', NULL, 714.722, 'OMR', 'Publication Pool', '2026-02-19', 'SQU/Min. of Telecommunication', 'received', 774.322, 'Full refund received (774.322 OMR, overpayment included)', 'Readmission', 'MDPI-AI-readmission paper'),
  ('IMAD Study', 'International Journal', NULL, 'published', '2026-03-09', 1270.995, 'OMR', 'Publication Pool', '2026-03-09', 'TRC', 'applied', 0, 'Applied to TRC for refund — pending response', 'Medad', NULL),
  ('Case Report', 'Journal', NULL, 'published', '2026-04-30', 304.15, 'OMR', 'Publication Pool', '2026-04-30', NULL, 'not_applied', 0, 'No refund source identified', NULL, NULL),
  ('BMC Frailty', 'BMC', NULL, 'submitted', NULL, 0, 'OMR', NULL, NULL, 'SQU Pub Support', 'not_applied', 0, 'Pending — CA: Salim. Will apply to SQU Pub Support if accepted', NULL, NULL),
  ('BMJ Melatonin Protocol', 'BMJ', NULL, 'published', NULL, 1177.267, 'OMR', 'Pre-pool', NULL, 'TRC', 'applied', 0, 'Try refund 2026-27. Pre-pool expense, tracked for refund only.', 'Medad', 'Historical — paid before publication pool was established'),
  ('MDPI AI Readmission', 'Diagnostics (MDPI)', NULL, 'published', NULL, 774.322, 'OMR', 'Pre-pool', NULL, 'OMSB', 'not_applied', 0, 'Not yet applied to OMSB for refund', 'Readmission', 'Historical — pre-pool. BFP/GRG/HSS/24/145');

-- Pool funding sources
INSERT INTO publications (title, journal, pub_status, apc_fee, reimburse_source, reimburse_status, reimburse_amount, reimburse_date, notes) VALUES
  ('POOL: Initial Balance (9 Sep 2025)', 'N/A', 'published', -3947.979, 'Pool Deposit', 'received', 3947.979, '2025-09-09', 'Starting pool balance'),
  ('POOL: OMSB Grant (Said Al Jaddi)', 'N/A', 'published', -1583.6, 'OMSB Grant', 'received', 1583.6, '2026-06-01', 'Publication fund from OMSB grant');

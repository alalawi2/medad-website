-- Migration: Add admin review columns and RLS policy for work_logs
-- Date: 2026-06-06

-- Add review columns
ALTER TABLE work_logs
  ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'pending'
    CHECK (status IN ('pending','approved','amended','rejected')),
  ADD COLUMN IF NOT EXISTS admin_notes TEXT,
  ADD COLUMN IF NOT EXISTS reviewed_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS reviewed_by UUID REFERENCES team_members(id);

-- Backfill existing rows to 'pending'
UPDATE work_logs SET status = 'pending' WHERE status IS NULL;

-- RLS policy: Admin can update any log
CREATE POLICY "Admin can update any log"
  ON work_logs
  FOR UPDATE
  USING (public.is_worklog_admin())
  WITH CHECK (public.is_worklog_admin());

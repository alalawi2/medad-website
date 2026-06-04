-- ============================================
-- SEED: Work Categories & Subcategories
-- ============================================

-- Set sequence to start after our manual IDs
SELECT setval('work_categories_id_seq', 100);

-- Parent categories (explicit IDs)
INSERT INTO work_categories (id, parent_id, name, sort_order) VALUES
  (1, NULL, 'Backend Development', 1),
  (2, NULL, 'Frontend Development', 2),
  (3, NULL, 'Data Pipeline', 3),
  (4, NULL, 'ML/AI Research', 4),
  (5, NULL, 'Annotation & Quality Control', 5),
  (6, NULL, 'Infrastructure & DevOps', 6),
  (7, NULL, 'Research — Systematic Review', 7),
  (8, NULL, 'Research — Meta-Analysis', 8),
  (9, NULL, 'Research — Qualitative Study', 9),
  (10, NULL, 'Research — ASR/NLP Technical Paper', 10),
  (11, NULL, 'Clinical Research — Ethics & IRB', 11),
  (12, NULL, 'Clinical Research — Data Collection', 12),
  (13, NULL, 'Grants & Funding', 13),
  (14, NULL, 'Budget & Finance', 14),
  (15, NULL, 'Project Management', 15),
  (16, NULL, 'Website & Branding', 16),
  (17, NULL, 'Testing & QA', 17);

-- Subcategories (auto IDs starting at 101+)

-- 1. Backend Development
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (1, 'API development (FastAPI routes, endpoints)', 1),
  (1, 'Pipeline orchestration (daemon, stages)', 2),
  (1, 'Authentication & security', 3),
  (1, 'Database schema & migrations', 4),
  (1, 'Training orchestrator', 5),
  (1, 'Payment system logic', 6);

-- 2. Frontend Development
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (2, 'Admin dashboard (React/Vite)', 1),
  (2, 'Annotator web UI', 2),
  (2, 'Marketing website (medad.om)', 3),
  (2, 'Mobile UI optimization', 4),
  (2, 'UX/accessibility improvements', 5);

-- 3. Data Pipeline
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (3, 'YouTube channel discovery & harvesting', 1),
  (3, 'Podcast RSS feed curation', 2),
  (3, 'Video download & audio conversion', 3),
  (3, 'Whisper transcription runs', 4),
  (3, 'LLM validation (Claude/GPT scoring)', 5),
  (3, 'Data export (JSONL, HuggingFace format)', 6);

-- 4. ML/AI Research
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (4, 'Fine-tuning — cloud (RunPod A100)', 1),
  (4, 'Fine-tuning — local (RTX 4090/5080)', 2),
  (4, 'Knowledge distillation (teacher→student)', 3),
  (4, 'LoRA experiments', 4),
  (4, 'Synthetic data generation (TTS)', 5),
  (4, 'WER benchmark evaluation', 6),
  (4, 'Model comparison (vs Whisper/wav2vec2)', 7),
  (4, 'CTranslate2 conversion & optimization', 8);

-- 5. Annotation & Quality Control
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (5, 'Annotation queue management & refill', 1),
  (5, 'Inter-rater agreement scoring', 2),
  (5, 'Spot-check audits (owner QA)', 3),
  (5, 'Honeypot seeding & sabotage detection', 4),
  (5, 'Annotator coaching & retraining', 5),
  (5, 'Dialect re-classification & labeling', 6),
  (5, 'Pseudo-label quality audit', 7),
  (5, 'Suspension & incident investigation', 8);

-- 6. Infrastructure & DevOps
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (6, 'Cloudflare Tunnel setup & maintenance', 1),
  (6, 'Systemd service management', 2),
  (6, 'GPU workstation setup & maintenance', 3),
  (6, 'RunPod cloud provisioning', 4),
  (6, 'Database backups', 5),
  (6, 'Health checks & schema validation', 6),
  (6, 'Monitoring & alerting (cron, watchdog)', 7),
  (6, 'Security hardening', 8);

-- 7. Research — Systematic Review
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (7, 'Protocol development & registration (PROSPERO)', 1),
  (7, 'Literature search strategy (databases, keywords)', 2),
  (7, 'Title & abstract screening', 3),
  (7, 'Full-text review & eligibility assessment', 4),
  (7, 'Data extraction', 5),
  (7, 'Risk of bias assessment', 6),
  (7, 'PRISMA flow diagram & reporting', 7),
  (7, 'Manuscript drafting — methods', 8),
  (7, 'Manuscript drafting — results', 9),
  (7, 'Manuscript drafting — discussion', 10),
  (7, 'Peer review response & revision', 11),
  (7, 'Journal submission & correspondence', 12);

-- 8. Research — Meta-Analysis
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (8, 'Statistical analysis plan', 1),
  (8, 'Effect size extraction & calculation', 2),
  (8, 'Heterogeneity assessment (I², Q-test)', 3),
  (8, 'Forest plot generation', 4),
  (8, 'Subgroup & sensitivity analysis', 5),
  (8, 'Funnel plot & publication bias', 6),
  (8, 'Meta-regression', 7),
  (8, 'Results interpretation & write-up', 8);

-- 9. Research — Qualitative Study
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (9, 'Study design & methodology selection', 1),
  (9, 'Interview/focus group guide development', 2),
  (9, 'Participant recruitment & sampling', 3),
  (9, 'Data collection (interviews, focus groups)', 4),
  (9, 'Transcription of qualitative data', 5),
  (9, 'Thematic analysis / coding', 6),
  (9, 'Member checking & triangulation', 7),
  (9, 'Qualitative findings write-up', 8),
  (9, 'Reflexivity & positionality statement', 9);

-- 10. Research — ASR/NLP Technical Paper
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (10, 'WANLP 2026 paper drafting', 1),
  (10, 'Blueprint report writing', 2),
  (10, 'Dataset card preparation', 3),
  (10, 'Model card preparation', 4),
  (10, 'Benchmark tables & figures', 5),
  (10, 'Literature review (Arabic ASR field)', 6),
  (10, 'Conference submission & review response', 7);

-- 11. Clinical Research — Ethics & IRB
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (11, 'IRB/ethics application preparation', 1),
  (11, 'Research protocol writing', 2),
  (11, 'Informed consent form drafting', 3),
  (11, 'Participant information sheet', 4),
  (11, 'Data collection instruments design', 5),
  (11, 'Ethics amendment / renewal', 6),
  (11, 'IRB correspondence & follow-up', 7),
  (11, 'Ethics committee presentation', 8);

-- 12. Clinical Research — Data Collection
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (12, 'Clinical audio recording protocol', 1),
  (12, 'PHI scrubber development (NER/regex)', 2),
  (12, 'De-identification audit', 3),
  (12, 'Clinical evaluation dataset creation', 4),
  (12, 'Clinician recruitment for recording', 5),
  (12, 'Patient consent & enrollment', 6),
  (12, 'Clinical data cleaning & validation', 7);

-- 13. Grants & Funding
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (13, 'Grant opportunity scouting & eligibility review', 1),
  (13, 'Proposal/application writing', 2),
  (13, 'Budget preparation & justification', 3),
  (13, 'SRP Grant (IG/MRC) — reporting & compliance', 4),
  (13, 'MOHERI/RIA SRP — follow-up & documentation', 5),
  (13, 'NHRC White Paper — drafting & submission', 6),
  (13, 'WISE Prize — application & follow-up', 7),
  (13, 'Phase 3 Grant ($50-100K) — target identification & proposal', 8),
  (13, 'FursaTech partnership coordination', 9),
  (13, 'OTF/Riyada/Al Raffd applications', 10),
  (13, 'Funder communication & meetings', 11),
  (13, 'Grant compliance & progress reporting', 12),
  (13, 'Reimbursement claims & financial reconciliation', 13);

-- 14. Budget & Finance
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (14, 'Hardware procurement & tracking', 1),
  (14, 'Research assistant payments', 2),
  (14, 'AI & software subscriptions (Claude, RunPod)', 3),
  (14, 'Annotator payroll (PayPal processing)', 4),
  (14, 'Cloud compute cost tracking', 5),
  (14, 'Reimbursement claims & follow-up', 6),
  (14, 'Budget tracker updates (Excel/spreadsheet)', 7),
  (14, 'Financial reporting to funders', 8),
  (14, 'Competition prize disbursement', 9),
  (14, 'Invoice & receipt management', 10);

-- 15. Project Management
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (15, 'Team meeting (planning/follow-up)', 1),
  (15, 'Funder/stakeholder meeting', 2),
  (15, 'Annotator kickoff & onboarding session', 3),
  (15, 'Technical planning meeting', 4),
  (15, 'Supervision — annotator performance review', 5),
  (15, 'Supervision — individual coaching & feedback', 6),
  (15, 'Supervision — new team member onboarding', 7),
  (15, 'Recruitment (posting, screening, approving)', 8),
  (15, 'Daily/weekly status reporting', 9),
  (15, 'Milestone progress tracking', 10),
  (15, 'Incident reporting & response', 11),
  (15, 'Integrity/transparency updates to team', 12),
  (15, 'Roadmap updates (Phase 1/2/3)', 13),
  (15, 'Risk assessment & mitigation planning', 14),
  (15, 'Timeline & resource allocation', 15),
  (15, 'Team email drafting (bilingual Ar/En)', 16),
  (15, 'Challenge/competition announcements', 17),
  (15, 'Recognition & awards (badges, certificates)', 18);

-- 16. Website & Branding
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (16, 'Homepage content updates', 1),
  (16, 'Team profile pages (photos, bios)', 2),
  (16, 'News/announcements blog posts', 3),
  (16, 'Join/recruitment page updates', 4),
  (16, 'Domain & DNS management (medad.om)', 5),
  (16, 'Deployment & CI/CD', 6),
  (16, 'Marketing materials & screenshots', 7);

-- 17. Testing & QA
INSERT INTO work_categories (parent_id, name, sort_order) VALUES
  (17, 'End-to-end test automation (Playwright)', 1),
  (17, 'Payment flow testing', 2),
  (17, 'Annotation workflow testing', 3),
  (17, 'Model smoke tests', 4),
  (17, 'Health check script maintenance', 5),
  (17, 'Browser/mobile compatibility testing', 6);

-- ============================================
-- SEED: Team Members (no auth_id yet — linked on first login)
-- ============================================

INSERT INTO team_members (email, display_name, title, specialty, institution, role) VALUES
  ('dr.abdullahalalawi@gmail.com', 'Dr. Abdullah M. Al Alawi', 'Senior Consultant & PI', 'General Internal Medicine', 'SQUH / OMSB', 'admin'),
  (NULL, 'Dr. Mohamed Najeeb Al-Rawahi', 'Cardiac Electrophysiologist', 'Cardiology', 'SQUH / National Heart Center', 'member'),
  (NULL, 'Dr. Salim Al-Busaidi', 'Specialist', 'Internal Medicine', 'SQUH', 'member'),
  (NULL, 'Dr. Muhammad Shoaib', 'Consultant', 'General Internal Medicine', 'SQUH', 'member'),
  (NULL, 'Dr. Zubaida Al Falahi', 'Consultant', 'Acute Care & General Medicine', 'SQUH', 'member'),
  (NULL, 'Dr. Tamadhir Al-Mahrouqi', 'Physician', 'Psychiatry', 'SQUH', 'member'),
  (NULL, 'Dr. Kawthar Al Lawati', 'Resident', 'Internal Medicine', 'OMSB', 'member'),
  (NULL, 'Dr. Hour Al Kaabi', 'Specialist', 'Internal Medicine', 'MCMSS', 'member'),
  (NULL, 'Dr. Noor Alkaabi', 'Resident', 'Internal Medicine', 'OMSB', 'member'),
  (NULL, 'Mohammed Al Habsi', 'Medical Student', 'Research', 'SQU', 'member'),
  (NULL, 'Afra Albadi', 'AI Engineer', 'Computer Science / ML', 'GUtech', 'member'),
  (NULL, 'Dawood Al Amri', 'Staff Nurse', 'Adult & Critical Care Nursing', 'SQUH/UMC', 'member'),
  (NULL, 'Dr. Nasiba Al Maqrashi', 'Specialist', 'Haematology', NULL, 'member');

-- ============================================
-- SEED: Hour Estimation Guides
-- ============================================

INSERT INTO hour_guides (category_id, activity_example, typical_hours, notes) VALUES
  ((SELECT id FROM work_categories WHERE name = 'IRB/ethics application preparation' AND parent_id IS NOT NULL), 'Preparing full IRB submission package', '8-16 hours', 'Include form filling, supporting documents, protocol summary'),
  ((SELECT id FROM work_categories WHERE name = 'Research protocol writing' AND parent_id IS NOT NULL), 'Writing research protocol from scratch', '10-20 hours', 'Include literature review time for background section'),
  ((SELECT id FROM work_categories WHERE name = 'Informed consent form drafting' AND parent_id IS NOT NULL), 'Drafting bilingual consent form', '3-6 hours', 'Arabic + English versions, institution template adaptation'),
  ((SELECT id FROM work_categories WHERE name = 'Ethics amendment / renewal' AND parent_id IS NOT NULL), 'Annual renewal or minor amendment', '2-4 hours', 'Major amendments may take 6-10 hours'),
  ((SELECT id FROM work_categories WHERE name = 'IRB correspondence & follow-up' AND parent_id IS NOT NULL), 'Responding to ethics committee queries', '1-3 hours', 'Per round of revision'),
  ((SELECT id FROM work_categories WHERE name = 'Ethics committee presentation' AND parent_id IS NOT NULL), 'Preparing and presenting to committee', '2-4 hours', 'Include prep + presentation time'),
  ((SELECT id FROM work_categories WHERE name = 'Proposal/application writing' AND parent_id IS NOT NULL), 'Writing full grant proposal', '15-40 hours', 'Depends on complexity; include drafts + revisions'),
  ((SELECT id FROM work_categories WHERE name = 'Budget preparation & justification' AND parent_id IS NOT NULL), 'Detailed budget with justification', '4-8 hours', 'Include quotes, salary calculations, equipment lists'),
  ((SELECT id FROM work_categories WHERE name = 'Funder communication & meetings' AND parent_id IS NOT NULL), 'Single meeting + prep + follow-up', '1-3 hours', 'Include email drafting and scheduling'),
  ((SELECT id FROM work_categories WHERE name = 'Grant compliance & progress reporting' AND parent_id IS NOT NULL), 'Quarterly progress report', '3-6 hours', 'Include metrics gathering + narrative'),
  ((SELECT id FROM work_categories WHERE name = 'Reimbursement claims & financial reconciliation' AND parent_id IS NOT NULL), 'Processing receipts + claim form', '1-2 hours', 'Per batch of claims'),
  ((SELECT id FROM work_categories WHERE name = 'Team meeting (planning/follow-up)' AND parent_id IS NOT NULL), 'Weekly team meeting', '1-2 hours', 'Include prep (agenda) + meeting + minutes'),
  ((SELECT id FROM work_categories WHERE name = 'Funder/stakeholder meeting' AND parent_id IS NOT NULL), 'Meeting with funder/partner', '2-4 hours', 'Include preparation, travel, meeting, follow-up email'),
  ((SELECT id FROM work_categories WHERE name = 'Technical planning meeting' AND parent_id IS NOT NULL), 'Architecture/sprint planning', '1-3 hours', 'Include pre-reading and action items'),
  ((SELECT id FROM work_categories WHERE name LIKE 'Supervision — annotator performance%' AND parent_id IS NOT NULL), 'Reviewing annotator quality metrics', '1-2 hours', 'Per annotator per month'),
  ((SELECT id FROM work_categories WHERE name LIKE 'Supervision — individual%' AND parent_id IS NOT NULL), 'One-on-one coaching session', '0.5-1 hours', 'Include feedback email drafting'),
  ((SELECT id FROM work_categories WHERE name LIKE 'Supervision — new team%' AND parent_id IS NOT NULL), 'Full onboarding for new member', '3-5 hours', 'Account setup, guidelines walkthrough, first tasks'),
  ((SELECT id FROM work_categories WHERE name = 'Literature search strategy (databases, keywords)' AND parent_id IS NOT NULL), 'Designing search for systematic review', '4-8 hours', 'PubMed, Embase, Cochrane — include piloting'),
  ((SELECT id FROM work_categories WHERE name = 'Title & abstract screening' AND parent_id IS NOT NULL), 'Screening batch of abstracts', '0.5 hours per 50 abstracts', 'Use Rayyan or Covidence; log actual time'),
  ((SELECT id FROM work_categories WHERE name = 'Full-text review & eligibility assessment' AND parent_id IS NOT NULL), 'Full-text assessment batch', '1 hour per 10-15 articles', 'Include data extraction form pilot'),
  ((SELECT id FROM work_categories WHERE name = 'Data extraction' AND parent_id = 7), 'Extracting data from included studies', '0.5-1 hour per study', 'Depends on complexity of outcomes'),
  ((SELECT id FROM work_categories WHERE name = 'Risk of bias assessment' AND parent_id IS NOT NULL), 'RoB assessment per study', '20-30 min per study', 'Cochrane RoB 2.0 or NOS'),
  ((SELECT id FROM work_categories WHERE name = 'Budget tracker updates (Excel/spreadsheet)' AND parent_id IS NOT NULL), 'Monthly budget reconciliation', '1-2 hours', 'Match receipts to tracker, update balances'),
  ((SELECT id FROM work_categories WHERE name = 'Hardware procurement & tracking' AND parent_id IS NOT NULL), 'Sourcing + ordering equipment', '2-4 hours', 'Include price comparison + approval process'),
  ((SELECT id FROM work_categories WHERE name = 'Homepage content updates' AND parent_id IS NOT NULL), 'Content refresh + deploy', '1-3 hours', 'Include writing, screenshots, testing'),
  ((SELECT id FROM work_categories WHERE name = 'Domain & DNS management (medad.om)' AND parent_id IS NOT NULL), 'DNS/tunnel configuration change', '0.5-2 hours', 'Include testing + verification');

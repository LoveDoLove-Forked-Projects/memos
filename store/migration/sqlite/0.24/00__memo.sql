-- Drop deprecated tags column.
ALTER TABLE memo DROP COLUMN tags;

-- Remove deprecated indexes.
DROP INDEX IF EXISTS idx_memo_tags;
DROP INDEX IF EXISTS idx_memo_content;
DROP INDEX IF EXISTS idx_memo_visibility;

-- Add pinned column.
ALTER TABLE memo ADD COLUMN pinned INTEGER NOT NULL CHECK (pinned IN (0, 1)) DEFAULT 0;

-- Update pinned column from memo_organizer.
UPDATE memo
SET pinned = 1
FROM memo_organizer
WHERE memo.id = memo_organizer.memo_id AND memo_organizer.pinned = 1;
-- Run this once in the Neon SQL editor (or via psql) to set up your database.

CREATE TABLE IF NOT EXISTS users (
  mobile      VARCHAR(15) PRIMARY KEY,
  name        TEXT NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS items (
  id          BIGSERIAL PRIMARY KEY,
  mobile      VARCHAR(15) NOT NULL REFERENCES users(mobile) ON DELETE CASCADE,
  name        TEXT NOT NULL,
  category    TEXT NOT NULL DEFAULT 'Kitchen',
  qty         NUMERIC NOT NULL DEFAULT 1,
  unit        TEXT NOT NULL DEFAULT 'packet',
  price       NUMERIC,
  checked     BOOLEAN NOT NULL DEFAULT false,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_items_mobile ON items(mobile);

-- Prevent exact duplicate product names per user (mirrors the app's own dedupe logic)
CREATE UNIQUE INDEX IF NOT EXISTS uq_items_mobile_name
  ON items (mobile, LOWER(name));

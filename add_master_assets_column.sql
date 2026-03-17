-- Migration: Add master_assets column to campaigns table
-- Run this in the Supabase SQL editor

ALTER TABLE public.campaigns
ADD COLUMN IF NOT EXISTS master_assets jsonb DEFAULT '[]'::jsonb;

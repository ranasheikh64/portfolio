-- Run this in Supabase SQL Editor to migrate the table
ALTER TABLE public.projects 
DROP COLUMN image_url,
ADD COLUMN image_urls text[] DEFAULT '{}';

ALTER TABLE public.projects
ADD COLUMN technologies text[] DEFAULT '{}',
ADD COLUMN date text;

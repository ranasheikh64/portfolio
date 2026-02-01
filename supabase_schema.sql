-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- 1. Projects Table
create table if not exists public.projects (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  category text,
  image_urls text[], -- Changed from single url to array
  description text,
  link text,
  technologies text[],
  date text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 2. Messages Table
create table if not exists public.messages (
  id uuid primary key default uuid_generate_v4(),
  sender_name text not null,
  content text not null,
  timestamp text, -- or use created_at
  is_read boolean default false,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 3. CVs Table (Stores the complex CV object as JSON)
create table if not exists public.cvs (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  template_id text not null,
  data jsonb not null, -- Stores PersonalInfo, Experience[], Education[]
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Row Level Security (RLS) Setup
alter table public.projects enable row level security;
alter table public.messages enable row level security;
alter table public.cvs enable row level security;

-- Policies

-- Projects: Everyone can view, only Admin (Authenticated) can edit
create policy "Public Projects Read" 
on public.projects for select 
using (true);

create policy "Admin Projects Write" 
on public.projects for all 
using (auth.role() = 'authenticated');

-- Messages: Everyone can insert (send), only Admin can view/edit
create policy "Public Messages Insert" 
on public.messages for insert 
with check (true);

create policy "Admin Messages Read/Write" 
on public.messages for all 
using (auth.role() = 'authenticated');

-- CVs: Only Admin can do anything
create policy "Admin CVs All" 
on public.cvs for all 
using (auth.role() = 'authenticated');

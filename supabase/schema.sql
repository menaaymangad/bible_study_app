-- Bible School MVP — Initial Schema (T01)
-- Run this in your Supabase SQL Editor.

-- Academic years (needed for profiles.academic_year_id FK)
create table if not exists academic_years (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_at timestamptz not null default now()
);

-- Profiles: linked to auth.users, carries role and display info
create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  name text not null,
  username text not null unique,
  role text not null check (role in ('admin', 'student')),
  academic_year_id uuid references academic_years(id),
  created_at timestamptz not null default now()
);

-- RLS: users can only read their own profile
alter table profiles enable row level security;

create policy "Users can view own profile"
  on profiles for select
  using (auth.uid() = id);

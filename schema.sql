-- Execute este arquivo no SQL Editor do Supabase.

create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  created_at timestamptz not null default now()
);

create table if not exists public.salaries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  value numeric(12,2) not null,
  date date not null,
  note text,
  created_at timestamptz not null default now()
);

create table if not exists public.extra_incomes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  value numeric(12,2) not null,
  date date not null,
  note text,
  created_at timestamptz not null default now()
);

create table if not exists public.expenses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  client_temp_id text,
  recurring_group_id text,
  name text not null,
  category text not null,
  value numeric(12,2) not null,
  date date not null,
  repeat text not null default 'nao',
  note text,
  generated_recurring boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists public.investments (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  type text not null,
  name text not null,
  value numeric(12,2) not null,
  qty numeric(14,4) default 0,
  price numeric(14,4) default 0,
  date date not null,
  note text,
  created_at timestamptz not null default now()
);

create table if not exists public.goals (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null,
  target numeric(12,2) not null,
  current numeric(12,2) not null default 0,
  start_date date not null,
  end_date date not null,
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.salaries enable row level security;
alter table public.extra_incomes enable row level security;
alter table public.expenses enable row level security;
alter table public.investments enable row level security;
alter table public.goals enable row level security;

create policy if not exists "profiles_select_own" on public.profiles for select using (auth.uid() = id);
create policy if not exists "profiles_insert_own" on public.profiles for insert with check (auth.uid() = id);
create policy if not exists "profiles_update_own" on public.profiles for update using (auth.uid() = id);

create policy if not exists "salaries_all_own" on public.salaries for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy if not exists "extra_incomes_all_own" on public.extra_incomes for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy if not exists "expenses_all_own" on public.expenses for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy if not exists "investments_all_own" on public.investments for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy if not exists "goals_all_own" on public.goals for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create index if not exists salaries_user_date_idx on public.salaries(user_id, date desc);
create index if not exists extra_incomes_user_date_idx on public.extra_incomes(user_id, date desc);
create index if not exists expenses_user_date_idx on public.expenses(user_id, date desc);
create index if not exists investments_user_date_idx on public.investments(user_id, date desc);
create index if not exists goals_user_created_idx on public.goals(user_id, created_at desc);

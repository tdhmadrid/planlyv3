-- ═══════════════════════════════════════════════════════════
--  FLUJO — Supabase setup CON autenticación por usuario
--  Ejecuta esto en: SQL Editor → New query → Run
-- ═══════════════════════════════════════════════════════════

-- 1. Limpiar tablas anteriores si existen
drop table if exists public.flujo_personal;
drop table if exists public.flujo_data;

-- 2. Tabla de datos por usuario
create table public.flujo_data (
  user_id    uuid        primary key references auth.users(id) on delete cascade,
  data       jsonb       not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- 3. Row Level Security — cada usuario solo ve sus propios datos
alter table public.flujo_data enable row level security;

create policy "Select own data"
  on public.flujo_data for select
  to authenticated
  using (auth.uid() = user_id);

create policy "Insert own data"
  on public.flujo_data for insert
  to authenticated
  with check (auth.uid() = user_id);

create policy "Update own data"
  on public.flujo_data for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy "Delete own data"
  on public.flujo_data for delete
  to authenticated
  using (auth.uid() = user_id);

-- 4. Trigger updated_at
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end;
$$;

drop trigger if exists flujo_data_updated_at on public.flujo_data;
create trigger flujo_data_updated_at
  before update on public.flujo_data
  for each row execute procedure public.set_updated_at();

-- ═══════════════════════════════════════════════════════════
--  ✓ Listo. Cada usuario tendrá sus propios datos aislados.
-- ═══════════════════════════════════════════════════════════

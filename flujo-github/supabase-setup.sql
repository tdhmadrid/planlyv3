-- ══════════════════════════════════════════════════════════
-- FLUJO — Setup inicial de Supabase
-- Ejecuta este script en: SQL Editor → New query → Run
-- ══════════════════════════════════════════════════════════

-- 1. Tabla principal (un registro por usuario)
create table if not exists public.flujo_data (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  data       jsonb not null default '{}',
  updated_at timestamptz default now()
);

-- 2. Row Level Security — cada usuario solo ve y edita su fila
alter table public.flujo_data enable row level security;

drop policy if exists "Cada usuario gestiona sus datos" on public.flujo_data;
create policy "Cada usuario gestiona sus datos"
  on public.flujo_data for all
  using  (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- 3. Índice en updated_at (útil para futuros backups/sync)
create index if not exists flujo_data_updated_at_idx
  on public.flujo_data (updated_at desc);

-- ✓ Listo. Verifica en Table Editor que existe la tabla flujo_data.

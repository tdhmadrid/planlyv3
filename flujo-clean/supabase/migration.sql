-- ═══════════════════════════════════════════════════════════
--  FLUJO — Supabase migration (modo sin login / personal)
--  Ejecuta esto en: Supabase Dashboard → SQL Editor → New query
-- ═══════════════════════════════════════════════════════════

-- 1. Borrar tabla anterior si existe (cambia el tipo de user_id)
drop table if exists public.flujo_data;

-- 2. Tabla principal de datos (user_id es texto, no UUID de auth)
create table public.flujo_data (
  user_id    text         primary key,
  data       jsonb        not null default '{}'::jsonb,
  updated_at timestamptz  not null default now()
);

-- 3. Índice
create index flujo_data_user_id_idx on public.flujo_data(user_id);

-- 4. Sin Row Level Security — acceso con anon key directamente
alter table public.flujo_data disable row level security;

-- 5. Permisos para la clave anónima de Supabase
grant all on public.flujo_data to anon;
grant all on public.flujo_data to authenticated;

-- 6. Trigger para updated_at automático
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger flujo_data_updated_at
  before update on public.flujo_data
  for each row execute procedure public.set_updated_at();

-- ═══════════════════════════════════════════════════════════
--  ✓ Listo. El app guarda con user_id = 'flujo-owner-personal'
--  No requiere login — cualquier dispositivo con la URL accede.
-- ═══════════════════════════════════════════════════════════

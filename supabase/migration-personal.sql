-- ═══════════════════════════════════════════════════════════
--  FLUJO — Migración sin autenticación (uso personal)
--  Ejecuta esto en: Supabase Dashboard → SQL Editor → New query
--
--  ⚠️  Si ya tienes la tabla de una versión anterior,
--      ejecuta primero el bloque "RESET" comentado al final.
-- ═══════════════════════════════════════════════════════════

-- 1. Tabla de datos (id de texto — no depende de auth.users)
create table if not exists public.flujo_personal (
  id         text         primary key default 'owner',
  data       jsonb        not null default '{}'::jsonb,
  updated_at timestamptz  not null default now()
);

-- 2. Desactivar RLS — tabla personal, acceso directo con anon key
alter table public.flujo_personal disable row level security;

-- 3. Permisos explícitos para el rol anon (clave pública del cliente)
grant select, insert, update, delete
  on public.flujo_personal
  to anon;

-- 4. Insertar fila inicial para evitar errores en primer uso
insert into public.flujo_personal (id, data)
values ('owner', '{}'::jsonb)
on conflict (id) do nothing;

-- 5. Trigger para actualizar updated_at automáticamente
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists flujo_personal_updated_at on public.flujo_personal;
create trigger flujo_personal_updated_at
  before update on public.flujo_personal
  for each row execute procedure public.set_updated_at();

-- ═══════════════════════════════════════════════════════════
--  ✓ Listo. La tabla flujo_personal permite lectura y escritura
--    directa desde el navegador sin necesidad de login.
-- ═══════════════════════════════════════════════════════════


-- ── RESET (opcional) ────────────────────────────────────────
-- Si quieres empezar desde cero borrando datos anteriores:
--
--   drop table if exists public.flujo_personal;
--   drop table if exists public.flujo_data;
-- ────────────────────────────────────────────────────────────

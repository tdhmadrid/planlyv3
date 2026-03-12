-- ═══════════════════════════════════════════════════════════
--  FLUJO — Supabase setup SIN autenticación
--  Tabla personal de acceso público (solo tú usas la app)
--
--  Ejecuta esto en:
--  Supabase Dashboard → SQL Editor → New query → Run
-- ═══════════════════════════════════════════════════════════

-- 1. Eliminar tabla anterior si existe (versión con auth)
drop table if exists public.flujo_data;

-- 2. Crear tabla personal sin restricciones de usuario
create table if not exists public.flujo_personal (
  id          text        primary key default 'owner',
  data        jsonb       not null default '{}'::jsonb,
  updated_at  timestamptz not null default now()
);

-- 3. Habilitar RLS (requerido por Supabase)
alter table public.flujo_personal enable row level security;

-- 4. Política: acceso total para el rol anon (la app usa anon key)
drop policy if exists "Acceso personal anon" on public.flujo_personal;
create policy "Acceso personal anon"
  on public.flujo_personal
  for all
  to anon
  using (id = 'owner')
  with check (id = 'owner');

-- 5. Trigger para updated_at automático
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

-- 6. Insertar fila inicial
insert into public.flujo_personal (id, data)
values ('owner', '{}'::jsonb)
on conflict (id) do nothing;

-- ═══════════════════════════════════════════════════════════
--  ✓ Listo. La app puede leer y escribir sin login.
-- ═══════════════════════════════════════════════════════════

# 💰 Flujo — Finanzas Personales

App de finanzas personales multi-moneda con sincronización en la nube.

**Stack:** HTML + CSS + JS vanilla (sin build tools) · Supabase (auth + DB) · Netlify

---

## 🚀 Deploy en 3 pasos

### Paso 1 — Supabase: crear la tabla

En tu proyecto Supabase → **SQL Editor** → ejecuta:

```sql
create table if not exists public.flujo_data (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  data       jsonb not null default '{}',
  updated_at timestamptz default now()
);

alter table public.flujo_data enable row level security;

create policy "Cada usuario gestiona sus datos"
  on public.flujo_data for all
  using  (auth.uid() = user_id)
  with check (auth.uid() = user_id);
```

### Paso 2 — Netlify: conectar GitHub

1. [app.netlify.com](https://app.netlify.com) → **Add new site → Import from Git**
2. Selecciona este repositorio
3. Build command: **(vacío)**
4. Publish directory: **`.`** (punto)
5. **Deploy site** ✓

### Paso 3 — Supabase: configurar la URL de la app

1. Supabase → **Authentication → URL Configuration**
2. **Site URL:** `https://TU-SITIO.netlify.app`
3. **Redirect URLs:** `https://TU-SITIO.netlify.app/**`
4. Guardar ✓

---

## 🔑 Credenciales Supabase

Las credenciales están al inicio de `index.html` — ya vienen configuradas con el proyecto activo:

```js
const SUPABASE_URL  = 'https://wmxbvxhitediopkanujv.supabase.co';
const SUPABASE_ANON = 'eyJ...';  // clave pública (anon), segura en el frontend
```

Si quieres usar **otro proyecto Supabase**, reemplaza esos dos valores con los de  
**Project Settings → API → Project URL** y **anon/public key**.

---

## 🏗️ Arquitectura

```
Usuario abre la app
      ↓
bootApp() — verifica sesión existente en Supabase
      ↓
¿Hay sesión? → SÍ → pullDataFromSupabase() → refresh() → app lista
             → NO → Pantalla de login
                         ↓
             Email + contraseña → signIn / signUp
                         ↓
             _onSession() → pullDataFromSupabase() → refresh()
```

**Guardado:**  
`saveData(d)` actualiza el cache en memoria + espera 700 ms (debounce) antes de hacer `upsert` en Supabase. Cada usuario tiene exactamente **1 fila** con todos sus datos como JSONB.

**Seguridad:**  
Row Level Security (RLS) activo — cada usuario solo puede leer y escribir su propia fila. La `anon key` es segura en el frontend.

---

## ✨ Funcionalidades

- 11 monedas fiat + 12 criptomonedas
- Cuentas multi-moneda con traspasos FX
- Tarjetas de crédito con seguimiento de cargos
- Presupuestos mensuales
- Metas de ahorro (con generación desde calculadora hipotecaria)
- Inversiones
- Suscripciones recurrentes
- Panel de divisas con tasas en vivo
- Sección de Propiedad / Hipotecas
- Backup JSON exportable / importable
- 10 temas visuales + editor de tema personalizado
- Reportes PDF mensuales

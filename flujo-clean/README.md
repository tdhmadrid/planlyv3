# 💰 Flujo — Finanzas Personales

App de finanzas personales multi-moneda, **sin login**, con sincronización automática en la nube vía Supabase. Funciona igual en todos tus dispositivos.

## ✨ Características

- **Multi-moneda** — 11 fiat + 12 criptomonedas
- **Cuentas & Transferencias** — FX automático entre monedas
- **Tarjetas de crédito** — gestión de gastos y pagos
- **Presupuestos** — seguimiento mensual por categoría
- **Metas de ahorro** — con progreso visual
- **Inversiones** — portafolio básico
- **Suscripciones** — control de cobros recurrentes
- **Propiedad / Hipotecas** — calculadora y registro
- **Reportes PDF** — exportación completa
- **10 temas** — editor de tema personalizado
- **Backup JSON** — exportar/importar datos completos
- **Sync automático** — guarda en Supabase cada vez que hay cambios

## 🚀 Deploy (GitHub Pages — gratis)

### Paso 1: Base de datos Supabase

1. Ve a tu proyecto en [supabase.com](https://supabase.com)
2. **SQL Editor → New query**
3. Pega el contenido de `supabase/migration.sql` y ejecuta

### Paso 2: Subir a GitHub

```bash
# En la carpeta del proyecto:
git init
git add .
git commit -m "feat: Flujo app"

# Crea repo en github.com/new, luego:
git remote add origin https://github.com/TU_USUARIO/flujo-app.git
git branch -M main
git push -u origin main
```

### Paso 3: Activar GitHub Pages

1. Ve a **Settings → Pages** en tu repo
2. Source: **GitHub Actions**
3. Tu app estará en `https://TU_USUARIO.github.io/flujo-app/`

> Cada `git push` actualiza la app automáticamente.

## 🔐 Sin login — ¿cómo funciona?

La app no tiene pantalla de login. Al abrirla carga los datos directamente desde Supabase usando un identificador fijo (`flujo-owner-personal`). Los datos se guardan automáticamente en la nube cada vez que haces un cambio.

**¿Es seguro?** La URL de tu app es la "contraseña". Quien conozca la URL puede ver tus datos. Si quieres más seguridad, mantén el repo en **privado** y no compartas la URL.

## 📁 Estructura del proyecto

```
flujo-app/
├── index.html              ← App completa (409KB, single-file)
├── supabase/
│   └── migration.sql       ← Ejecutar en Supabase SQL Editor
├── .github/workflows/
│   └── deploy.yml          ← CI/CD automático para GitHub Pages
├── netlify.toml            ← Config para Netlify (alternativa)
├── vercel.json             ← Config para Vercel (alternativa)
└── README.md
```

## 📊 Tecnologías

- **Frontend**: HTML + CSS + JavaScript vanilla (sin frameworks)
- **Backend/DB**: Supabase (PostgreSQL)
- **Charts**: Chart.js
- **PDF**: jsPDF
- **FX Rates**: Open Exchange Rates (API pública)
- **Fuentes**: Playfair Display + DM Sans + DM Mono

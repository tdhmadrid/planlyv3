# 💰 Flujo — Finanzas Personales

App personal de finanzas. Sin login. Datos sincronizados automáticamente entre dispositivos via Supabase.

## 🚀 Setup (una sola vez)

### 1. Configurar Supabase

1. Ve a [supabase.com](https://supabase.com) → tu proyecto
2. Abre **SQL Editor → New query**
3. Pega el contenido de `supabase/migration.sql` y haz clic en **Run**

Eso es todo del lado de Supabase.

### 2. Subir a GitHub Pages

```bash
# En la carpeta del proyecto:
git init
git add .
git commit -m "Flujo app"
git remote add origin https://github.com/TU_USUARIO/flujo-app.git
git push -u origin main
```

Luego en GitHub: **Settings → Pages → Source: GitHub Actions**

Tu app quedará en: `https://TU_USUARIO.github.io/flujo-app/`

### Otras opciones de deploy

**Netlify** — arrastra la carpeta a [netlify.com/drop](https://netlify.com/drop)  
**Vercel** — `npx vercel --prod` desde la carpeta

---

## ✅ Cómo funciona

- Abres la URL → carga tus datos → listo, sin login
- Los cambios se guardan automáticamente en Supabase (indicador en la barra lateral)
- Funciona igual en móvil, tablet y ordenador

## 📁 Archivos

```
flujo-app/
├── index.html              ← App completa
├── supabase/
│   └── migration.sql       ← Ejecutar en Supabase una vez
├── .github/workflows/
│   └── deploy.yml          ← Deploy automático a GitHub Pages
├── netlify.toml
└── vercel.json
```

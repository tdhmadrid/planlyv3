#!/bin/bash
# ═══════════════════════════════════════════════════════════
#  Flujo — Script de inicialización para GitHub
#  Ejecuta este script UNA VEZ en tu máquina local
# ═══════════════════════════════════════════════════════════

set -e

echo "🚀 Inicializando repositorio Flujo..."

# 1. Init git
git init
git add .
git commit -m "feat: initial commit — Flujo finanzas personales"

# 2. Crear repo en GitHub (requiere GitHub CLI)
if command -v gh &> /dev/null; then
    echo "📦 Creando repositorio en GitHub..."
    gh repo create flujo-app --private --source=. --remote=origin --push
    echo "✅ Repo creado y código subido"
    echo ""
    echo "🌐 Para activar GitHub Pages:"
    echo "   1. Ve a https://github.com/$(gh api user --jq .login)/flujo-app/settings/pages"
    echo "   2. Source: GitHub Actions"
    echo "   3. El workflow se ejecutará automáticamente"
else
    echo "⚠️  GitHub CLI no encontrado. Pasos manuales:"
    echo ""
    echo "   1. Crea un repo en https://github.com/new"
    echo "      - Nombre: flujo-app"
    echo "      - Privado (recomendado)"
    echo ""
    echo "   2. Conecta y sube:"
    echo "      git remote add origin https://github.com/TU_USUARIO/flujo-app.git"
    echo "      git branch -M main"
    echo "      git push -u origin main"
    echo ""
    echo "   3. Activa GitHub Pages:"
    echo "      Settings → Pages → Source: GitHub Actions"
fi

echo ""
echo "✅ Listo. Tu app Flujo estará disponible en:"
echo "   https://TU_USUARIO.github.io/flujo-app/"

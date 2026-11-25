#!/usr/bin/env bash
set -euo pipefail

python -m pip install --upgrade pip
python -m pip install -r requirements.txt

if [ ! -f .env ]; then
  cp .env.example .env
fi

mkdir -p sessions static/fotos

printf '%s\n' "Codespace listo: edita .env con SUPABASE_URL y SUPABASE_KEY."
printf '%s\n' "Ejecuta sql/schema.sql en el SQL Editor de Supabase antes de iniciar la app."

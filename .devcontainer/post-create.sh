#!/usr/bin/env bash
set -euo pipefail

python -m pip install --upgrade pip
python -m pip install -r requirements.txt

if [ ! -f .env ]; then
  cp .env.example .env
fi

mkdir -p sessions

printf '%s\n' "Codespace listo: edita .env con SUPABASE_URL y SUPABASE_KEY."

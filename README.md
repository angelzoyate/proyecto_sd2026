# proyecto_sd2026

Configuración base, sin código de aplicación, para una aplicación web con este stack. El dominio del proyecto se define después.

## Stack

- Python 3.12, web.py 0.62, supabase 2.34.0, python-dotenv 1.2.4
- HTML5 / CSS3 / JavaScript vanilla, plantillas con `web.template.render`
- Supabase Auth (email/password) y Supabase Database (PostgreSQL)
- Sesiones persistentes validadas contra `sesiones_abiertas` y URLs firmadas `id:HASH` (HMAC-SHA256)

## Archivos incluidos

```
.
├── .devcontainer/
│   ├── devcontainer.json
│   └── post-create.sh
├── .env.example
├── .gitignore
├── LICENSE
├── README.md
└── requirements.txt
```

`.env` se crea localmente y no se versiona. Las carpetas de aplicación (`controllers/`, `models/`, `views/`, `security/`, `static/`) se crean cuando se defina el proyecto.

## GitHub Codespaces

1. En GitHub: **Code > Codespaces > Create codespace on main**.
2. El contenedor usa Python 3.12, instala `requirements.txt`, copia `.env.example` a `.env` si no existe y abre el puerto 8080.
3. Edita `.env` con las credenciales reales.

## Entorno local equivalente

```bash
uv venv --python 3.12 .venv
uv pip install -r requirements.txt
cp .env.example .env
```

Activa el entorno con `source .venv/bin/activate` y rellena `.env`.

## Supabase

- Copia el Project URL y la anon key de **Project Settings > API** a `SUPABASE_URL` y `SUPABASE_KEY` en `.env`.
- Habilita Email/Password en **Authentication > Providers** y crea el usuario de acceso.
- Crea la tabla `sesiones_abiertas` con una columna `token` de texto obligatoria para guardar los JWT vigentes.
- El esquema del dominio se crea cuando se defina el proyecto.

## Convenciones del stack

- Un controlador por acción, con `logger = logging.getLogger(__name__)`, tipado estático y bloques `try/except` numerados si aplica.
- Toda ruta privada valida sesión activa y token vigente en `sesiones_abiertas` antes de ejecutarse; si falla, redirige a `/login`.
- Ningún identificador numérico se expone sin firma: siempre `id:HASH` con HMAC-SHA256, calculado en memoria con la clave secreta del servidor, sin modificar la llave primaria en la base de datos.
- El acceso a Supabase se hace desde el modelo con consultas parametrizadas.

Cuando se defina el proyecto, crea `app.py` con las rutas y ejecuta `python app.py` (o `uv run python app.py`).

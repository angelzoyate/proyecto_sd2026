# Agenda v23.11.2026.2

Scaffold configurado (sin código de aplicación) para la aplicación web segura con MVC + web.py + Supabase.

## Stack

- Python 3.12, web.py 0.62, supabase 2.34.0, python-dotenv 1.2.4
- HTML5 / CSS3 / JavaScript vanilla, plantillas con `web.template.render`
- Autenticación Supabase (email/password), sesiones validadas contra `sesiones_abiertas`
- URLs firmadas `id_contacto:HASH` (HMAC-SHA256) contra IDOR

## Estructura preparada

```
.
├── .devcontainer/          # Configuración de GitHub Codespaces
│   ├── devcontainer.json
│   └── post-create.sh
├── controllers/            # login, cerrar_sesion, index, lista_contactos,
│                           # ver_contacto, insertar_contacto,
│                           # actualizar_contacto, borrar_contacto
├── models/                 # contactos, sesiones y cliente Supabase
├── security/               # firma HMAC y validación de sesión
├── views/                  # plantillas .html
├── static/
│   ├── css/
│   ├── js/
│   └── fotos/              # imágenes locales (default.png la agregas tú)
├── sql/schema.sql          # tablas contactos y sesiones_abiertas + RLS
├── .env.example
├── requirements.txt
└── app.py                  # punto de entrada a crear
```

Las carpetas contienen solo `.gitkeep`: el código lo escribes tú.

## GitHub Codespaces

1. En GitHub: **Code > Codespaces > Create codespace on main**.
2. El contenedor usa Python 3.12, instala `requirements.txt`, copia `.env.example` a `.env` si no existe y abre el puerto 8080.
3. Edita `.env` con las credenciales reales y ejecuta `sql/schema.sql` en el SQL Editor de Supabase.

## Entorno local equivalente

```bash
uv venv --python 3.12 .venv
uv pip install -r requirements.txt
cp .env.example .env
```

Activa el entorno con `source .venv/bin/activate` y rellena `.env`.

## Supabase

Ejecuta `sql/schema.sql` en el SQL Editor. Crea:

- `contactos`: `id_contacto`, `nombre`, `email`, `telefono`, `foto`.
- `sesiones_abiertas`: `token` (token JWT vigente de cada sesión).

Copia de **Project Settings > API** el Project URL y la anon key a `SUPABASE_URL` y `SUPABASE_KEY` en `.env`. `.env` está ignorado por Git.

Habilita Email/Password en **Authentication > Providers** y crea el usuario con el que vas a entrar.

## Convenciones para el código

- Un controlador por acción, con `logger = logging.getLogger(__name__)`, tipado estático y bloques `try/except` numerados si aplica.
- Toda ruta privada valida sesión activa y token vigente en `sesiones_abiertas` antes de renderizar; si falla, redirige a `/login`.
- Ningún `id_contacto` viaja solo en la URL: siempre `id:HASH` con HMAC-SHA256.
- Sube imágenes a `static/fotos/` con prefijo de timestamp y extensiones `.jpg`, `.jpeg`, `.png`, `.webp`; borra el archivo físico al actualizar la foto o eliminar el contacto, omitiendo `default.png`.
- Mensajes exigidos por la especificación: `Credenciales incorrectas, verifique sus datos`, `Contacto no encontrado`, `Contacto insertado correctamente`, `Contacto actualizado correctamente`, `Contacto eliminado correctamente`.

Cuando crees `app.py`, registra las rutas de los ocho controladores y ejecuta `python app.py` (o `uv run python app.py`).

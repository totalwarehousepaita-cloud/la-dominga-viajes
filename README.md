# La Dominga · Control de viajes funcional

Esta versión usa:

- **GitHub Pages** para publicar el sitio.
- **Supabase** como base de datos central y servicio Realtime.
- **Supabase Storage** para evidencias fotográficas.

## Qué funciona

El dueño puede crear varios viajes y copiar un enlace exclusivo. El transportista puede abrir ese enlace desde otro teléfono o computadora, completar las 8 etapas, registrar horarios, temperaturas, controles, incidencias y fotografías. El panel del dueño se actualiza desde la base de datos y recibe los cambios mediante Realtime.

## 1. Crear el backend en Supabase

1. Crea un proyecto gratuito en Supabase.
2. Abre **SQL Editor > New query**.
3. Copia y ejecuta todo el contenido de `supabase.sql`.
4. Ve a **Project Settings > API**.
5. Copia:
   - Project URL
   - anon / public key
6. Abre `config.js` y reemplaza los dos valores de ejemplo.

No uses la `service_role key` en `config.js`.

## 2. Subir a GitHub

1. Crea un repositorio.
2. Sube todos los archivos de esta carpeta a la raíz.
3. En **Settings > Pages** elige **GitHub Actions** como Source.
4. Haz un push a `main`.
5. El workflow incluido publicará la web.

También puedes usar **Deploy from a branch** con `main` y `/(root)`.

## Flujo de prueba

1. Abre la URL pública sin parámetros.
2. Pulsa **Crear viaje**.
3. Copia el enlace generado.
4. Abre ese enlace en otro teléfono o en una ventana privada.
5. Completa datos y avanza etapas.
6. Mantén abierta la pantalla del dueño: verá el avance y las incidencias.
7. Sube una fotografía de evidencia y comprueba que aparece en el detalle del viaje.
8. Cierra el viaje desde el portal del transportista.

## Nota de seguridad

Esta versión está pensada como MVP operativo sin sistema de login. Las políticas de Supabase permiten operar desde el navegador y el token del enlace identifica el viaje. Para producción real con información sensible, el siguiente paso es agregar autenticación y roles (dueño / transportista) y endurecer las políticas RLS.

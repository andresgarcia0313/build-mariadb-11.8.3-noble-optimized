# MariaDB 11.8.3 Noble Optimizado

Este proyecto proporciona la configuración para construir una imagen de Docker personalizada de **MariaDB 11.8.3** sobre la base de `noble` (Ubuntu 24.04), con una configuración optimizada para entornos de bajos recursos (específicamente 128MB de RAM y discos duros lentos).

## Características

- **Base Actualizada:** Basado en la imagen oficial `mariadb:11.8.3-noble`.
- **Optimización de Memoria:** Configuración `custom-my.cnf` ajustada para un consumo de RAM reducido.
- **Rendimiento en HDD:** Ajustes de I/O en InnoDB para mejorar el rendimiento en discos mecánicos.
- **Uso de Tmpfs:** Monta el directorio temporal de MySQL en `tmpfs` para acelerar las operaciones temporales.
- **Automatización:** Scripts para construir, probar y ejecutar el contenedor.
- **Inicialización Personalizada:** Permite añadir scripts SQL para que se ejecuten en el primer arranque.

## Requisitos Previos

- **Docker:** Necesitas tener Docker instalado y en ejecución.
- **Docker Compose:** (Opcional, para usar `docker-compose.yml`) Necesitas `docker-compose`.

## Construcción de la Imagen

El script `build.sh` automatiza la construcción y subida de la imagen de Docker a Docker Hub.

1.  **Inicia sesión en Docker:** El script te pedirá que inicies sesión con `docker login`.
2.  **Modifica el usuario (Opcional):** Si quieres subir la imagen a tu propio repositorio, edita el archivo `build.sh` y cambia la variable `DOCKERHUB_USERNAME`.
3.  **Ejecuta el script:**

    ```bash
    ./build.sh
    ```

La imagen se construirá y subirá a `andresgarcia0313/mariadb-optimized:11.8.3-noble-lts` (o el repositorio que hayas configurado).

## Uso con Docker Compose

El archivo `docker-compose.yml` facilita la ejecución del contenedor.

1.  **Edita las credenciales:** Modifica el archivo `docker-compose.yml` para establecer una contraseña segura en `MARIADB_ROOT_PASSWORD`.
2.  **Inicia el contenedor:**

    ```bash
    docker-compose up -d
    ```

El servicio estará disponible en el puerto `3306` del host. Los datos se almacenarán en el volumen `/srv/mariadb/data`. El `docker-compose` también aplica límites de memoria (`128m`) y monta `/var/lib/mysql/tmp` en `tmpfs` para mejorar el rendimiento.

## Configuración

El archivo `custom-my.cnf` contiene la configuración principal de MariaDB. Está optimizado para un entorno con **128MB de RAM**. Los parámetros más importantes ajustados son:

- `innodb_buffer_pool_size`: Reducido a `48M`.
- `performance_schema`: Desactivado para ahorrar memoria.
- `thread_handling`: Usa `pool-of-threads` para un manejo más eficiente de las conexiones.
- Ajustes de I/O (`innodb_io_capacity`, `innodb_flush_method`).

Si tu entorno tiene más recursos, puedes ajustar estos valores para mejorar el rendimiento.

## Inicialización de la Base de Datos

Puedes añadir archivos `.sql`, `.sh` o `.sql.gz` en el directorio `docker-entrypoint-initdb.d`. Estos se ejecutarán la primera vez que el contenedor se inicie.

El archivo `01-init.sql` de ejemplo crea una base de datos `db` y un usuario `user` con la contraseña `password`.

## Testing

El script `test.sh` permite lanzar un contenedor de prueba interactivo para verificar que la configuración es válida.

```bash
./test.sh
```

Este script:
1.  Lanza un contenedor efímero (`--rm`) de `mariadb:11.8.3-noble` en modo interactivo (`-it`).
2.  Monta tu `custom-my.cnf` local en modo de solo lectura.
3.  Una vez que el contenedor esté en ejecución, abrirá una shell interactiva.
4.  Ejecutará comandos `docker exec` para mostrar las bases de datos, la variable `sql_mode`, los usuarios y las estadísticas del contenedor.
5.  **Debes detener el contenedor manualmente** (con `Ctrl+C` en la terminal donde lo lanzaste) para que sea eliminado.
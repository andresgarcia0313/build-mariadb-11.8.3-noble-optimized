# Dockerfile - imagen personalizada basada en mariadb:11.8.3-noble
FROM mariadb:11.8.3-noble

LABEL maintainer="gestor@example.local"

# Copiar configuración optimizada
COPY custom-my.cnf /etc/mysql/my.cnf

# Copiar scripts de inicialización (si existen)
COPY docker-entrypoint-initdb.d/ /docker-entrypoint-initdb.d/

# Ajustar permisos (la imagen oficial usa el usuario mysql)
RUN chown mysql:mysql /etc/mysql/my.cnf \
 && chmod 0444 /etc/mysql/my.cnf

# HEALTHCHECK básico
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD mysqladmin ping --silent || exit 1

# Mantener entrypoint/CMD oficial

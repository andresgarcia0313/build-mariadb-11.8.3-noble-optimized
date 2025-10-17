docker run --rm -it \
  -v "/home/gestor/Desarrollo/Containers/Mariadb/build mariadb 11.8.3 noble optimized/custom-my.cnf":/etc/mysql/my.cnf:ro \
  -v /tmp/mariadb-test-data:/var/lib/mysql \
  -e MARIADB_ROOT_PASSWORD='Prueba1234' \
  --name db \
  mariadb:11.8.3-noble

# Mostrar bases de datos
docker exec -it db mariadb -uroot -pPrueba1234 -e "SHOW DATABASES;"
docker exec -it db mariadb -uroot -pPrueba1234 -e "SHOW VARIABLES LIKE 'sql_mode';"

# Mostrar usuarios
docker exec -it db mariadb -uroot -pPrueba1234 -e "SELECT User, Host FROM mysql.user;"
docker stats db --no-stream

# Borra la base de datos, crea una nueva con el mismo nombre,
# carga los modelos en schema y finalmente pobla las tablas
./merge.sh;
cat ../database.sql | sudo mariadb

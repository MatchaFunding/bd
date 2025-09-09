# MatchaFunding - Base de datos

Repositorio para manejo exclusivo de la base de datos. La intencion es almacenar los respaldos y los modelos aqui de tal forma de no tener que buscar repositorios ajenos para actualizar la informacion.

La base de datos viene ya poblada con instrumentos, proyectos, financiadores y los tipos basicos.

## Comando

El comando para armar la base de datos desde Windows es:

```
mysql -h 127.0.0.1 -P 3306 -u root -p MatchaFundingMySQL < database.sql
```
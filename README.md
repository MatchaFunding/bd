# 🍵 MatchaFunding - Base de datos

Repositorio para manejo exclusivo de la base de datos. La intencion es almacenar los respaldos y los modelos aqui de tal forma de no tener que buscar repositorios ajenos para actualizar la informacion.

La base de datos viene ya poblada con instrumentos, proyectos, financiadores y los tipos basicos.

## Comandos

El comando para armar la base de datos desde Windows es:

```
mysql -h 127.0.0.1 -P 3306 -u root -p MatchaFundingMySQL < database.sql
```

Luego, para ingresar a la base de datos en Windows:

```
mysql -h 127.0.0.1 -P 3306 -u root -p MatchaFundingMySQL
```

Si el _<_ hace problemas, hay que ejecutar el comando _cmd_, el cual activara un
terminal en modo compatibilidad, el cual si es compatible con el signo.

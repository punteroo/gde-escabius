<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="200" alt="Nest Logo" /></a>
</p>

[circleci-image]: https://img.shields.io/circleci/build/github/nestjs/nest/master?token=abc123def456
[circleci-url]: https://circleci.com/gh/nestjs/nest

  <p align="center">A progressive <a href="http://nodejs.org" target="_blank">Node.js</a> framework for building efficient and scalable server-side applications.</p>

# Escabius System
Microservicio escrito en el framework **NestJS** encargado de demostrar un ejemplo de portado de esquemas (migraciones y data pull) utilizando **Prisma**. Esta es una aplicación **database-first**.

El alcance del sistema es un **delivery de bebidas alcóholicas y no alcóholicas**.

El sistema fue desarrollado por los alumnos integrantes del grupo 9 en Gestión de Datos 2023 UTN FRVM:
- **IBARRA, Álvaro**
- **MAIRONE, Nicolás Nahuel**
- **MARTINI, Leopoldo**
- **MAZA BIANCHI, Lucas**
- **PEDRAZA, Santiago**

## Instalación

Clonar el repositorio.

```bash
$ git clone https://github.com/punteroo/gde-escabius.git
```

Si no se tiene `yarn`, instalarlo previo a este comando con `npm i --global yarn`.

```bash
$ cd gde-escabius
$ yarn install
```

<hr />

## Configuración
### Base de Ejemplo
Dentro de `psql` dejamos un script `.sql` para crear la base de datos de ejemplo de **Escabius**, con algunos datos de ejemplo (clientes, pedidos, tragos, etcétera).

Es recomendable ejecutar el script en PostgreSQL ya hecho.

#### PostgreSQL w/ Docker
```bash
$ docker run --name postgres -e POSTGRES_PASSWORD=test12345 -d -p 5432:5432 postgres
$ cat ./psql/db_struct.sql | docker exec -i postgres psql -U postgres
```

#### PostgreSQL en Socket (Local)
```bash
$ cat ./psql/db_struct.sql | psql -U postgres
```

#### PostgreSQL Remoto
```bash
$ cat ./psql/db_struct.sql | psql -U postgres -h 1.2.3.4 -p 5432
```

### Connection URI
Esta app está construida para trabajar con **PostgreSQL**.

Se debe modificar la variable de entorno que controla el connection string de Prisma para nuestra DB.

```
DATABASE_URL="postgresql://postgres:test12345@localhost:5432/escabius_db?schema=public"
```

De este valor modificar (de ser necesario) el user (`postgres`), la pass (`test12345`) y posiblemente (dependiendo del networking local en el entorno donde se ejecuta) el host (`localhost`) y (posiblemente) el puerto (`5432`).

Finalmente la base de datos a donde trabajará Prisma (`escabius_db`). En caso de tener otro esquema en donde las tablas de la db pertenezcan, modificar el valor de `schema` al final del connect string.

### First Boot
Para la primer ejecución, solo correr el comando `yarn run start:db`. 

Automáticamente se generará el esquema de Prisma en base a lo que exista en la base de datos y arrancará el microservicio.

<hr />

## Ejecución

Este microservicio se encarga de configurar el lado de Prisma antes de lanzar su factory. Si se desea solo arrancar la aplicación de Nest:

```bash
# desarrollo
$ yarn run start

# modo watch
$ yarn run start:dev

# prod
$ yarn run start:prod
```

Si se desea hacer un arranque graceful con la portación de esquema por Prisma<sup>*</sup>

```bash
# desarrollo
$ yarn run start:db

# modo watch
$ yarn run start:db:dev
```

<p style="color: #f7786f; font-size: 9pt">* El arranque graceful con Prisma <b>sobreescribirá el esquema actual</b> en la app. Tener en cuenta al momento de ejecución del script NPM.</p>

## Support

Nest is an MIT-licensed open source project. It can grow thanks to the sponsors and support by the amazing backers. If you'd like to join them, please [read more here](https://docs.nestjs.com/support).

## License

Nest is [MIT licensed](LICENSE).

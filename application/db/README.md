# Rates database

Notes on running Postgres locally.

## Local setup
The brew formula for Postgres `13.x` appears not to be accepting commands correctly. Postgres `14.x` is working as expected, so for local development this has been added to the brew bundle.

Postgres can be installed by running `brew bundle` at the root of the repo, or separately with command `brew install postgresql@14`

Once installed, start Postgres by running:

```bash
brew services start postgresql@14
```

First create a superuser called `postgres`:

```bash
createuser -s postgres
```

Then create the database:

```bash
createdb rates
```

Then populate using the datadump:

```bash
createdb rates
psql -h localhost -U postgres < application/db/rates.sql
```

And verify that the database is running:

```bash
psql -h localhost -U postgres -c "SELECT 'alive'"
```

## Useful postgres and brew commands 

### Brew
- `brew services list` List running brew services
- `brew list` List installed formulae

### Posgres - from ordinary shell
- `dropdb <dbname>` Drops database

### Postgres - after running psql
- `\l` List databases

When finished, stop the service by running:

```bash
brew services stop postgresql@14
```
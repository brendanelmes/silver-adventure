## Deploying Postgres
Started by testing that Postgres successfully deploys inside a Docker container.

### Steps
Run:

```shell
docker-compose -f docker-compose.yaml up -d
```

Log into pgadmin via the browser at http://localhost:8080

```
Username: admin@admin.com
Password: pgadmin
```

Register a new server:

```
rates_server
```

Connect to database **rates** using the details:

```
Host name/address: postgres
Port: 5432
Maintenance database: rates
Username: postgres
Password: posgres
```

The tables should be visible in the explorer.
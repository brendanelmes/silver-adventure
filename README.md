# silver-adventure
An enjoyable task which has lots of interesting considerations to explore. I will no doubt pick this up again at a later date for some continued Azure learning.

## 1. Deployable Production Environment
The focus for this attempt was to achieve repeatable working app configuration whilst demonstrating production security considerations.

#### Chosen technologies
- **Docker**: developing containers locally with Docker provides a fast iteration time and would be repeatable by most readers.

- **Terraform x Azure**: A great opportunity to work with new technology.

The previous attempt which dives into terraform/terratest/azure can be found on a different branch [here.](https://github.com/brendanelmes/silver-adventure/tree/first-attempt-terraform-az)

### Getting started
By the end of this guide, you will have a running Flask application which reads data from a Postgres13.5 database.

> Note this guide assumes the reader is working on mac OS and [has homebrew installed](https://docs.brew.sh/Installation).

#### 1. Install and launch Docker Desktop

```bash
brew cask install docker
open -a Docker
```

#### 2. Build the container images

This command builds two images, one for the database and one for the Flask application.

```bash
docker compose build
```

#### 3. Deploy locally

The containers run in a docker network so that they can communicate with each other via ports. Run docker compose:

```bash
docker compose up
```

You can verify that the pods are running via Docker Desktop or by running:

```bash
docker ps
```

The output will look something like:

```
CONTAINER ID   IMAGE                  COMMAND                  CREATED             STATUS             PORTS                    NAMES
af77e9c0c99e   silver-adventure-app   "gunicorn -b 0.0.0.0…"   About an hour ago   Up About an hour   0.0.0.0:3000->3000/tcp   silver-adventure-app-1
ab03aadfca34   postgres:13.5          "docker-entrypoint.s…"   About an hour ago   Up About an hour   0.0.0.0:5432->5432/tcp   silver-adventure-rates_db-1
```

The API should now be available to test at http://localhost:3000

Test the application by getting the average rates between ports:
```
curl "http://127.0.0.1:3000/rates?date_from=2021-01-01&date_to=2021-01-31&orig_code=CNGGZ&dest_code=EETLL"
```

The output should be something like this:
```
{
   "rates" : [
      {
         "count" : 3,
         "day" : "2021-01-31",
         "price" : 1154.33333333333
      },
      {
         "count" : 3,
         "day" : "2021-01-30",
         "price" : 1154.33333333333
      },
      ...
   ]
}
```

#### Troubleshooting
Start by verifying that the data has been correctly loaded into the database by adding pgadmin to the **docker-compose.yaml** under **services**

```yaml
services:
    pgadmin:
        image: dpage/pgadmin4:latest
        restart: always
        environment:
            PGADMIN_DEFAULT_EMAIL: admin@admin.com
            PGADMIN_DEFAULT_PASSWORD: pgadmin
            PGADMIN_LISTEN_PORT: 80
        ports:
            - "8080:80"
        depends_on:
            - rates_db
        networks:
            - dem
```

You can use the values in the **environment** section to login and query the database.

### Security considerations

An example of some of the security considerations made:
- Restrict container permissions and installed packages
- Resolve secrets from environment variables for later injection into the containers by a secrets management tool
- Fixed image digest and package versions for deterministic build

### With more time

#### Fix issues
One of the issues I would like to solve is the occasional race condition where the database has not started by the time the API is attempting to make the connection. Proposed solution is to add an entrypoint script to the app Dockerfile which checks that postgres is running before starting.

#### CI/CD Pipeline
I would like to setup a CI/CD pipeline to
    - build, test and scan Python application source code (requires writing of unit tests / testcontainers setup)
    - build, scan and publish the container images to ACR
    - deploy to pre-existing ACI to test

Zoomed out view of this would be to work on re-using the terraform/azure configuration from the [previous attempt](https://github.com/brendanelmes/silver-adventure/tree/first-attempt-terraform-az) with GitHub Actions to provision all of the required infrastructure in a repeatable way.

#### Testability
During my testing I used a pgadmin container in the docker compose config. I would like this to be configured as an option that the developer could use only in the local configuration e.g. a flag when running docker compose (maybe wrap commands in a script) which would allow for manual testing and debugging.

#### Other security
- Add an authentication mechanism
- Investigate providing the application with reduced priviliges when accessing the db (not admin user)

# 2. Secure Database Access

Summary of solution requirements:
- Rotates DB user passwords
- DB access by users and applications
- Manual approval for new DB users
- E2E audit capability for DB operations
- Zero downtime

### Proposed solution:

#### HashiCorp Vault Database Secrets Engine
Deploying a Vault Production cluster (highly available) to handle the rotation and creation of database users and credentials would ensure zero downtime. Here is an example of how it might be set up:

- Enable the appropriate auth methods to allow users from other cloud platforms and systems to authenticate
- Enable the Database Secrets Engine and provide Vault with the Postgres root admin password. Vault will automatically rotate the root password based on a specified time period.
- Create roles such as readonly, readwrite etc. based on the groups of necessary database actions which would be performed by individual users / applications
- A way of adding manual approval by data security personel is by mapping a 'group' entity from an auth method, to a one of these Vault roles. For example, if using Active Directory, an AD group could be created, and joining the AD group can be manually controlled.
- Each time an application or user with a valid role requests database credentials, the secrets engine generates and returns them (created on request) with a TTL.

Vault would provide the audit information about who is granted database credentials, but no visibility of what operations are performed. For this audit capability, [pgAudit](https://www.pgaudit.org) could be used, with logging configured to use Azure Monitor Logs for analytics and performance.

#### Diagram

![diagram](images/diagram.png)

1. User requests database credentials from Vault
2. Vault uses database root credentials to create a temporary database user with role defined by external group
3. Database returns generated credentials to Vault
4. Vault returns generated credentials to User
5. User uses credentials to log in to database and perform operations
6. Monitor logs collects logs from pgAudit in a Log Analytics Workspace ready for analysis

Note the interaction would be the same for a User or an Application using a service principal.
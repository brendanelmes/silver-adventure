# silver-adventure

# 1. Deployable Production Environment

## Tools used

#### Azure and Terraform
Why? A great opportunity to work with new technologies.

#### Docker
Why? Because a 'podman X buildah' setup is not available on MacOS, so would not be easily repeatable by the audience.

#### Shell scripts...
Why? Quick and easy way to get started grouping CLI commands.

## Local setup and automation

This repository consists of a collection of shell scripts designed to be run one after another on MacOS at the root of the repository.

Execute the scripts in order, noting the commands used to run vary between `source` and `sh`:

### 1. `setup-shell.sh`

#### Steps
- Install required tools
- Login to Azure
- Create a service principal
- Configure service principal credentials in shell environment variables

#### Command:

```bash
source setup-shell.sh
```

### 2. `create-container-registry.sh`

#### Steps
- Uses Terraform to create a resource group and container registry
- Creates a new service principal with push permission to the registry
- Configure this service principal credentials in different shell environment variables

#### Command:

```bash
source create-container-registry.sh
```

### 3. `docker-build-and-push.sh`

#### Steps
- Starts Docker desktop
- Sleeps whilst Docker desktop starts
- Logs into the container registry with generated credentials
- Builds and pushes a container image to the registry

#### Command:

```bash
sh docker-build-and-push.sh
```

### 4. `create-container-app.sh`

#### Steps
- Registers container app provider 
- Grants Terraform service principal permission to pull images from the created registry
- Logs into the container registry with pull permission credentials
- Uses Terraform to create a container app

#### Command:

```bash
sh create-container-app.sh
```

# 2. Secure Database Access


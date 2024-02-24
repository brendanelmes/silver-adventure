# silver-adventure

Introductory ramblings.

## Local setup
To build and deploy manually, you will need the following tools installed:

1. Terraform
1. Python
1. Golang
1. Docker
1. Azure CLI

To install them, run the following command at the root of the repo:

```bash
brew bundle
```

Or for a more comprehensive security and automation tooling setup, [check out this repo](https://github.com/T0mmykn1fe/DevSecOps-OSX-Mac-Setup-with-Homebrew/tree/master).

## Connecting to Azure

> To skip straight to a configured shell session, run the setup script with:
> ```bash
> source setup-shell.sh
> ```

Alternatively, you can follow the steps through manually:

### Log in
First, log into Azure by running:

```bash
az login
```

This will open a browser window and prompt you to log in to Azure.

### Create a service principal

To use terraform, first create a service principal:

1. Run the following:
    ```bash
    az 
    ```
1. Verify the output looks like:
    ```json
    {
        "": "",
        "": "",
        "": "",
        "": ""
    }
    ```

Once created, add the contents of the output as the following environment variables:

```bash
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"
```

Verify the existence of these variables:

```bash
printenv | grep ^ARM*
```

## CI workflow

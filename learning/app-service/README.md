# Deploy a Flask app to container
Terraform script to deploy app service.

After creating infra, run the following command with the Azure CLI from the `app-service` directory to deploy the source code to the app service:

```bash
az webapp up --name <app-service-name>
```

Currently configuring some parameters in the Azure portal, but aiming for these commands to be run in a script following the Terraform apply and ideally as part of a Terratest.
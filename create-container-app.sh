echo "Registering container app provider..."

# Required to enable container apps
az provider register --namespace "Microsoft.App"

# Populate value required for subsequent command args
ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query id --output tsv)

echo "Assigning Terraform service principal container pull role..."

# Assign Terraform service principal container pull role
az role assignment create --assignee $ARM_CLIENT_ID --scope $ACR_REGISTRY_ID --role acrpull

# Log in to Docker with service principal credentials
registry="${ACR_NAME}.azurecr.io"
imageTag="${registry}/samples/flask-app:latest"

echo "Logging in to $registry..."

echo $ARM_CLIENT_SECRET | docker login "$registry" --username $ARM_CLIENT_ID --password-stdin

cd infra/container-app
terraform init -input=false
terraform plan -out=tfplan -input=false
terraform apply -input=false tfplan

cd ../..

# Alternative solution using Azure CLI

# resourceGroup=resourceGroup$RANDOM

# az group create --name $resourceGroup --location eastus

# az container create \
#   --name flaskapp \
#   --resource-group $resourceGroup \
#   --image $imageTag \
#   --registry-username $ARM_CLIENT_ID \
#   --registry-password $ARM_CLIENT_SECRET
cd infra/container-registry
terraform init -input=false
terraform plan -out=tfplan -input=false
terraform apply -input=false tfplan

tf_output=$(terraform output -json)

acr_name="$(echo "$tf_output" | jq -r '.container_registry_name.value')"
acr_id="$(echo "$tf_output" -json | jq -r '.container_registry_id.value')"

echo "$acr_name"

export ACR_NAME="$acr_name"

echo "Creating Docker service principal..."

service_principal=$(az ad sp create-for-rbac --scope "$acr_id" --role acrpush)

export SP_DOCKER_ID="$(echo "$service_principal" | jq -r '.appId')"
export SP_DOCKER_PW="$(echo "$service_principal" | jq -r '.password')"

cd ../..
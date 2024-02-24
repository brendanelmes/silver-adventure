#!/bin/sh

echo "Logging into Azure..."

login_info=$(az login)
subscription_id="$(echo "$login_info" | jq -r '.[0].id')"

# TODO - allow user to select from existing subscriptions instead of defaulting to first subscription found with .[0]

echo "Login successful."

echo "Creating service principal..."

service_principal=$(az ad sp create-for-rbac)

echo "Successfully created service principal: $(echo "$service_principal" | jq -r '.displayName')"

export ARM_SUBSCRIPTION_ID="$(echo "$subscription_id")"
export ARM_TENANT_ID="$(echo "$service_principal" | jq -r '.tenant')"
export ARM_CLIENT_ID="$(echo "$service_principal" | jq -r '.appId')"
export ARM_CLIENT_SECRET="$(echo "$service_principal" | jq -r '.password')"

echo "Added env vars to shell session: ARM_SUBSCRIPTION_ID, ARM_TENANT_ID, ARM_CLIENT_ID, ARM_CLIENT_SECRET"
#!/bin/sh

echo "Installing required tools with Homebrew..."

brew bundle

echo "Logging into Azure..."

login_info=$(az login)

# TODO - allow user to select from existing subscriptions instead of defaulting to first subscription found with .[0]
subscription_id="$(echo "$login_info" | jq -r '.[0].id')"

echo "Login successful."

echo "Creating service principal..."

service_principal=$(az ad sp create-for-rbac --role Contributor --scopes /subscriptions/$subscription_id)

# TODO - Work out a good way of setting a TTL on the service principal
# commenting out initial attempt
# now=$(date -v+1H +"%Y-%m-%dT%T%z")
# echo "$now"
# reset_pw=$(az ad app credential reset --id "$(echo "$service_principal" | jq -r '.appId')" --end-date "$now")
# echo "$reset_pw"

echo "Successfully created service principal: $(echo "$service_principal" | jq -r '.displayName')"

export ARM_SUBSCRIPTION_ID="$(echo "$subscription_id")"
export ARM_TENANT_ID="$(echo "$service_principal" | jq -r '.tenant')"
export ARM_CLIENT_ID="$(echo "$service_principal" | jq -r '.appId')"
export ARM_CLIENT_SECRET="$(echo "$service_principal" | jq -r '.password')"

echo "Added env vars to shell session: ARM_SUBSCRIPTION_ID, ARM_TENANT_ID, ARM_CLIENT_ID, ARM_CLIENT_SECRET"
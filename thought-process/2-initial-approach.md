# Initial approach

This is the planned approach after reading the task through and doing some research around the available Azure services.

1. Write a local environment setup script which will:
    1. Install all required dependencies
    1. Log into Azure via CLI
    1. Create a service principal (Azure name for service account)
    1. Configure shell session environment variables to allow Terrafrom to authenticate to Azure

1. Try to write some basic examples to verify:
    1. Terrafom authenticating to Azure
    1. Terraform can create and destroy resources
    1. Terratest can verify which resources have been created (Looks like the recommended E2E test tool for Terraform)
    1. Terratest can cleanup after tests

1. Write a Terraform module which will:
    1. Create a Postgres managed database instance (Azure server Postgres)
    1. Create an App service (Managed applications Django and Flask)
    1. Verify the existence of both resources
    1. Destroy all created resources

1. Write scripts for Terraform to call which will:
    1. Run the SQL against the database
    1. Deploy the Flask application

1. Write a Terratest module which will:
    1. Verify the API endpoint is working correctly
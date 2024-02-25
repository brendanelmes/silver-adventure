# Initial Readthrough

Notes:
- Line 1 says build with security in mind
- Deployable production environment
- Postgres and Flask app
- Instructions on how to run the automation solution
- Automate setup in reliable and testable manner
- Using containers?

Thoughts:
- SQL dump could be deployed using a managed Postgres instance
- API could be deployed using either a managed container workoad service, 
or even better, a managed service for deploying flask apps
- Both could be deployed using a single Helm chart to K8s, but this seems overcomplicated.
- All of these can be set up using Terraform
- Use Terratest to test successful deployment before executing e.g. script to first run an e2e test, then actually deploy the solution
- Azure is a new technology, but should be a good opportunity to learn
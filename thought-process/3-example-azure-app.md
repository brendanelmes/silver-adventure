# Example azure app
Found an example postgres x flask app which could be deployed using the Azure Developer CLI (azd) in some pre-canned examples.

Architecture looked similar to what I wanted to achieve, but technology stack not quite the same:

This used the following:

- Bicep for infrastructure provisioning
- Postgresql flexible server (managed)
- App service for flask app (managed)

Some additional components such as Redis were included and deployment was successful:

`SUCCESS: Your up workflow to provision and deploy to Azure completed in 27 minutes 33 seconds.`

Incredibly slow deployment.
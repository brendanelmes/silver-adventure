## Deploying the Flask app
Built a Docker image using Snyk reccommendations.

Initially psycopg2-binary was not installing correctly. SO to the rescue https://stackoverflow.com/questions/62715570/failing-to-install-psycopg2-binary-on-new-docker-container

Added `libpq-dev` to installed packages and now working correctly.

## Port 5000
When trying to test this application, difficulty using port 5000:

https://nono.ma/port-5000-used-by-control-center-in-macos-controlce#:~:text=The%20process%20running%20on%20this,Receiver%20to%20release%20port%205000%20.

Managed to follow this workaround, but then moved to port 3000 to retain working of airplay on mac.
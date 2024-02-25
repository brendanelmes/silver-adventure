# Start Docker
open -a Docker

# TODO - write a loop which checks whether Docker has started
sleep 15

registry="${ACR_NAME}.azurecr.io"

echo "Logging in to $registry..."

# Log in to Docker with service principal credentials
echo $SP_DOCKER_PW | docker login "$registry" --username $SP_DOCKER_ID --password-stdin

echo "Login Success"

echo "Building application..."

docker build --platform linux/amd64 -t "${registry}/samples/flask_app" ./application/example-flask-app

docker push "${registry}/samples/flask_app"
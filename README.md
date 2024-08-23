# HTTPs via Nginx for Azure Container Apps

This repository contains the necessary scripts and configuration files to set up an Nginx server within a container. The Nginx container will then serve as HTTPs proxy for backend applications in the environment. To use the container it is important to set the `BACKEND_APP` environment variable which is the backend Nginx will `proxy_pass` to. Please note that this configuration has not undergone any performance testing.

## Configuration Details
The Nginx configuration is dynamically generated on container startup via the entrypoint script. The template is `default.conf.template-only`. There are a set of other variables which can be set:
* `BACKEND_APP` (required): The format of this variable is `ACA_APP_NAME:PORT` given traffic from Nginx to the app backend is internal. If your app is called my_app and internally listens to 8080 your setting would be `my_app:8080`. Nginx assumes http as the `proxy_pass` protocol.
* `EXTERNAL_HTTPS_PORT` (optional): This is set to 8443 by default. If you want to redirect external http requests to https then make sure to set this to the right port you've chosen for this container to run on.
* `BACKEND_TIMEOUT` (optional): This is set to 600 by default for a 600s timeout.
* `CONTAINER_APP_NAME` and `CONTAINER_APP_ENV_DNS_SUFFIX` (not required): These will be set in the container environment by ACA. No need to change these.


## Quickstart
A ready made container with a self-signed certificate is available for testing this setup. By running the following command you can stand up Nginx with the appropriate settings:

```
export RG=resource-group
export ACA_ENV=azure_container_apps_env
export YOUR_BACKEND=http-waiter-tcp:8080
export NGINX_QUICK_START=simon.azurecr.io/nginx-ssl

az containerapp create \
    --name nginx-frontend --resource-group $RG \
    --environment $ACA_ENV  --image $NGINX_QUICK_START \
    --cpu 2 --memory 4.0Gi \
    --min-replicas 1 --max-replicas 1 \
    --ingress external --transport tcp --target-port 443 --exposed-port 8443 \
    --env-vars BACKEND_APP=$YOUR_BACKEND
```

## Customizing Nginx

### SSL Certificates
Please see the [README](ssl/README.md) for details on how to generate your own certificates.


### Building
Building the container with Azure Container Registry (ACR) can be done via the command below:

```
az acr build --image $YOUR_IMAGE_NAME --registry $YOUR_REGISTRY --file Dockerfile .
```

### Deploy to Azure Container Apps
To run your own container simply replace the above image ($NGINX_QUICK_START) with your own and run the command from the quickstart instructions.

# Docker Setup for Backend Service (AWS Fargate & ECR)

This directory contains the Docker configuration for building and deploying the backend service as a container in AWS Fargate. The container is pushed to Amazon ECR (Elastic Container Registry) for easy deployment in the ECS (Elastic Container Service) cluster.

---

## 📦 Docker Configuration

The Docker setup uses an NGINX server to serve the `index.html` file as a static webpage in the container, which is then deployed to AWS Fargate.

### Dockerfile

The `Dockerfile` defines the following steps:

1. **Base Image**: The container is based on the `nginx:alpine` image, a minimal and efficient version of the NGINX web server.
2. **Copy index.html**: The `index.html` file in this directory is copied into the container at `/usr/share/nginx/html/index.html`, where it is served by NGINX.
3. **Expose Port 80**: The container exposes port `80` to make the web server accessible externally.
4. **Run NGINX**: The container starts NGINX with the command `nginx -g 'daemon off;'` to keep it running in the foreground.

### index.html

The `index.html` file serves as the landing page for the backend service. You can modify it to display dynamic content or data from AWS DynamoDB or other sources as needed.

---

## 🚀 Build, Push, and Deploy to AWS Fargate

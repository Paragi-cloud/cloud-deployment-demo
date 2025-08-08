#!/bin/bash

# Build Docker images
docker build -t fastapi-app ../backend
docker build -t react-app ../frontend

# Tag (optional)
docker tag fastapi-app your_dockerhub_user/fastapi-app
docker tag react-app your_dockerhub_user/react-app

# Push to DockerHub (if needed)
# docker push your_dockerhub_user/fastapi-app
# docker push your_dockerhub_user/react-app

# SSH into EC2 and run containers
ssh -o StrictHostKeyChecking=no ubuntu@13.217.230.126 << 'EOF'
  docker stop fastapi-app || true && docker rm fastapi-app || true
  docker stop react-app || true && docker rm react-app || true
  docker pull your_dockerhub_user/fastapi-app
  docker pull your_dockerhub_user/react-app
  docker run -d -p 8000:8000 --name fastapi-app your_dockerhub_user/fastapi-app
  docker run -d -p 80:80 --name react-app your_dockerhub_user/react-app
EOF

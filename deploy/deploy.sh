#!/bin/bash

# SSH into EC2 and build/run directly there
ssh -o StrictHostKeyChecking=no ubuntu@13.217.230.126 << 'EOF'
  # Clone your GitHub repo (or pull latest)
  if [ ! -d app ]; then
    git clone https://github.com/Paragi-cloud/cloud-deployment-demo.git app
  else
    cd app && git pull origin main && cd ..
  fi

  cd app

  # Build Docker images
  docker build -t fastapi-app backend
  docker build -t react-app frontend

  # Stop and remove old containers
  docker stop fastapi-app || true && docker rm fastapi-app || true
  docker stop react-app || true && docker rm react-app || true

  # Run new containers
  docker run -d -p 8000:8000 --name fastapi-app fastapi-app
  docker run -d -p 80:80 --name react-app react-app
EOF


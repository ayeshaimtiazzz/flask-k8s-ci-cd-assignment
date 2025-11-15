🚀 Flask Application Deployment using Docker, Jenkins, and Kubernetes

This project demonstrates a complete CI/CD pipeline for deploying a Flask application using Docker, Jenkins, and Kubernetes.
The pipeline automatically builds, deploys, scales, and manages rollouts whenever changes are pushed to the main branch.

📌 Project Overview

This repository includes:

A simple Flask application

A Dockerfile for containerization

Kubernetes manifests (Deployment + Service)

A Jenkins Declarative Pipeline

Full CI/CD automation triggered by GitHub pull request merges

The workflow ensures that every code change is tested, built, and deployed to a Kubernetes cluster automatically.

☸ Kubernetes Features Used
1. Deployments

Declarative updates using YAML

Automatic rollouts and rollbacks

Ensures the desired number of replicas stay running

2. ReplicaSets

Maintains the correct number of pod replicas

Recreates failed pods automatically

3. Pods

Basic compute units running the Flask container

4. Services (NodePort)

Exposes the application outside the Kubernetes cluster

Provides load balancing across pods

5. Automated Rollouts

Triggered when deployment configuration changes:

Rolling updates

Zero downtime deployment

Automatic rollback on failure

6. Scaling

Horizontal scaling:

kubectl scale deployment flask-app-deployment --replicas=3


Kubernetes:

Automatically adds/removes pods

Distributes load automatically

7. Self-Healing

If a pod crashes:

Kubernetes restarts it

Ensures desired replicas always run

🐳 Run the Flask App Locally Using Docker
1. Build the Docker image
docker build -t flask-app:latest .

2. Run the container
docker run -p 5000:5000 flask-app:latest

3. Test in browser

Visit:

http://localhost:5000

☸ Deploying to Kubernetes Using Jenkins Pipeline

This project uses a Jenkins Declarative Pipeline defined in Jenkinsfile.

🧱 Pipeline Stages
Stage 1 — Build Docker Image

Jenkins builds the image:

docker build -t flask-app:latest .

Stage 2 — Deploy to Kubernetes

Jenkins applies all configuration files:

kubectl apply -f kubernetes/


Creates or updates:

Deployment

Service

Stage 3 — Verify Rollout
kubectl rollout status deployment/flask-app-deployment
kubectl get pods,svc


Ensures that the deployment is healthy.

🌀 Automated Rollouts, Scaling & Load Balancing
🔁 Automated Rollouts

On every update:

New pods are created gradually

Old pods are terminated gracefully

Zero downtime

Rollback on error

📈 Scaling
kubectl scale deployment flask-app-deployment --replicas=4


Kubernetes:

Creates more pods

Removes extra pods when scaling down

⚖ Load Balancing

The NodePort service:

Distributes traffic automatically

Sends traffic only to healthy pods

Registers new pods without manual config

📂 Repository Structure
📁 root
 ┣ 📁 kubernetes/
 ┃ ┣ deployment.yaml
 ┃ ┣ service.yaml
 ┣ app.py
 ┣ Dockerfile
 ┣ Jenkinsfile
 ┣ requirements.txt
 ┗ README.md

🚀 CI/CD Workflow Summary

Developer pushes code to GitHub

Pull Request created → reviewed → merged

GitHub webhook triggers Jenkins

Jenkins pulls the latest commit

Docker image is built

Kubernetes manifests are applied

Kubernetes performs rolling update

Deployment is verified

Application becomes available on NodePort

✔ Final Notes

This project demonstrates a complete cloud-native CI/CD system using:

Docker

GitHub workflow

Jenkins automation

Kubernetes orchestration

Load balancing

Auto-scaling

Self-healing

Rolling updates

This architecture is commonly used in production environments for modern microservices.
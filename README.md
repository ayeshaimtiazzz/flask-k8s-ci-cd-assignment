# Flask Application Deployment using Docker, Jenkins, and Kubernetes

This project demonstrates a complete CI/CD workflow for deploying a Flask-based web application using **Docker**, **Jenkins**, and **Kubernetes**.  
The goal of the project is to show automated build, deploy, scaling, and rollout mechanisms using modern DevOps tools.

---

# 🚀 Project Overview

This repository contains:  
- A simple **Flask API application**  
- A **Dockerfile** for containerization  
- Kubernetes manifests (`Deployment` + `Service`)  
- A **Jenkins Pipeline (Jenkinsfile)** to automate deployment  
- A fully functional CI/CD flow that updates Kubernetes automatically whenever changes are pushed to the repository

The project demonstrates end-to-end automation starting from GitHub commits to Jenkins-triggered Kubernetes deployments.

---

# ☸ Kubernetes Features Used

This project uses several key Kubernetes features:

### **1. Deployments**
- Ensures **declarative application updates**
- Supports **rolling updates** and **rollbacks**
- Manages ReplicaSets automatically

### **2. ReplicaSets**
- Guarantees the correct number of application pods are running
- Recreates pods when they crash or fail

### **3. Services (NodePort)**
- Exposes the Flask application outside the cluster
- Provides **load balancing** across multiple pods

### **4. Pods**
- Smallest deployable units running the Flask container

### **5. Automated Rollouts**
- Whenever Jenkins applies a new Deployment, Kubernetes performs:
  - Rolling update
  - Health checks
  - Zero-downtime deployment
  - Auto rollback on failures

### **6. Scaling**
- Application can be scaled horizontally:
```bash
kubectl scale deployment flask-app-deployment --replicas=3
Kubernetes distributes pods across the cluster automatically

7. Self-healing

If a pod crashes:

Kubernetes restarts it automatically

Ensures minimum number of pods always stay alive

🐳 Running the Application Locally Using Docker

Follow these steps to run the Flask app on your local machine:

1. Build the Docker Image
docker build -t flask-app:latest .

2. Run the Docker Container
docker run -p 5000:5000 flask-app:latest

3. Test the App

Open your browser and visit:

http://localhost:5000


If you see the Flask response, the app is running successfully in Docker.

☸ Deploying to Kubernetes using Jenkins Pipeline

This project uses a Jenkins Declarative Pipeline defined in the Jenkinsfile.

The pipeline performs:

🧱 Pipeline Stages
Stage 1 — Build Docker Image

Jenkins builds the container image:

docker build -t flask-app:latest .

Stage 2 — Deploy to Kubernetes

Jenkins applies all manifests in the /kubernetes directory:

kubectl apply -f kubernetes/


This creates or updates:

Deployment

Service

Stage 3 — Verify Rollout

Jenkins ensures the deployment is successful:

kubectl rollout status deployment/flask-app-deployment
kubectl get pods,svc

🌀 Automated Rollouts, Scaling, and Load Balancing

Kubernetes provides several built-in automation features that make this deployment resilient and scalable.

🔁 Automated Rollouts

Kubernetes performs rolling updates:

New pods are created one-by-one

Old pods are removed gradually

Ensures zero downtime

If something goes wrong → automatic rollback

This is triggered every time Jenkins deploys updated configuration using:

kubectl apply -f kubernetes/

📈 Scaling

You can scale the application horizontally:

kubectl scale deployment flask-app-deployment --replicas=4


Kubernetes:

Creates additional pods

Distributes load evenly

Removes pods when scaling down

Scaling is completely dynamic and does not require downtime.

⚖ Load Balancing

The Kubernetes Service (NodePort) automatically load-balances traffic across all healthy pods.

For example, if 3 pods are running:

Users → Service → Pod 1 / Pod 2 / Pod 3


If a pod fails → Service stops sending traffic to it

If a new pod is added → It is registered automatically

This ensures:

High availability

Balanced traffic

Zero manual configurations

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

Developer pushes code → GitHub

Webhook triggers Jenkins

Jenkins pulls the latest code

Jenkins builds Docker image

Jenkins deploys to Kubernetes

Kubernetes rolls out updates

Pipeline verifies the deployment

Application becomes available via NodePort

✔ Final Notes

This project demonstrates a complete DevOps pipeline integrating:

Docker containerization

Git workflows

Jenkins-based CI/CD automation

Kubernetes orchestration

Autoscaling, load balancing, and rollout automation

It is a modern industry-standard architecture used for cloud-native applications.
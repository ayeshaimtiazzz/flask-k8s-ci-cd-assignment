pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "flask-app"
        KUBE_CONFIG = "$HOME/.kube/config"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh 'docker build -t ${DOCKER_IMAGE}:latest .'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    echo "Deploying to Kubernetes..."
                    // Apply all manifests from the kubernetes/ directory
                    sh 'kubectl apply -f kubernetes/'
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    echo "Verifying rollout status..."
                    sh 'kubectl rollout status deployment/flask-app-deployment'
                    echo "Checking pods and services..."
                    sh 'kubectl get pods,services'
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment pipeline completed successfully!"
        }
        failure {
            echo "❌ Deployment pipeline failed. Check logs."
        }
    }
}

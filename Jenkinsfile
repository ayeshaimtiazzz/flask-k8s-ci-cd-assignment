pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "flask-app"
        KUBECONFIG = "C:/Users/aimte/.kube/config"
        PATH = "C:/Program Files/Docker/Docker/resources/bin;${env.PATH}"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    bat """
                    docker build -t %DOCKER_IMAGE%:latest .
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    echo "Deploying to Kubernetes..."
                    bat """
                    kubectl apply -f kubernetes/
                    """
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    echo "Verifying rollout status..."
                    bat """
                    kubectl rollout status deployment/flask-app-deployment
                    kubectl get pods,services
                    """
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

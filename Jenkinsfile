pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'your-registry/flask-app'  // Replace with your Docker registry
        KUBECONFIG = credentials('kubeconfig')  // Jenkins credential for K8s config
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://your-registry', 'docker-credentials') {  // Replace with your registry and Jenkins credential ID
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_NUMBER}").push()
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_NUMBER}").push('latest')
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh 'kubectl apply -f kubernetes/deployment.yaml'
                    sh 'kubectl apply -f kubernetes/service.yaml'
                    sh 'kubectl set image deployment/flask-app flask-app=${DOCKER_IMAGE}:${BUILD_NUMBER}'
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
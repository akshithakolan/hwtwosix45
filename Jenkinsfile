pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'akolanup/survey'      // Docker image name
        DOCKER_TAG = 'latest'                // Tag for the Docker image; change to '${env.BUILD_ID}' for unique tags per build
        DOCKER_USERNAME = 'akolanup'          // Docker Hub username
        DEPLOYMENT_YAML_PATH = 'one.yaml'  // Path to deployment YAML in the repository
        registryCredential = 'dockerhub'     // Jenkins credentials ID for Docker Hub
        // SERVICE_YAML_PATH = 'service.yaml'   // Path to service YAML in the repository
    }

    stages {
        stage('Checkout') {
            steps {
            git branch: 'main', url: 'https://github.com/akshithakolan/hwtwosix45.git'
            }
        }

        stage('Pushing latest code to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('',registryCredential) {
                        def image = docker.build('akolanup/survey:latest ', '. --no-cache')
                        docker.withRegistry('',registryCredential) {
                            image.push()
                        }
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Use Jenkins credentials for secure login and push to Docker Hub
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Apply the Kubernetes YAML files to deploy to the cluster
                    sh "kubectl apply -f ${DEPLOYMENT_YAML_PATH} --kubeconfig /var/lib/jenkins/.kube/config"
                    // sh "kubectl apply -f ${SERVICE_YAML_PATH} --kubeconfig /var/lib/jenkins/.kube/config"
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
pipeline {
    agent any
    environment {
        PROJECT_ID = 'rancher'
        CLUSTER_NAME = 'done'
        LOCATION = 'us-east-1a'
        DOCKERHUB_PASS = 'Docker@12'
    }
    stages {
        stage("Checkout code") {
            steps {
                checkout scm
            }
        }
        stage('BuildWAR') {
            steps {
                echo 'Creating the Jar ...'
                sh 'jar -cvf surhw2.war -C survey/ .'
                sh 'docker login -u akolanup -p ${DOCKERHUB_PASS}'
                sh 'docker build -t akolanup/survey:latest .'
            }
        }
		stage("Pushing image to docker"){
			steps{
				script{
					sh 'docker push akolanup/survey:latest'
				}
			}
		}
    
        stage("UpdateDeployment") {
            steps {
					sh 'kubectl rollout restart deploy deployy'
	    }
        }
    }
}
pipeline {
    agent any
    environment {
        PROJECT_ID = 'rancher'
        CLUSTER_NAME = 'done'
        LOCATION = 'us-east-1a'
        DOCKERHUB_PASS = 'Docker@12'

        RANCHER_SERVER_URL = 'http://54.227.136.242/'
        RANCHER_ACCESS_KEY = 'token-9kbld'
        RANCHER_SECRET_KEY = 'jfk8gkj49sfq8hz95fh28fp75qz66kg8xg5mc54st2js7v8wfv8hvf'
        RANCHER_BEARER_TOKEN = 'token-9kbld:jfk8gkj49sfq8hz95fh28fp75qz66kg8xg5mc54st2js7v8wfv8hvf'
        RANCHER_CLUSTER_ID = 'done'
        RANCHER_PROJECT_ID = '<rancher-project-id>'
        RANCHER_DEPLOYMENT_NAME = 'deployy'
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
                sh 'java -version'
                sh 'rm -rf *.war'
                sh 'jar -cvf surhw2.war -C srcwar .'
                sh 'docker login -u akolanup -p ${DOCKERHUB_PASS}'
				sh 'docker build -t akolanup/survey .'
                // sh 'docker buildx build -t akolanup/survey .'
                
            }
        }
		stage("Pushing image to docker"){
			steps{
				script{
					sh 'docker push akolanup/survey'
				}
			}
		}
    
        // stage("UpdateDeployment") {
        //     environment {
        //     KUBECONFIG_CRED = credentials('kube-config')
        //     }
        //     steps {
        //     withCredentials([file(credentialsId: 'kube-config', variable: 'KUBECONFIG')]) {
        //         sh 'kubectl --kubeconfig=$KUBECONFIG rollout restart deploy deployy'
        //     }
        //     }
        // }

        stage('Deploy to Rancher') {
            steps {
                script {
                    def rancherCli = 'rancher'
                    sh "${rancherCli} login ${RANCHER_SERVER_URL} --token ${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY} --context ${RANCHER_CLUSTER_ID}"
                    sh "${rancherCli} kubectl set image deployment/${RANCHER_DEPLOYMENT_NAME} ${RANCHER_DEPLOYMENT_NAME}=akolanup/survey:latest"
                }
            }
        }
    }
}
pipeline {
    agent any
    parameters {
        string(name: 'ip_addr', description: 'Enter IP Address', defaultValue: '')
    }
    stages {
        stage('Login Stage') {
            steps {
                echo 'Login Stage'
                script {
                    withCredentials([file(credentialsId: 'service_acc', variable: 'service_acc')]) {
                        sh "gcloud auth activate-service-account --key-file=${service_acc}"
                    }
                }
            }
        }
        stage('Health Check Stage') {
            steps {
                echo 'Health Check Stage'
                script {
                    sh """
                chmod +x script.sh
                ./script.sh ${params.ip_addr}
                """
                }
            }
        }
    }
}

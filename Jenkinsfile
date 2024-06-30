pipeline {
    agent {
        docker {
            image 'my-maven-jdk-image:1.0'
        }
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/TEST-*.xml'
                }
            }
        }
        stage('Deploy') {
            steps {
                // ここにデプロイ手順を記述
                echo 'Deploying...'
            }
        }
    }
}
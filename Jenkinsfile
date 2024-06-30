pipeline {
    agent any
    tools {
        maven 'Maven 3.8.1'  // Jenkinsで設定したMavenの名前
        jdk 'JDK 17'  // Jenkinsで設定したJDKの名前
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
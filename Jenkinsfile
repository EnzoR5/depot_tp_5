pipeline {
    agent any
    stages {
        stage('Git Checkout') {
            steps {
                git credentialsId: 'connection_git-jenkins', url: 'https://github.com/EnzoR5/depot_tp_5.git'
            }
        }
        stage('Build the application') {
            steps {
                sh 'mvn clean install'
            }
        }
        
        stage('Unit Test Execution') {
            steps{
                sh 'mvn test'
            }
        }
    }
}

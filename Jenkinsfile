pipeline {
    agent any 
    environment {
        SONARQUBE_URL = "http://34.66.4.120:9000/"
        SONARQUBE_TOKEN = credentials ('sonar-token')
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-creds')
        GCP_REGION = 'us-central1'  // Change if your Artifact Registry is in a different region
        GCP_PROJECT_ID = 'harshini-project-452710'  // Replace with your Google Cloud Project ID
    }
    tools {
        git 'git'
        maven 'maven'
    }
    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/honey1417/my-usecase1.git'
            }
        }

        stage('Build & Test') {
            steps {
                sh 'mvn --version'
                sh 'mvn clean verify'
            }
        }


        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh "mvn clean verify sonar:sonar -Dsonar.projectKey=sonarqube-jenkins-demo -Dsonar.host.url=${SONARQUBE_URL} -Dsonar.login=${SONARQUBE_TOKEN}"
                }
            }
        }

        stage ('Pushing to Nexus Repo') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'nexus-creds', passwordVariable: 'NEXUS_PSW', usernameVariable: 'NEXUS_USR')]) {
                    sh """
                    mvn deploy
                    """
}
                }
            }
        }

        


    }
}
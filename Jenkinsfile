pipeline {
    agent any 
    environment {
        DOCKER_REPO = "harshini1402/my-usecase1-demo"
        SONARQUBE_URL = "http://35.184.36.107:9000/"
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

        stage('Build & Test Maven') {
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

        stage('Deploy to Nexus Repo') {
            steps {
                script {
                     withCredentials([usernamePassword(credentialsId: 'nexus-creds', passwordVariable: 'NEXUS_PSW', usernameVariable: 'NEXUS_USR')]) {
                       //sh "mvn deploy -DaltDeploymentRepository=nexus::default::http://34.72.222.210:8081/repository/my-usecase1-release/  -DskipTests -X" (for release)
                       sh" mvn deploy -DaltDeploymentRepository=nexus::default::http://34.72.222.210:8081/repository/version-2.0-usecase/ -DskipTests -X" //for snapshot
                        

                    }
                }
           }
        }

        stage('Build Docker Image with Latest JAR') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'docker-creds', url: 'https://index.docker.io/v1/']) {
                        withCredentials([usernamePassword(credentialsId: 'nexus-creds', passwordVariable: 'NEXUS_PSW', usernameVariable: 'NEXUS_USR')]) {
                            sh """
                            docker build --no-cache -t $DOCKER_REPO:1.0 \
                              --build-arg NEXUS_USER=$NEXUS_USR \
                              --build-arg NEXUS_PASS=$NEXUS_PSW \
                              -f Dockerfile .
                            """
                        }
                     }
                }
            }
        }

        stage ('Push to Docker Hub') {
            steps {
                script{
                withDockerRegistry([credentialsId: 'docker-creds', url: 'https://index.docker.io/v1/']) {
                sh "docker push $DOCKER_REPO:1.0"
                }
              }
           }
        }


    
    }
}
pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-reg'
        IMAGE_NAME = 'shadyemad/gitops-app:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/shadyemad2/GitOps-ci-cd-with-Jenkins-and-Argocd'
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        echo 'Logged in to Docker Hub'
                    }
                }
            }
        }

        stage('Build Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        docker.image("${IMAGE_NAME}").push('latest')
                    }
                }
            }
        }

        stage('Update Kubernetes Manifest') {
            steps {
                sh '''
                  sed -i "s|image:.*|image: shadyemad/gitops-app:latest|" kubernetes/app.yaml
                  git config --global user.name "jenkins"
                  git config --global user.email "jenkins@example.com"
                  git add kubernetes/app.yaml
                  git commit -m "Update image to latest"
                  git push origin main
                '''
            }
        }
    }
}


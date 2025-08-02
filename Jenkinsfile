pipeline {
  agent any

  environment {
    DOCKER_HUB_CREDENTIALS_ID = 'docker-hub-reg'
    DOCKER_IMAGE = 'shadyemad/gitops-app'
    DOCKER_TAG = 'latest'
    GIT_BRANCH = 'main'
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: "${GIT_BRANCH}", url: 'https://github.com/shadyemad2/GitOps-ci-cd-with-Jenkins-and-Argocd.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
        }
      }
    }

    stage('Push Image') {
      steps {
        script {
          docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_HUB_CREDENTIALS_ID}") {
            def app = docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}")
            app.push()
          }
        }
      }
    }

    stage('Update Kubernetes Manifest') {
      steps {
        sh '''
          echo "[INFO] Updating Kubernetes manifest with latest Docker image"
          sed -i "s|image: .*|image: ${DOCKER_IMAGE}:${DOCKER_TAG}|" kubernetes/app.yaml
          git config user.name "jenkins"
          git config user.email "jenkins@example.com"
          git add kubernetes/app.yaml || true
          if ! git diff --cached --quiet; then
            git commit -m "Update image to ${DOCKER_IMAGE}:${DOCKER_TAG}"
            git push origin ${GIT_BRANCH}
            echo "[INFO] Git push completed."
          else
            echo "[INFO] No changes detected; skipping commit."
          fi
        '''
      }
    }
  }

  post {
    success {
      echo 'Pipeline completed successfully.'
    }
    failure {
      echo 'Pipeline failed.'
    }
  }
}


pipeline {
  agent any

  environment {
    DOCKER_HUB_CREDENTIALS_ID = 'docker-hub-reg'
    DOCKER_IMAGE = 'shadyemad/gitops-app:latest'
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/shadyemad2/GitOps-ci-cd-with-Jenkins-and-Argocd.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          docker.build("${DOCKER_IMAGE}")
        }
      }
    }

    stage('Push Image') {
      steps {
        script {
          docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_HUB_CREDENTIALS_ID}") {
            def app = docker.image("${DOCKER_IMAGE}")
            app.push()
          }
        }
      }
    }

    stage('Update Kubernetes Manifest') {
      steps {
        sh '''
          echo "[INFO] Updating Kubernetes manifest with latest Docker image"

          # Replace image in app.yaml
          sed -i 's|image:.*|image: shadyemad/gitops-app:latest|' kubernetes/app.yaml

          # Set git user details (safe even if already set)
          git config user.name "jenkins"
          git config user.email "jenkins@example.com"

          # Stage the change
          git add kubernetes/app.yaml || true

          # Check if there is a change before committing
          if ! git diff --cached --quiet; then
            git commit -m "Update image to latest"
            git push origin main
            echo "[INFO] Git push completed."
          else
            echo "[INFO] No changes to commit."
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
      echo ' Pipeline failed.'
    }
  }
}


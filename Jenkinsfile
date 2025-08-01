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
          # Update the image inside the Kubernetes manifest
          sed -i 's|image:.*|image: shadyemad/gitops-app:latest|' kubernetes/app.yaml

          # Configure Git user for commit
          git config --global user.name "jenkins"
          git config --global user.email "jenkins@example.com"

          # Stage the file
          git add kubernetes/app.yaml || true

          # Only commit and push if there are actual changes
          if ! git diff --cached --quiet; then
            git commit -m "Update image to latest"
            git push origin main
          else
            echo "No changes to commit. Skipping git push."
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


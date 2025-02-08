pipeline {
  agent any

  stages {
    stage('Build Docker Images') {
      steps {
        sh '''
          docker --version
          docker compose build
        '''
      }
    }
    stage('Deploy to Production') {
      steps {
        sh '''
          docker compose up -d
        '''
      }
    }
  }

  post {
    always {
      sh '''
        docker image prune -a
      '''
    }
    success {
      echo 'Deployment to Production was successful!'
    }
    failure {
      sh '''
        docker compose down -v
      '''
      echo 'Deployment to Production failed!'
    }
  }
}

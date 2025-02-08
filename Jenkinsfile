pipeline {
  agent any

  stages {
    stage('Build Docket Imags') {
      steps {
        sh '''
          docker compose build
        '''
    }
  }

  stage('Deplo to Production') {
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
        docker compose down -v
      '''
    }
    success {
      echo 'Pipeline completed successfully!'
    }
    failure {
      echo 'Pipeline failed. Check logs for more details.'
    }
  }
}

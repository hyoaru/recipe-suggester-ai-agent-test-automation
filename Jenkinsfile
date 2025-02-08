pipeline {
  agent any

  triggers {
    githubPush()
  }

  environment {
    OPENAI_API_KEY = credentials('OPENAI_API_KEY')
    VITE_CORE_API_URL = credentials('VITE_CORE_API_URL')
  }

  options {
    // Required step for cleaning before build
    skipDefaultCheckout(true)
  }

  stages {
    stage('Clean Workspace') {
      steps {
        echo "Cleaning workspace..."
        cleanWs()
        echo "Cleaned the workspace."
      }
    } 

    stage('Checkout Source Code') {
      steps {
        echo "Checking out source code..."
        checkout scm
        echo "Checked out source code."
      }
    }

    stage('Populate ENV') {
      parallel {
        stage('Populate API ENV') {
          steps {
            dir('./server') {
              script {
                echo "Populating the API environment variables..."
                def envContent = """
                  OPENAI_API_KEY=${env.OPENAI_API_KEY}
                """.stripIndent()

                writeFile file: '.env', text: envContent
                echo "Server environment file (.env) created succesfully."
              }
            }
          }
        }

        stage('Populate Client ENV') {
          steps {
            dir('./client') {
              script {
                echo "Populating the Client environment variables..."
                def envContent = """
                  VITE_CORE_API_URL=${env.VITE_CORE_API_URL}
                """.stripIndent()

                writeFile file: '.env', text: envContent
                echo "Client environment file (.env) created succesfully."
              }
            }
          }
        }
      }
    }

    stage('Build Docker Images') {
      steps {
        echo "Building Docker images..."
        sh '''
          echo "Using docker version: $(docker --version)"
          docker compose build
        '''
        echo "Building images built."
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
      echo "Job name: ${env.JOB_NAME}"
      echo "Build url: ${env.BUILD_URL}"
      echo "Build id: ${env.BUILD_ID}"
      echo "Build display name: ${env.BUILD_DISPLAY_NAME}"
      echo "Build number: ${env.BUILD_NUMBER}"
      echo "Build tag: ${env.BUILD_TAG}"

      script {
        def causes = currentBuild.getBuildCauses()
        causes.each { cause ->
          echo "Build cause: ${cause.shortDescription}"
        }
      }

      sh '''
        yes | docker image prune -a
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

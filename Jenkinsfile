pipeline {
  agent any

  triggers {
    githubPush()
  }

  environment {
    OPENAI_API_KEY = credentials('OPENAI_API_KEY')
    VITE_CORE_API_URL = credentials('VITE_CORE_API_URL')
    CLIENT_BASE_URL = credentials('CLIENT_BASE_URL')
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
        
        
        stage('Populate Tests ENV') {
          steps {
            dir('./robot-tests') {
              script {
                echo "Populating the Tests environment variables..."
                def envContent = """
                  CLIENT_BASE_URL=${env.CLIENT_BASE_URL}
                """.stripIndent()

                writeFile file: '.env', text: envContent
                echo "Tests environment file (.env) created succesfully."
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
          
          echo "Building test images..."
          cd robot-tests && docker build -t recipe_suggester_ai_agent_robot_tests .
          echo "Test images built."
          
          docker images
        '''
        echo "Building images built."
      }
    }
    
    stage('Start Test Containers') {
      steps {
        echo "Starting test containers..."
        sh '''
          docker compose up -d
          docker ps -a
          
          sleep 10
        '''
        echo "Test containers started."
      }
    }
    
    stage("Run tests") {
      agent {
        docker {
          image 'recipe_suggester_ai_agent_robot_tests'
          args '--network=host'
          reuseNode true
        }
      }
      steps {
        dir("./robot-tests") {
          script {
            sh '''
              echo "Current directory: $(pwd)"
              ls -al

              echo "Running tests..."
              chmod +x ./run_tests.sh
              bash ./run_tests.sh
              echo "Tests completed."
            '''
          }
        }
      }
    }
    
    stage('Publish Test Reports') {
      steps {
        dir('./robot-tests') {
          robot(
            outputPath: "./results",
            passThreshold: 100.0,
            unstableThreshold: 90.0,
            disableArchiveOutput: true,
            outputFileName: "output.xml",
            logFileName: 'log.html',
            reportFileName: 'report.html',
            countSkippedTests: true,
          )
        }
      }
    }
    
    stage('Stop Test Containers') {
      steps {
        echo "Stopping test containers..."
        sh '''
          docker compose stop
        '''
        echo "Test containers stopped."
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
        
        // Remove dangling images
        sh '''
          danglingImages=$(docker images -f "dangling=true" -q)
          if [ -n "$danglingImages" ]; then
            docker image rmi $danglingImages
          else
            echo "No dangling images to remove."
          fi
        '''
      }
    }

    success {
      echo 'Deployment to Production was successful!'
    }

    failure {
      sh '''
        docker compose down
      '''
      echo 'Deployment to Production failed!'
    }
  }
}

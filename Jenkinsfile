pipeline {
  agent any
  parameters {
    choice(name: 'environment', choices: ['Infra'])
  }
  stages {
    stage('Setup') {
      steps {
        echo "Prerequisite Setup"
        sh "mkdir -p tmp"
        echo "Declaring Variables"
        switch(environment) {
          case 'Infra':
            role = "arn:aws:iam::103348857345:role/Admin"
            session = "NorfolkGaming-${environment}-Deployment"
            region = "eu-west-1"
            break
        echo "Assuming Role"
        sh("aws sts assume-role \
          --role-arn ${role} \
          --role-session-name ${session} \
          --region ${region} \
          > tmp/assume-role-output.json")
        echo "Preparing Credentials"
        credsJson = readFile("${WORKSPACE}/tmp/assume-role-output.json")
        credsObj = new groovy.json.JsonSlurperClassic().parseText(credsJson)
        }
      }
    }
    stage('Build') {
      steps {
        echo 'Building...'
      }
    }
    stage('Test') {
      steps {
        echo 'Testing...'
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deploying...'
      }
    }
  }
  post {
    success {
      script {
        echo 'Great Success...'
      }
    }
  }
}

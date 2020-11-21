import groovy.json.JsonSlurperClassic
pipeline {
  agent any
  parameters {
    choice(name: 'environment', choices: ['static', 'evolution'], description: "This is the environment to deploy to.")
    booleanParam(name: 'dev', defaultValue: false, description: 'Create dev vpc?')
    booleanParam(name: 'tfApply', defaultValue: false, description: 'Apply terraform?')
  }
  environment {
    PATH = "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/aws/bin"
  }
  stages {
    stage('Setup') {
      steps {
        script {
          echo "Prerequisite Setup"
          sh "mkdir tmp"
          echo "Declaring Variables"
          switch (environment) {
            case 'static':
              role = "arn:aws:iam::103348857345:role/Admin"
              session = "NorfolkGaming-${environment}-Deployment"
              region = "eu-west-1"
              break
            case 'evolution':
              role = "arn:aws:iam::103348857345:role/Admin"
              session = "NorfolkGaming-${environment}-Deployment"
              region = "eu-west-1"
              break
          }
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
    stage('Deploy') {
      steps {
        dir("${workspace}/terraform/deploys/${environment}") {
          script {
            echo "Initialising Terraform"
            sh("terraform init -no-color")
            sh("terraform plan -no-color \
              -var 'access_key=${credsObj.Credentials.AccessKeyId}' \
              -var 'secret_key=${credsObj.Credentials.SecretAccessKey}' \
              -var 'token=${credsObj.Credentials.SessionToken}' \
              -var dev=${dev}")
            if (params.tfApply) {
              echo "Deploying Terraform"
              sh("terraform apply plan.out -auto-approve -no-color")
            }
          }
        }
      }
    }
  }
  post {
    cleanup {
      script {
        echo 'End of Jenkinsfile'
        sh("rm -rf tmp")
      }
    }
  }
}

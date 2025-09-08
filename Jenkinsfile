pipeline {
  agent any
  environment {
    IMAGE = 'ghcr.io/ckrikas/auth-service'
  }
  stages {
    stage('Checkout') { steps { checkout scm } }
    stage('Docker login') {
      steps {
        withCredentials([string(credentialsId: 'ghcr_pat', variable: 'TOKEN')]) {
          sh 'echo $TOKEN | docker login ghcr.io -u ckrikas --password-stdin'
        }
      }
    }
    stage('Build') {
      steps {
        script { env.TAG = sh(script: 'git rev-parse --short=12 HEAD', returnStdout: true).trim() }
        sh 'docker build -t ${IMAGE}:${TAG} -t ${IMAGE}:latest .'
      }
    }
    stage('Push') {
      steps {
        sh '''
          docker push ${IMAGE}:${TAG}
          docker push ${IMAGE}:latest
        '''
      }
    }
    stage('Trigger deploy') {
      when { expression { currentBuild.currentResult == 'SUCCESS' } }
      steps { build job: 'deploy-prod', wait: false }
    }
  }
  post { always { sh 'docker logout ghcr.io || true' } }
}

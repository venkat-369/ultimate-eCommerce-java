pipeline {
  agent any
  tools { maven 'Maven3' }
  environment {
    DOCKER_CREDENTIALS = 'dockerhub-creds'
    IMAGE_NAME = 'ultimate-ecommerce-java'
  }
  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/ChakriAmajala/ultimate-eCommerce-java.git'
      }
    }
    stage('Build & Package') {
      steps {
        sh 'mvn clean package -DskipTests'
      }
    }
    stage('Build Docker Image') {
      steps {
        script {
          def tag = "${env.BUILD_NUMBER}"
          sh "docker build -t yourdockerhubid/${IMAGE_NAME}:${tag} ."
        }
      }
    }
    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS,
                         usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
          sh "docker push yourdockerhubid/${IMAGE_NAME}:${env.BUILD_NUMBER}"
          sh "docker tag yourdockerhubid/${IMAGE_NAME}:${env.BUILD_NUMBER} yourdockerhubid/${IMAGE_NAME}:latest"
          sh "docker push yourdockerhubid/${IMAGE_NAME}:latest"
        }
      }
    }
    stage('Deploy') {
      steps {
        sh """
          docker stop ${IMAGE_NAME} || true
          docker rm ${IMAGE_NAME} || true
          docker run -d --name ${IMAGE_NAME} -p 8080:8080 yourdockerhubid/${IMAGE_NAME}:latest
        """
      }
    }
  }
}


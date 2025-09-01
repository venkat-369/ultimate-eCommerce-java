pipeline {
  agent any
  tools { maven 'maven3' }
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
        sh "docker build -t yourdockerhubid/${IMAGE_NAME}:${BUILD_NUMBER} ."
      }
    }
    stage('Push to Docker Hub') {
    steps {
        withCredentials([usernamePassword(credentialsId: 'docker-hub1', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            sh '''
                echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                docker push yourdockerhubid/ultimate-ecommerce-java:8
            '''
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


pipeline {
    agent any

    environment {
        IMAGE_NAME = "ultimate-ecommerce-java"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ChakriAmajala/ultimate-eCommerce-java.git'
            }
        }

        stage('Build & Package') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub1', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker build -t $DOCKER_USER/${IMAGE_NAME}:${BUILD_NUMBER} .
                        docker push $DOCKER_USER/${IMAGE_NAME}:${BUILD_NUMBER}
                        docker tag $DOCKER_USER/${IMAGE_NAME}:${BUILD_NUMBER} $DOCKER_USER/${IMAGE_NAME}:latest
                        docker push $DOCKER_USER/${IMAGE_NAME}:latest
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    docker stop ${IMAGE_NAME} || true
                    docker rm ${IMAGE_NAME} || true
                    docker run -d --name ${IMAGE_NAME} -p 8091:8080 $DOCKER_USER/${IMAGE_NAME}:latest
                '''
            }
        }
    }
}


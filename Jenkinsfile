pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/ChakriAmajala/ultimate-eCommerce-java.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def IMAGE_NAME = "ultimate-ecommerce"
                    def DOCKER_USER = "chakriamajala"

                    sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    def IMAGE_NAME = "ultimate-ecommerce"
                    def DOCKER_USER = "chakriamajala"

                    withDockerRegistry([ credentialsId: 'dockerhub-credentials', url: '' ]) {
                        sh "docker push ${DOCKER_USER}/${IMAGE_NAME}:latest"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    def IMAGE_NAME = "ultimate-ecommerce"
                    def DOCKER_USER = "chakriamajala"

                    sh "docker rm -f ${IMAGE_NAME} || true"
                    sh "docker run -d --name ${IMAGE_NAME} -p 8091:8080 ${DOCKER_USER}/${IMAGE_NAME}:latest"
                }
            }
        }
    }
}


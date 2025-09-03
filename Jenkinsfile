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
                docker build -t $DOCKER_USER/ultimate-ecommerce-java:$BUILD_NUMBER .
                docker push $DOCKER_USER/ultimate-ecommerce-java:$BUILD_NUMBER
            '''
        }
    }
}


       stage('Deploy') {
    steps {
        sh '''
        docker rm -f ultimate-ecommerce || true
        docker run -d --name ultimate-ecommerce -p 8091:8080 chakriamajaladocker/ultimate-ecommerce-java:latest
        '''
    }
}


    }

}

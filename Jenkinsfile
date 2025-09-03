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

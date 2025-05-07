pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Ayoyinka2456/JavaWeb3.git'
            }
        }

        stage('Install Docker') {
            steps {
                sh '''
                    if ! command -v docker >/dev/null; then
                        sudo yum -y install docker
                        sudo systemctl start docker
                        sudo systemctl enable docker
                    fi
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh 'sudo docker build -t javaweb-app .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                    if sudo docker ps -a --format '{{.Names}}' | grep -Eq '^jWeb1$'; then
                        sudo docker rm -f jWeb1
                    fi
                    sudo docker run -d -p 8080:8080 --name jWeb1 javaweb-app
                '''
            }
        }
    }

    post {
        always {
            emailext(
                subject: '${PROJECT_NAME} - Build #${BUILD_NUMBER} - ${BUILD_STATUS}',
                body: 'Check console output at ${BUILD_URL} to view the results.',
                to: 'yimikacrations@gmail.com'
            )
        }
    }
}

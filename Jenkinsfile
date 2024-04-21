pipeline {
    agent any

    parameters {
        string(name: 'IMAGE_NAME', defaultValue: 'projet1', description: 'Nom de l\'image Docker')
        string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Tag de l\'image Docker')
        string(name: 'VOTRE_ID_GIT', defaultValue: 'EchotherealYnov', description: 'Votre ID Git')
        string(name: 'DOCKERHUB_ID', defaultValue: 'echotherealynov', description: 'Votre ID Docker Hub')
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Construction de l'image Docker
                    docker.build("${params.DOCKERHUB_ID}/${params.IMAGE_NAME}:${params.IMAGE_TAG}", '.')
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
            // Exécution du conteneur Docker
            docker.image("${params.DOCKERHUB_ID}/${params.IMAGE_NAME}:${params.IMAGE_TAG}")
                .run("-d -p 80:5000 --name ${params.IMAGE_NAME}_container -e PORT=5000")
            sleep(5)
            }
            }
        }

        stage('HTTP Request') {
            steps {
                httpRequest url: 'http://172.17.0.2', validResponseCodes: '200'
            }
        }

        stage('Execute Script Shell') {
            steps {
        script {
            // Arrêt et suppression du conteneur Docker
            docker.container("${params.IMAGE_NAME}_container").stop()
            docker.container("${params.IMAGE_NAME}_container").remove(force: true)
        }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Pousser l'image Docker vers Docker Hub
                    docker.withRegistry('https://index.docker.io/v2/', '019a007c-cd12-44ff-8479-6e8c9c7ba103') {
                        docker.image("${params.DOCKERHUB_ID}/${params.IMAGE_NAME}:${params.IMAGE_TAG}").push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed :('
        }
    }
}

pipeline {
    agent any

    environment {
        GOGS_credential = credentials('gogs')
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Checking out code from Gogs repository"
                git branch: 'main', url: 'http://34.238.49.245:10880/Ahmd-Sadka/Ahmed_Mohamedy.git', credentialsId: 'gogs'
  }
}
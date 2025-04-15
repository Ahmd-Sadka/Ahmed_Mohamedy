pipeline {
    agent any

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'false'
        DOCKER_IMAGE_NAME = 'myapp'
        DOCKER_IMAGE_TAG = 'latest'
        DOCKER_IMAGE_FILE = "${DOCKER_IMAGE_NAME}.tar"
        RECIPIENTS = 'team@example.com'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code from Gogs repository"
                git(
                    url: 'http://34.238.49.245:10880/Ahmd-Sadka/Ahmed_Mohamedy.git',
                    branch: 'master',
                    credentialsId: 'gogs'
                )
            }
        }

        stage('Install Apache on VM3') {
            steps {
                echo "Running Ansible playbook to install Apache on VM3"
                sh 'cd Ansible'
                sh 'ansible-playbook InstallApache.yml'
            }
        }

        stage('Build and Archive Docker Image') {
            steps {
                echo "Building Docker image"
                sh "docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ."

                echo "Saving Docker image to tar file"
                sh "docker save ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} -o ${DOCKER_IMAGE_FILE}"

                echo "Archiving Docker image tar file"
                archiveArtifacts artifacts: "${DOCKER_IMAGE_FILE}", fingerprint: true
            }
        }

        stage('Send Build Notification') {
            steps {
                script {
                    def deployUsers = sh(script: "getent group deployG | cut -d: -f4", returnStdout: true).trim()
                    def buildTime = new Date().format("yyyy-MM-dd HH:mm:ss", TimeZone.getTimeZone('Africa/Cairo'))
                    def dockerImagePath = "${env.WORKSPACE}/${DOCKER_IMAGE_FILE}"

                    emailext(
                        subject: "Jenkins Build Notification: ${currentBuild.fullDisplayName}",
                        body: """
                            <p>Pipeline Execution Status: ${currentBuild.currentResult}</p>
                            <p>DeployG Group Users: ${deployUsers}</p>
                            <p>Execution Time: ${buildTime}</p>
                            <p>Docker Image Path: ${dockerImagePath}</p>
                        """,
                        recipientProviders: [[$class: 'DevelopersRecipientProvider']],
                        to: "${RECIPIENTS}"
                    )
                }
            }
        }

        stage('Install Grafana on VM4') {
            steps {
                echo "Running Ansible playbook to install Grafana on VM4"
                sh 'ansible-playbook -i inventory SetupGrafana.yml'
            }
        }

        stage('Send Grafana Setup Notification') {
            steps {
                script {
                    def grafanaURL = 'http://vm4.example.com:3000' // Replace with actual Grafana URL

                    emailext(
                        subject: "Grafana Setup Notification: ${currentBuild.fullDisplayName}",
                        body: """
                            <p>Grafana setup completed successfully.</p>
                            <p>Access Grafana Dashboard: <a href="${grafanaURL}">${grafanaURL}</a></p>
                        """,
                        recipientProviders: [[$class: 'DevelopersRecipientProvider']],
                        to: "${RECIPIENTS}"
                    )
                }
            }
        }
    }

    post {
        failure {
            emailext(
                subject: "Jenkins Build Failed: ${currentBuild.fullDisplayName}",
                body: """
                    <p>The Jenkins build has failed.</p>
                    <p>Check the Jenkins console output for more details.</p>
                """,
                recipientProviders: [[$class: 'DevelopersRecipientProvider']],
                to: "${RECIPIENTS}"
            )
        }
    }
}

pipeline {
    agent any

    tools{
        ansible 'ansible'
    }
    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'false'
        DOCKER_IMAGE_NAME = 'myapp'
        DOCKER_IMAGE_TAG = "${env.BUILD_ID}"
        DOCKER_IMAGE_FILE = "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}.tar"
        RECIPIENTS = 'ahmd.sadkaa@gmail.com'
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
                withCredentials([file(credentialsId: 'ansible-key', variable: 'ANSIBLE_KEY')]) {
                    dir('./Ansible') {
                        echo "Running Ansible playbook to install Apache on VM3"
                        sh 'pwd'
                        //sh 'ls -l'
                        sh 'ansible-playbook InstallApache.yml --private-key $ANSIBLE_KEY'
                }
                }
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
                    def deployUsers = sh(script: "cd Ansible && ansible web_server -m shell -a 'cat Scripts/members.txt'", returnStdout: true).trim()
                    def allohterUsers = sh(script: "cd Ansible && ansible web_server -m shell -a 'cat Scripts/non_members.txt'", returnStdout: true).trim()
                    def buildTime = new Date().format("yyyy-MM-dd HH:mm:ss", TimeZone.getTimeZone('Africa/Cairo'))
                    def dockerImagePath = "${env.WORKSPACE}/${DOCKER_IMAGE_FILE}"

                    emailext(
                        subject: "Jenkins Build Notification: ${currentBuild.fullDisplayName}",
                        body: """
                            <p>Pipeline Execution Status: ${currentBuild.currentResult}</p>
                            <p>DeployG Group Users: ${deployUsers}</p>
                            <p>Non-DeployG Group Users: ${allohterUsers}</p>
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
                withCredentials([file(credentialsId: 'ansible-key', variable: 'ANSIBLE_KEY')]) {
                    dir('./Ansible') {
                        echo "Running Ansible playbook to install Grafana on VM4"
                        sh 'pwd'
                        //sh 'ls -l'
                        sh 'ansible-playbook SetupGrafana.yml --private-key $ANSIBLE_KEY'
                }
                }
            }
        }

        stage('Send Grafana Setup Notification') {
            steps {
                script {
                    def grafanaURL = 'http://54.166.94.37/:3000'

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

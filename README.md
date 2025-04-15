🚀 Jenkins CI/CD Pipeline with Ansible & Docker
📋 Overview
This project establishes a robust CI/CD pipeline using Jenkins, integrating Ansible for configuration management and Docker for containerization. It automates the following tasks:

Apache Installation on VM3 via Ansible.

Docker Image Build from the provided Dockerfile.

Docker Image Archiving as a .tar file.

Email Notifications detailing pipeline execution status, deploy group users, execution timestamp, and Docker image path.

Grafana Setup on VM4 via Ansible.

Grafana Notification with setup status and dashboard URL.

🧰 Prerequisites
Jenkins installed and configured.

Ansible installed on the Jenkins host.

Docker installed on the Jenkins host.

Gogs repository accessible at http://34.238.49.245:10880.

SSH Access to VM3 and VM4 for Ansible playbook execution.

Email Server configured for sending notifications.

🛠️ Setup Instructions
Clone the Repository:

bash
Copy
Edit
git clone http://34.238.49.245:10880/Ahmd-Sadka/Ahmed_Mohamedy.git
cd Ahmed_Mohamedy
Configure Jenkins:

Create a new Jenkins pipeline job named Ahmed_mohamedy.

In the pipeline configuration, set the repository URL to http://34.238.49.245:10880/Ahmd-Sadka/Ahmed_Mohamedy.git.

Use the credential ID gogs for repository access.

Set Up Webhook in Gogs:

Navigate to your repository in Gogs.

Go to Settings > Webhooks > Add Webhook.

Set the payload URL to:

perl
Copy
Edit
http://<jenkins-server>/gogs-webhook/?job=Ahmed_mohamedy
Replace <jenkins-server> with your Jenkins server's address.

Configure Ansible Inventory:

Update the inventory file with the IP addresses or hostnames of VM3 and VM4.

Set Up Email Notifications:

Configure Jenkins to use your SMTP server for sending emails.

Ensure the mail plugin is installed and properly configured.

📂 Project Structure
css
Copy
Edit
Ahmed_Mohamedy/
├── Jenkinsfile
├── roles/
│   ├── install_apache/
│   │   ├── tasks/
│   │   │   └── main.yml
│   │   └── README.md
│   └── setup_grafana/
│       ├── tasks/
│       │   └── main.yml
│       └── README.md
├── Dockerfile
├── inventory
└── scripts/
    ├── build_docker.sh
    └── send_email.sh
📜 Jenkinsfile Breakdown
groovy
Copy
Edit
pipeline {
    agent any

    environment {
        GOGS_CREDENTIAL = credentials('gogs')
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code from Gogs repository"
                git branch: 'main', url: 'http://34.238.49.245:10880/Ahmd-Sadka/Ahmed_Mohamedy.git', credentialsId: 'gogs'
            }
        }
        stage('Install Apache on VM3') {
            steps {
                sh 'ansible-playbook -i inventory roles/install_apache/tasks/main.yml'
            }
        }
        stage('Build and Archive Docker Image') {
            steps {
                sh './scripts/build_docker.sh'
            }
        }
        stage('Send Deployment Email') {
            steps {
                sh './scripts/send_email.sh'
            }
        }
        stage('Setup Grafana on VM4') {
            steps {
                sh 'ansible-playbook -i inventory roles/setup_grafana/tasks/main.yml'
            }
        }
        stage('Send Grafana Setup Email') {
            steps {
                sh './scripts/send_email.sh --grafana'
            }
        }
    }
}
📦 Ansible Roles Documentation
📁 install_apache
Description: Installs and configures Apache on VM3.

Tasks:

Update package repositories.

Install Apache.

Start and enable Apache service.

Variables:

apache_port: Port on which Apache will listen (default: 80).

Usage:

bash
Copy
Edit
ansible-playbook -i inventory roles/install_apache/tasks/main.yml
📁 setup_grafana
Description: Installs and configures Grafana on VM4.

Tasks:

Download and install Grafana.

Start and enable Grafana service.

Configure Grafana dashboard.

Variables:

grafana_admin_user: Admin username for Grafana.

grafana_admin_password: Admin password for Grafana.

Usage:

bash
Copy
Edit
ansible-playbook -i inventory roles/setup_grafana/tasks/main.yml
🐳 Docker Image Build & Archive
The build_docker.sh script performs the following:

Builds the Docker image using the provided Dockerfile.

Tags the image appropriately.

Saves the image as a .tar file.

Archives the .tar file for future use.

Usage:

bash
Copy
Edit
./scripts/build_docker.sh
📧 Email Notifications
The send_email.sh script sends email notifications containing:

Pipeline execution status.

List of users in the deployG group.

Date and time of execution.

Path to the Docker image .tar file.

Grafana dashboard URL (if applicable).

Usage:

bash
Copy
Edit
./scripts/send_email.sh
# For Grafana setup notification
./scripts/send_email.sh --grafana
🧪 Testing
To test the Ansible playbooks:

bash
Copy
Edit
ansible-playbook -i inventory roles/install_apache/tasks/main.yml --check
ansible-playbook -i inventory roles/setup_grafana/tasks/main.yml --check
To test the Jenkins pipeline:

Make a commit to the main branch.

Observe the pipeline execution in Jenkins.

📄 License
This project is licensed under the MIT License.

🤝 Contributing
Contributions are welcome! Please fork the repository and submit a pull request.

Feel free to customize this README.md to better fit your project's specifics.


## Project Description:
### 1. The candidate must provision four VMs with the following services (Minmun specs are aceptable):

- VM1: Jenkins Server
- VM2: Gogs Server
- VM3: Web Server (Apache)
- VM4: A monitoring server with Grafana installed.


### 2. User Management on VM3:
*The candidate will create users on VM3 as follows:*

- Using bash script create three users named Devo, Testo, and Prodo on VM3.
- Add these users to a group named "deployG" for centralized access control.
- Implement a user deletion script to remove a user based on the username provided as an argument.

### 3. Gogs Integration with Jenkins:
The candidate will integrate Gogs with Jenkins to automate deployment processes triggered by web hook.


### 4. Creating a Git repository on Gogs.
- Develop an Ansible playbook named InstallApache.yml within the repository to automate the installation of Apache on VM3 (ensure the service is up and running).
- Develop a Bash script named NotGroupMembers.sh to retrieve a list of users not inside the "deployG" group.
- Create Ansible playbook named SetupGrafana.yml to install and configure Grafana on VM4.

### 5. CI/CD Pipeline Configuration:
The candidate will configure Jenkins to monitor the Gogs repository for any changes.

### 6. Pipeline Automation:
Upon detecting a code commit, the Jenkins pipeline will autonomously execute the following actions:

- Trigger the execution of the Ansible playbook (InstallApache.yml) for Apache installation on VM3.
- Build a Docker image using the provided Dockerfile, then save it locally using the command docker save <image_name> > <image_name>.tar, and archive the tar file.

- Run a final stage to send an email notification. This notification will include vital details such as:
    - Pipeline execution status.
    - List of users in the "deployG" group.
    - Date and time of the pipeline execution.
    - Path to Docker image.tar
- Trigger the execution of the Ansible playbook (SetupGrafana.yml) for Grafana installation on VM4.
- Send a separate email notification containing the Grafana setup status and the URL to access the Grafana dashboard.

### *Additional Information:*
- Configure firewall rules or port forwarding if required.
- Ensure that the servers' operating systems are either CentOS or RockyLinux.
- You have the right to choose which email notification configuration to use Bash, Ansible, or Jenkins for implementation.

### `Definition of Done to Proceed to Next Phase:` 

1- Sharing a git repo with Three3mr (Github ID) as collaborator containing the below:
  - Bash scripts.
  - Ansible playbooks.
  - Jenkinsfile containing the stages.
  - README file documenting the Ansible playbooks and Jenkins pipeline configuration with screenshoots.
  - Use your first and last names as the repository name using github.
  - Presentation:
    - Sharing a presentation with your: <first_name>.<last_name>
    - Screenshots showcases your understanding of the project and the implemented solution.
    - Maximum 6 slide (no need for intro/index slides).


### ` Candidate Inputs: `

.....

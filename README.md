# 🚀 Jenkins CI/CD Pipeline | Ansible | Docker | Notifications

Welcome to the **Ahmed Mohamedy DevOps Project**—an end-to-end automation solution demonstrating best practices in provisioning, configuration management, CI/CD, and monitoring. 💙

This project provisions four VMs, integrates GitOps with Gogs and Jenkins, automates deployments with Ansible, containerizes applications with Docker, and provides rich notifications to keep stakeholders informed.

---

## 🌟 Key Features

- **Multi-VM Provisioning**: Four VMs (Jenkins, Gogs, Apache Web Server, Grafana Monitoring) on CentOS/RockyLinux.
- **User Management Automation**: Bash scripts to create (`Devo`, `Testo`, `Prodo`) and remove users, all within the `deployG` group.
- **GitOps Workflow**: Gogs + Jenkins integration via webhooks for automated pipeline triggers.
- **Ansible Playbooks**:
  - `InstallApache.yml` for Apache setup on VM3.
  - `SetupGrafana.yml` for Grafana setup on VM4.
- **CI/CD Pipeline**:
  - Checks out code from Gogs.
  - Runs Ansible playbooks.
  - Builds and archives Docker images.
  - Sends detailed email notifications.
- **Monitoring & Notifications**: Grafana for observability, Jenkins Email Extension for build and Grafana setup alerts.

---

## 🧩 Tech Stack

| Tool        | Purpose                                    |
|-------------|--------------------------------------------|
| Vagrant     | Local VM provisioning (or Terraform/libvirt) |
| Ansible     | Configuration management & playbooks       |
| Jenkins     | CI/CD automation                           |
| Gogs        | Self-hosted Git service                    |
| Docker      | Containerization & image archiving         |
| Bash        | Scripting for user management and utilities |
| Grafana     | Monitoring dashboard                       |
| SMTP / Mail | Email notifications                        |

---

## 📸 Architecture Overview

1. **VM Provisioning**:  
   - VM1: Jenkins Server  
   - VM2: Gogs Server  
   - VM3: Apache Web Server  
   - VM4: Grafana Monitoring Server  

2. **User Management** (VM3):  
   - `create_users.sh`: Creates `Devo`, `Testo`, `Prodo` and adds them to `deployG`.  
   - `delete_user.sh`: Removes a given user.

3. **GitOps Integration**:  
   - Gogs webhook triggers Jenkins pipeline on push.

4. **Ansible Automation**:  
   - `InstallApache.yml` for Apache.  
   - `NotGroupMembers.sh` to list users not in `deployG`.  
   - `SetupGrafana.yml` for Grafana.

5. **CI/CD Pipeline** (Jenkinsfile):  
   - Checkout → Ansible Apache → Docker build & save → Email → Ansible Grafana → Email.

---

## ✅ Getting Started

### Prerequisites

- Vagrant/VirtualBox **or** Terraform/libvirt (for VM provisioning)  
- Jenkins installed or accessible  
- Ansible on control machine  
- Docker on Jenkins agent  
- Gogs server credentials  
- SMTP server for email notifications

### 1. Clone the Repository

```bash
git clone https://github.com/AhmedMohamedy/Ahmed_Mohamedy.git
cd Ahmed_Mohamedy
```

### 2. Provision VMs

```bash
# Using Vagrant
vagrant up
# Or Terraform
cd terraform && terraform init && terraform apply
```

### 3. Configure Inventory

Edit `inventory` with VM IPs and SSH key paths:

```ini
[jenkins]
192.168.56.10 ansible_user=ec2-user ansible_private_key_file=~/.ssh/id_rsa

[gogs]
192.168.56.11 ansible_user=git ansible_private_key_file=~/.ssh/id_rsa

[webserver]
192.168.56.12 ansible_user=root ansible_private_key_file=~/.ssh/id_rsa

[monitoring]
192.168.56.13 ansible_user=root ansible_private_key_file=~/.ssh/id_rsa
```

### 4. Run Playbooks

```bash
ansible-playbook -i inventory InstallApache.yml
ansible-playbook -i inventory SetupGrafana.yml
```

### 5. Setup Jenkins

- Create a Pipeline job named `Ahmed_Mohamedy`.
- Point to the Gogs repo URL.
- Add webhook in Gogs: `http://<jenkins>/gogs-webhook/?job=Ahmed_Mohamedy`
- Configure credentials (`gogs`, `ansible-key`).

### 6. Trigger Pipeline

Push code to Gogs and watch Jenkins execute the pipeline stages.

---

## 🔒 Security & Best Practices

- **SSH Key Management**: Use Ansible Vault for sensitive vars.  
- **Idempotent Scripts**: Ensure playbooks are re-runnable without side-effects.  
- **Least Privilege**: Run services under non-root users.  
- **Firewall Rules**: Open only necessary ports (22, 80, 3000, 8080).

---

## 📜 Definition of Done

- GitHub repo with:
  - Bash scripts (`create_users.sh`, `delete_user.sh`, `NotGroupMembers.sh`)
  - Ansible playbooks (`InstallApache.yml`, `SetupGrafana.yml`)
  - `Jenkinsfile`
  - This `README.md`
- Presentation (`Ahmed_Mohamedy.pptx` or `.pdf`) with screenshots (max 6 slides).
- Collaborator: `Three3mr`.

---

## 🤓 Quote

> “Automation is not about removing humans—it’s about elevating their impact.” – DevSecOps Wisdom 💡

---

## ❤️ Credits

Made with ☕, 🖥️, and a passion for DevOps by **Ahmed Mohamedy**.

---

## 📜 License

This project is licensed under the MIT License.

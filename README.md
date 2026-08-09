# 🚀 Jerney DevSecOps Platform

A complete DevOps/DevSecOps deployment project for the **Jerney** application. This repository contains the application deployment configuration, containerization, Kubernetes manifests, CI/CD configuration, and Argo CD setup required to deploy and manage the application.

The purpose of this project is to demonstrate a practical DevOps workflow where application code is containerized, deployed to Kubernetes, and managed through GitOps using Argo CD.

---

## 📌 Table of Contents

- [Project Overview](#-project-overview)
- [Project Objectives](#-project-objectives)
- [Architecture](#-architecture)
- [Technology Stack](#-technology-stack)
- [Repository Structure](#-repository-structure)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Application Setup](#-application-setup)
- [Docker Setup](#-docker-setup)
- [Kubernetes Setup](#-kubernetes-setup)
- [Argo CD Setup](#-argo-cd-setup)
- [Argo CD Dashboard](#-argo-cd-dashboard)
- [Git Workflow](#-git-workflow)
- [Deployment Workflow](#-deployment-workflow)
- [Restart and Recovery](#-restart-and-recovery)
- [Troubleshooting](#-troubleshooting)
- [Useful Commands](#-useful-commands)
- [Security Notes](#-security-notes)
- [Future Improvements](#-future-improvements)

---

## 📖 Project Overview

**Jerney DevSecOps Platform** is designed to provide an end-to-end deployment workflow for the Jerney application.

The project follows modern DevOps practices:

```text
Developer
    │
    ▼
Git Repository
    │
    ▼
CI/CD Pipeline
    │
    ├── Build
    ├── Test
    ├── Security Checks
    └── Container Image
             │
             ▼
       Container Registry
             │
             ▼
        Kubernetes
             │
             ▼
          Argo CD
             │
             ▼
       Application
```

Argo CD is used as the GitOps deployment and management layer. Kubernetes resources can be configured and managed from the Argo CD dashboard.

---

## 🎯 Project Objectives

The main objectives of this project are:

- Containerize the application using Docker.
- Deploy the application on Kubernetes.
- Manage Kubernetes resources using Argo CD.
- Follow a GitOps-based deployment approach.
- Provide a repeatable project setup.
- Maintain deployment configuration inside Git.
- Make the project easy to understand and reproduce.
- Provide a central location for future maintenance and troubleshooting.

---

## 🏗️ Architecture

The high-level architecture is:

```text
                    ┌─────────────────────┐
                    │      Developer      │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │    Git Repository   │
                    │   GitHub / GitLab   │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │    CI/CD Pipeline   │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │  Container Registry │
                    │    Docker Images    │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │     Kubernetes      │
                    │       Cluster       │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │       Argo CD       │
                    │      GitOps CD       │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │   Jerney Application│
                    └─────────────────────┘
```

---

## 🛠️ Technology Stack

| Technology    | Purpose                          |
| ------------- | -------------------------------- |
| 🐧 Linux      | Server / development environment |
| 🐳 Docker     | Application containerization     |
| ☸️ Kubernetes | Container orchestration          |
| 🔄 Argo CD    | GitOps continuous delivery       |
| 🌐 Nginx      | Web server / reverse proxy       |
| 🟢 Node.js    | Backend runtime                  |
| ⚛️ React      | Frontend                         |
| 🗄️ PostgreSQL | Database                         |
| 🔧 Git        | Source-code management           |
| 🐙 GitHub     | Source-code repository           |

---

# 📁 Repository Structure

The repository is:

```text
jerney-devsecops-platform/
│
├── backend/
│   ├── src/
│   ├── package.json
│   ├── package-lock.json
│   ├── Dockerfile
│   └── .env
│
├── frontend/
│   ├── src/
│   ├── public/
│   ├── package.json
│   ├── package-lock.json
│   ├── Dockerfile
│   └── ...
│
├── kubernetes/
│   ├── namespace.yaml
│   ├── backend-deployment.yaml
│   ├── backend-service.yaml
│   ├── frontend-deployment.yaml
│   ├── frontend-service.yaml
│   └── ...
│
├── argocd/
│   └── ...
│
├── scripts/
│   └── setup-argocd.sh
│
├── docker-compose.yml
│
└── README.md
```

> The exact structure may change as the project evolves. Keep this section updated whenever directories or deployment files are added or removed.

---

# 💻 Prerequisites

Before setting up the project, make sure the following are installed.

## 1. Git

Check:

```bash
git --version
```

Install on Ubuntu:

```bash
sudo apt update
sudo apt install git -y
```

---

## 2. Docker

Check:

```bash
docker --version
```

Install:

```bash
sudo apt update
sudo apt install docker.io -y
```

Enable Docker:

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

Verify:

```bash
sudo systemctl status docker
```

Optional: allow the current user to execute Docker without `sudo`:

```bash
sudo usermod -aG docker $USER
```

Log out and log back in after running the command.

---

## 3. Node.js and npm

Check:

```bash
node --version
npm --version
```

These are required for local frontend/backend development.

---

## 4. kubectl

Check:

```bash
kubectl version --client
```

`kubectl` is required to communicate with the Kubernetes cluster.

Verify cluster connectivity:

```bash
kubectl get nodes
```

---

## 5. Kubernetes Cluster

A Kubernetes cluster must be available before deploying the application.

Verify:

```bash
kubectl get nodes
```

Expected example:

```text
NAME              STATUS   ROLES
node-1            Ready    control-plane
```

---

# 📦 Installation

Clone the repository:

```bash
git clone https://github.com/adnan-shaikh09/jerney-devsecops-platform.git
```

Move into the project:

```bash
cd jerney-devsecops-platform
```

Verify:

```bash
git status
```

---

# 🟢 Application Setup

## Backend

Move into the backend directory:

```bash
cd backend
```

Install dependencies:

```bash
npm install
```

Create the environment file:

```bash
nano .env
```

Example:

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=jerney_db
DB_USER=jerney_user
DB_PASSWORD=your_password
```

Do not commit `.env` to Git.

Add it to `.gitignore`:

```text
.env
node_modules/
```

Start the backend:

```bash
npm start
```

---

# ⚛️ Frontend Setup

Move into the frontend directory:

```bash
cd frontend
```

Install dependencies:

```bash
npm install
```

Build the frontend:

```bash
npm run build
```

The production build is normally generated inside:

```text
dist/
```

---

# 🐳 Docker Setup

Build the backend image:

```bash
docker build -t jerney-backend ./backend
```

Build the frontend image:

```bash
docker build -t jerney-frontend ./frontend
```

Check images:

```bash
docker images
```

Run containers manually when required:

```bash
docker run -d --name jerney-backend jerney-backend
```

```bash
docker run -d --name jerney-frontend jerney-frontend
```

Check running containers:

```bash
docker ps
```

Check logs:

```bash
docker logs jerney-backend
```

```bash
docker logs jerney-frontend
```

---

# ☸️ Kubernetes Setup

Verify Kubernetes:

```bash
kubectl get nodes
```

Check namespaces:

```bash
kubectl get namespaces
```

Create a namespace if the project uses one:

```bash
kubectl create namespace jerney
```

Apply Kubernetes manifests manually when required:

```bash
kubectl apply -f kubernetes/
```

Check resources:

```bash
kubectl get all -n jerney
```

Check pods:

```bash
kubectl get pods -n jerney
```

Check services:

```bash
kubectl get svc -n jerney
```

Check deployments:

```bash
kubectl get deployments -n jerney
```

### 🌐 Accessing the Jerney Frontend

After deploying the application to Kubernetes, use port-forwarding to access the frontend locally:

```bash
kubectl port-forward service/jerney-frontend 8080:80 -n jerney --address=0.0.0.0
```

Once port-forwarding is active, open the application in your browser:

http://localhost:8080

Keep the terminal running while using the application. Press Ctrl+C to stop port-forwarding.

---

# 🔄 Argo CD Setup

Argo CD is used for GitOps-based deployment and Kubernetes application management.

The project includes a setup script:

```bash
scripts/setup-argocd.sh
```

Give execute permission:

```bash
chmod +x scripts/setup-argocd.sh
```

Run:

```bash
./scripts/setup-argocd.sh
```

The script:

1. Creates the `argocd` namespace.
2. Installs Argo CD.
3. Waits for the Argo CD components.
4. Retrieves the initial admin password.
5. Displays the credentials in the terminal.
6. Starts port forwarding for the dashboard.

---

# 🔐 Argo CD Login

The Argo CD dashboard is exposed locally on:

```text
https://localhost:30801
```

The default username is:

```text
admin
```

The setup script prints the generated initial admin password in the terminal.

Open:

```text
https://localhost:30801
```

in your browser.

Because Argo CD uses HTTPS with its default certificate, the browser may display a certificate warning when using the local port-forward. This is expected for a local setup.

---

# 🔌 Argo CD Port

The project uses:

```text
30801
```

for the local Argo CD dashboard.

The port forwarding command is:

```bash
kubectl port-forward svc/argocd-server -n argocd 30801:8081 --address=0.0.0.0
```

Then access:

```text
https://localhost:8081
```

---

# 🔁 Argo CD After Server Restart

The Argo CD installation remains inside the Kubernetes cluster after a server/EC2 restart as long as the Kubernetes cluster itself and its persistent configuration are available.

After reconnecting to the server, verify:

```bash
kubectl get pods -n argocd
```

If Argo CD pods are running, start the dashboard port-forward again:

```bash
kubectl port-forward svc/argocd-server -n argocd 30801:8081 --address=0.0.0.0
```

Then open:

```text
http://localhost:30801
```

Port forwarding is a temporary connection and normally needs to be started again after a terminal/session restart.

---

# 🚀 Deployment Using Argo CD

After Argo CD is installed and the dashboard is accessible:

1. Open the Argo CD dashboard.
2. Login using:
   - Username: `admin`
   - Password: printed by the setup script.
3. Create a new Argo CD application.
4. Configure the Git repository.
5. Select the Kubernetes manifests directory.
6. Configure the destination Kubernetes cluster.
7. Create the application.
8. Sync the application.

The exact application configuration should be maintained according to the Kubernetes manifests and repository structure used by the project.

---

# 🔄 Git Workflow

Check the current branch:

```bash
git branch
```

Check repository status:

```bash
git status
```

Add changes:

```bash
git add .
```

Create a commit:

```bash
git commit -m "Update project"
```

Pull remote changes before pushing:

```bash
git pull --rebase origin main
```

Push:

```bash
git push origin main
```

## ⚠️ Why `git push` Can Be Rejected

If Git shows:

```text
[rejected] main -> main (fetch first)
```

it means the remote `main` branch contains commits that are not present in your local branch.

Use:

```bash
git pull --rebase origin main
```

Then:

```bash
git push origin main
```

Avoid using `git push --force` unless you intentionally want to overwrite remote history.

---

# 🔄 Deployment Workflow

The expected workflow is:

```text
Code Change
    │
    ▼
Git Commit
    │
    ▼
Git Push
    │
    ▼
CI/CD Pipeline
    │
    ▼
Docker Image
    │
    ▼
Container Registry
    │
    ▼
Kubernetes
    │
    ▼
Argo CD
    │
    ▼
Application Deployment
```

Whenever application or deployment configuration changes, the relevant Git repository should be updated.

Argo CD can then detect the desired state and synchronize the Kubernetes resources according to the configured application.

---

# 🔍 Monitoring Kubernetes

List all resources:

```bash
kubectl get all -n jerney
```

Watch pods:

```bash
kubectl get pods -n jerney -w
```

Describe a pod:

```bash
kubectl describe pod <pod-name> -n jerney
```

View pod logs:

```bash
kubectl logs <pod-name> -n jerney
```

Follow logs:

```bash
kubectl logs -f <pod-name> -n jerney
```

---

# 🛠️ Troubleshooting

## Argo CD pods are not running

Check:

```bash
kubectl get pods -n argocd
```

Check events:

```bash
kubectl get events -n argocd --sort-by=.metadata.creationTimestamp
```

Describe the problematic pod:

```bash
kubectl describe pod <pod-name> -n argocd
```

---

## Argo CD dashboard is not opening

Check the service:

```bash
kubectl get svc -n argocd
```

Start port forwarding again:

```bash
kubectl port-forward svc/argocd-server -n argocd 8081:443
```

Then open:

```text
https://localhost:8081
```

---

## Kubernetes pods are failing

Check:

```bash
kubectl get pods -n jerney
```

Then:

```bash
kubectl describe pod <pod-name> -n jerney
```

Check logs:

```bash
kubectl logs <pod-name> -n jerney
```

---

## Deployment is not updating

Check:

```bash
kubectl get deployments -n jerney
```

Check pods:

```bash
kubectl get pods -n jerney
```

Check the Argo CD application status from the dashboard.

Verify that the Git repository contains the latest Kubernetes configuration.

---

# 🔐 Security Notes

Never commit passwords, API keys, database credentials, private keys, or other secrets to Git.

Use:

```text
.env
```

for local environment variables and keep it out of Git.

Check before committing:

```bash
git status
```

If sensitive information was accidentally committed, remove it from Git history and rotate the exposed credentials.

For Kubernetes deployments, use Kubernetes Secrets or an appropriate external secret-management solution rather than storing sensitive values directly in manifests.

---

# 🔧 Useful Commands

## Git

```bash
git status
git branch
git log --oneline
git pull --rebase origin main
git add .
git commit -m "message"
git push origin main
```

## Docker

```bash
docker ps
docker ps -a
docker images
docker logs <container>
docker stop <container>
docker start <container>
docker rm <container>
```

## Kubernetes

```bash
kubectl get nodes
kubectl get namespaces
kubectl get pods -A
kubectl get all -n jerney
kubectl get svc -n jerney
kubectl get deployments -n jerney
kubectl describe pod <pod-name> -n jerney
kubectl logs <pod-name> -n jerney
```

## Argo CD

```bash
kubectl get pods -n argocd
kubectl get svc -n argocd
kubectl get applications -n argocd
kubectl port-forward svc/argocd-server -n argocd 8081:443
```

---

# 🔁 Quick Restart Checklist

After restarting the server, run:

### 1. Check Kubernetes

```bash
kubectl get nodes
```

### 2. Check Argo CD

```bash
kubectl get pods -n argocd
```

### 3. Check application

```bash
kubectl get all -n jerney
```

### 4. Start Argo CD dashboard

```bash
kubectl port-forward svc/argocd-server -n argocd 8081:443
```

### 5. Open dashboard

```text
https://localhost:8081
```

Login using:

```text
Username: admin
Password: <password printed by setup script>
```

---

# 📈 Future Improvements

Potential future improvements for the project include:

- Automated CI/CD pipeline.
- Automated Docker image versioning.
- Kubernetes security scanning.
- SonarQube integration.
- Container image vulnerability scanning.
- Infrastructure as Code using Terraform.
- Monitoring using Prometheus and Grafana.
- Centralized logging.
- Automated TLS/HTTPS configuration.
- External secret management.
- Production-grade Kubernetes ingress.
- Automated rollback strategies.
- High-availability deployment.

---

# 👨‍💻 Author

**Adnan Shaikh**

DevOps Engineer | AWS | Docker | Kubernetes | CI/CD | GitOps

GitHub:

```text
https://github.com/adnan-shaikh09
```

---

# ⭐ Project Purpose

This project is created as a practical DevOps/DevSecOps implementation demonstrating how a modern application can be containerized, deployed to Kubernetes, and managed using GitOps principles with Argo CD.

The README is intended to serve as both:

- 📚 Project documentation
- 🛠️ Installation and setup guide
- 🔧 Troubleshooting reference
- 🔄 Future maintenance reference

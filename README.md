# 🚀 GitOps CI/CD with Jenkins and ArgoCD

This project demonstrates a complete GitOps workflow using **Jenkins** for continuous integration and **ArgoCD** for continuous deployment on a Kubernetes cluster (Minikube).

## 📸 Screenshots

### ✅ Jenkins CI Pipeline
![Jenkins CI](screenshots/jenkins.png)

### ✅ ArgoCD Dashboard
![ArgoCD UI](screenshots/argocd.png)

### ✅ Deployed Application UI
![App UI](screenshots/app.png)

---

## 📦 Tech Stack

- **Jenkins** – CI tool to build & push Docker images  
- **Docker** – Containerize the application  
- **Kubernetes (Minikube)** – Deploy and run the app  
- **ArgoCD** – GitOps deployment from GitHub repo  
- **GitHub** – Source of truth for manifests

## 📁 Project Structure

```
```
GitOps-ci-cd-with-Jenkins-and-Argocd/
├── argocd/
│   └── app.yaml
├── kubernetes/
│   └── deploy.yaml
├── public/
│   ├── images/
│   ├── index.html
│   └── styles.css
├── src/
│   ├── app.js
│   └── imageDisplay.js
├── tests/
│   ├── imageDisplay.test.js
│   ├── package.json
│   └── package-lock.json
├── Dockerfile
├── Jenkinsfile
├── README.md
├── package.json
└── package-lock.json
```

## ✅ Jenkins Pipeline Steps

1. Checkout source code  
2. Build Docker image  
3. Push to Docker Hub (`shadyemad/gitops-app`)  
4. Update K8s manifests if needed

## 🚀 ArgoCD Sync

- Syncs from the GitHub repo  
- Automatically deploys the app on commit  
- Path: `kubernetes/`, Target: `main`

## 🌍 Accessing the App

- Service exposed via **NodePort** (e.g., `http://<minikube-ip>:30080`)  
- Container listens on port `3000`

## 🔐 Access ArgoCD UI

```bash
kubectl -n argocd get svc argocd-server
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Visit: `https://<node-ip>:<node-port>`  
Login: `admin` / <decoded password>

---

Made by [**Shady Emad**](https://github.com/shadyemad2)


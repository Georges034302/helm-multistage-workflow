## 🧑‍💼 Employee App on AKS with Helm

This project demonstrates how to deploy a **full-stack employee directory** consisting of a **React frontend** and a **Node.js backend API** to **Azure Kubernetes Service (AKS)** using a **Helm chart**.

---

### 📁 Project Structure

```
employee-app-helm/
├── employee-app/
│   ├── Chart.yaml
│   ├── values.yaml
│   ├── values-dev.yaml
│   ├── values-staging.yaml
│   ├── values-prod.yaml
│   └── templates/
│       ├── backend-deployment.yaml
│       ├── backend-service.yaml
│       ├── frontend-deployment.yaml
│       └── frontend-service.yaml
├── frontend/
│   ├── Dockerfile
│   ├── package.json
│   └── src/
│       └── App.js
├── backend/
│   ├── Dockerfile
│   ├── package.json
│   └── server.js
├── .github/
│   └── workflows/
│       └── deploy.yml
├── setup.sh
├── deploy.sh
├── secure-secrets.sh
└── README.md
```

---

### 🧰 Stack Overview

- **Frontend**: React (served via NGINX)
- **Backend**: Node.js (Express API)
- **API Route**: `/api/employees`
- **Deployment**: Helm chart for AKS

---

### 👩‍💻 How It Works

- React frontend is built and served with NGINX.
- It fetches employee data from the backend API using:
  ```js
  fetch(process.env.REACT_APP_API_URL)
  ```
- Kubernetes services expose the backend to the frontend via internal DNS (`http://employee-backend:5000`).
- The frontend is exposed publicly using a LoadBalancer service.

---

### ✅ Prerequisites

- Azure CLI (`az`)
- Helm 3 (`helm`)
- kubectl (`kubectl`)
- Docker (for building images)
- An existing AKS cluster

---

### 🚀 Deployment Steps

1. **Build and Push Images**
   Replace image repos in values files with your container registry:

   ```bash
   docker build -t ghcr.io/myorg/employee-api ./backend
   docker build -t ghcr.io/myorg/employee-ui ./frontend

   docker push ghcr.io/myorg/employee-api
   docker push ghcr.io/myorg/employee-ui
   ```

2. **Run Setup Script (Creates AKS and Configures kubectl)**
   ```bash
   ./setup.sh
   ```

3. **Deploy to an Environment**
   You can deploy to one of the three environments: `dev`, `staging`, or `prod`.

   ```bash
   ./deploy.sh dev
   ./deploy.sh staging
   ./deploy.sh prod
   ```

   This script:
   - Uses `values-<env>.yaml`
   - Automatically creates the namespace
   - Deploys using a Helm release named `employee-app-<env>`

4. **Get the External IP**
   ```bash
   kubectl get svc -n <env>
   ```

5. **Open the App**
   ```
   http://<EXTERNAL-IP>
   ```

---

### 🔁 API Response Format

```json
[
  { "name": "Alice", "role": "Developer", "department": "Engineering" },
  { "name": "Bob", "role": "Manager", "department": "HR" },
  { "name": "Charlie", "role": "Analyst", "department": "Finance" }
]
```

---

### 🧹 Cleanup

To uninstall from a specific environment:

```bash
helm uninstall employee-app-dev -n dev
helm uninstall employee-app-staging -n staging
helm uninstall employee-app-prod -n prod
```

---

### ✍️ *Author: Georges Bou Ghantous*

*Built to demonstrate multi-stage full-stack deployment using AKS + Helm + GitHub Actions CI/CD 💙*

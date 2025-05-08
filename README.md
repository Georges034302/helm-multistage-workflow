# 🧑‍💼 Employee App on AKS with Helm

This project demonstrates how to deploy a **full-stack employee directory** consisting of a **React frontend** and a **Node.js backend API** to **Azure Kubernetes Service (AKS)** using a **Helm chart**.

---

## 📁 Project Structure

```
employee-app-helm/
├── employee-app/
│   ├── Chart.yaml
│   ├── values.yaml
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
```

---

## 🧰 Stack Overview

- **Frontend**: React (served via NGINX)
- **Backend**: Node.js (Express API)
- **API Route**: `/api/employees`
- **Deployment**: Helm chart for AKS

---

## 👩‍💻 How It Works

- React frontend is built and served with NGINX.
- It fetches employee data from the backend API using:
  ```js
  fetch(process.env.REACT_APP_API_URL)
  ```
- Kubernetes services expose the backend to the frontend via internal DNS (`http://employee-backend:5000`).
- The frontend is exposed publicly using a LoadBalancer service.

---

## ✅ Prerequisites

- Azure CLI (`az`)
- Helm 3 (`helm`)
- kubectl (`kubectl`)
- Docker (for building images)
- An existing AKS cluster

---

## 🚀 Deployment Steps

1. **Build and Push Images**
   > Replace image repos in `values.yaml` with your container registry (e.g., ACR, DockerHub)

   ```bash
   docker build -t ghcr.io/myorg/employee-api ./backend
   docker build -t ghcr.io/myorg/employee-ui ./frontend

   docker push ghcr.io/myorg/employee-api
   docker push ghcr.io/myorg/employee-ui
   ```

2. **Update `values.yaml`**
   ```yaml
   frontend.image.repository: ghcr.io/myorg/employee-ui
   backend.image.repository: ghcr.io/myorg/employee-api
   ```

3. **Connect to AKS**
   ```bash
   az login
   az aks get-credentials --resource-group <resource-group> --name <cluster-name>
   ```

4. **Deploy via Helm**
   ```bash
   helm install employee-app ./employee-app
   ```

5. **Get the External IP**
   ```bash
   kubectl get svc employee-frontend
   ```

6. **Open the App**
   ```
   http://<EXTERNAL-IP>
   ```

---

## 🔁 API Response Format

```json
[
  { "name": "Alice", "role": "Developer", "department": "Engineering" },
  { "name": "Bob", "role": "Manager", "department": "HR" },
  { "name": "Charlie", "role": "Analyst", "department": "Finance" }
]
```

---

## 🧹 Cleanup

```bash
helm uninstall employee-app
```

---

## 🧠 Author

Built with ❤️ to demonstrate full-stack deployment using AKS + Helm.

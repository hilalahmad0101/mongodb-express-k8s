```markdown
# MongoDB + Mongo Express on Kubernetes

This project demonstrates how to deploy **MongoDB** with **Mongo Express** on a Kubernetes cluster using YAML manifests.

---

## 🗂️ Structure

All manifests are placed in a single folder:

├── mongo-express-deployment.yml
├── mongo-express-service.yml
├── mongodb-deployment.yml
├── mongodb-pv.yml
├── mongodb-pvc.yml
├── mongodb-service.yml
└── namespace.yml


---

## 📦 Components

- **MongoDB Deployment**
- **Mongo Express Deployment**
- **Persistent Volume (PV)**
- **Persistent Volume Claim (PVC)**
- **MongoDB Headless Service**
- **Mongo Express Service**
- **Namespace** to isolate the resources

---

## ⚙️ Prerequisites

- Kubernetes cluster (minikube, k3s, or cloud-based)
- `kubectl` configured
- (Optional) Helm installed

---

## 🚀 Deployment Instructions

1. **Create Namespace**
   ```bash
   kubectl apply -f cmd/namespace.yml

2. **Apply MongoDB Resources**
   ```bash
   kubectl apply -f cmd/mongodb-pv.yml
   kubectl apply -f cmd/mongodb-pvc.yml
   kubectl apply -f cmd/mongodb-deployment.yml
   kubectl apply -f cmd/mongodb-service.yml

3. **Apply Mongo Express Resources**
   ```bash
   kubectl apply -f cmd/mongo-express-deployment.yml
   kubectl apply -f cmd/mongo-express-service.yml

4. **Access Mongo Express**
   Port-forward to access Mongo Express dashboard:
   ```bash
   kubectl port-forward svc/mongo-express-service 8081:8081 -n mongodb-ui
   Then visit: http://localhost:8081

---

## 💾 Persistent Storage

MongoDB data is persisted using:
- `mongodb-pv.yml` → Defines the volume.
- `mongodb-pvc.yml` → Claims the volume.

**So even if the MongoDB pod is deleted**, the data is safe and restored once the pod restarts.

---

## 🧽 Cleanup

To remove everything:
```bash
kubectl delete -f cmd/ --recursive

---

## 📘 Reference

GitHub: [mongodb-express-k8s](https://github.com/hilalahmad0101/mongodb-express-k8s)

---
```

# 🚀 MongoDB + Mongo Express on Kubernetes

<div align="center">

![MongoDB](https://img.shields.io/badge/MongoDB-4EA94B?style=for-the-badge&logo=mongodb&logoColor=white)
![Kubernetes](https://img.shields.io/badge/kubernetes-326ce5.svg?&style=for-the-badge&logo=kubernetes&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)

**A production-ready MongoDB deployment with Mongo Express web interface on Kubernetes**

[📚 Documentation](#-documentation) • [🎯 Features](#-features) • [⚡ Quick Start](#-quick-start) • [🛠️ Configuration](#️-configuration)

</div>

---

## 🎯 Features

- ✅ **Production-ready MongoDB** with persistent storage
- 🖥️ **Mongo Express web interface** for database management
- 📦 **Kubernetes native** deployment using YAML manifests
- 💾 **Persistent storage** with PV/PVC for data safety
- 🔒 **Namespace isolation** for better resource management
- 🚀 **Easy deployment** with simple kubectl commands
- 🧹 **One-command cleanup** for environment teardown

---

## 📁 Project Structure

```
mongodb-k8s/
├── cmd/
│   ├── namespace.yml              # Namespace definition
│   ├── mongodb-pv.yml             # Persistent Volume
│   ├── mongodb-pvc.yml            # Persistent Volume Claim
│   ├── mongodb-deployment.yml     # MongoDB deployment
│   ├── mongodb-service.yml        # MongoDB service
│   ├── mongo-express-deployment.yml # Mongo Express deployment
│   └── mongo-express-service.yml  # Mongo Express service
└── README.md
```

---

## 🛠️ Prerequisites

Before you begin, ensure you have the following installed:

| Tool | Version | Purpose |
|------|---------|---------|
| **Kubernetes** | v1.20+ | Container orchestration platform |
| **kubectl** | Latest | Kubernetes command-line tool |
| **Docker** | v20.10+ | Container runtime (if using local cluster) |

### Supported Kubernetes Platforms:
- 🐳 **Docker Desktop** with Kubernetes
- ☸️ **minikube** for local development
- 🔧 **k3s** for lightweight deployment
- ☁️ **Cloud providers** (EKS, GKE, AKS)

---

## ⚡ Quick Start

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/hilalahmad0101/mongodb-express-k8s.git
cd mongodb-express-k8s
```

### 2️⃣ Deploy the Stack
```bash
# Create namespace and deploy all resources
kubectl apply -f cmd/

# Or deploy step by step:
kubectl apply -f cmd/namespace.yml
kubectl apply -f cmd/mongodb-pv.yml
kubectl apply -f cmd/mongodb-pvc.yml
kubectl apply -f cmd/mongodb-deployment.yml
kubectl apply -f cmd/mongodb-service.yml
kubectl apply -f cmd/mongo-express-deployment.yml
kubectl apply -f cmd/mongo-express-service.yml
```

### 3️⃣ Verify Deployment
```bash
# Check all resources
kubectl get all -n mongodb-ui

# Check pod status
kubectl get pods -n mongodb-ui

# Check persistent volumes
kubectl get pv,pvc -n mongodb-ui
```

### 4️⃣ Access Mongo Express
```bash
# Port forward to access the web interface
kubectl port-forward svc/mongo-express-service 8081:8081 -n mongodb-ui
```

🌐 **Open your browser and navigate to:** [http://localhost:8081](http://localhost:8081)

---

## 🔧 Configuration

### MongoDB Configuration
| Environment Variable | Default Value | Description |
|----------------------|---------------|-------------|
| `MONGO_INITDB_ROOT_USERNAME` | `admin` | MongoDB root username |
| `MONGO_INITDB_ROOT_PASSWORD` | `password` | MongoDB root password |

### Mongo Express Configuration
| Environment Variable | Default Value | Description |
|----------------------|---------------|-------------|
| `ME_CONFIG_MONGODB_ADMINUSERNAME` | `admin` | MongoDB admin username |
| `ME_CONFIG_MONGODB_ADMINPASSWORD` | `password` | MongoDB admin password |
| `ME_CONFIG_MONGODB_SERVER` | `mongodb-service` | MongoDB service name |

### Storage Configuration
- **Volume Size:** 5Gi (configurable in `mongodb-pvc.yml`)
- **Storage Class:** Default (modify in `mongodb-pv.yml` if needed)
- **Access Mode:** ReadWriteOnce

---

## 📊 Monitoring & Troubleshooting

### Check Deployment Status
```bash
# View deployment status
kubectl rollout status deployment/mongodb-deployment -n mongodb-ui
kubectl rollout status deployment/mongo-express-deployment -n mongodb-ui

# View logs
kubectl logs -f deployment/mongodb-deployment -n mongodb-ui
kubectl logs -f deployment/mongo-express-deployment -n mongodb-ui
```

### Common Issues
| Issue | Solution |
|-------|----------|
| **Pod stuck in Pending** | Check if PVC is bound: `kubectl get pvc -n mongodb-ui` |
| **Connection refused** | Verify service endpoints: `kubectl get endpoints -n mongodb-ui` |
| **Data not persisting** | Check PV/PVC status: `kubectl describe pv mongodb-pv` |

---

## 🔄 Scaling & Updates

### Scale MongoDB (if using replica set)
```bash
kubectl scale deployment mongodb-deployment --replicas=3 -n mongodb-ui
```

### Update Images
```bash
# Update MongoDB image
kubectl set image deployment/mongodb-deployment mongodb=mongo:latest -n mongodb-ui

# Update Mongo Express image
kubectl set image deployment/mongo-express-deployment mongo-express=mongo-express:latest -n mongodb-ui
```

---

## 🔐 Security Considerations

⚠️ **Important Security Notes:**
- Change default passwords in production
- Use Kubernetes secrets for sensitive data
- Enable authentication and authorization
- Consider network policies for traffic isolation
- Regular security updates for container images

### Using Kubernetes Secrets
```bash
# Create secret for MongoDB credentials
kubectl create secret generic mongodb-secret \
  --from-literal=username=admin \
  --from-literal=password=your-secure-password \
  -n mongodb-ui
```

---

## 🧹 Cleanup

### Remove All Resources
```bash
# Delete all resources at once
kubectl delete -f cmd/ --recursive

# Or delete namespace (removes everything)
kubectl delete namespace mongodb-ui
```

### Remove Persistent Data
```bash
# Remove persistent volume (⚠️ This will delete all data)
kubectl delete pv mongodb-pv
```

---

## 📈 Production Considerations

### For Production Deployment:
- [ ] Use **StatefulSets** instead of Deployments for MongoDB
- [ ] Implement **MongoDB replica sets** for high availability
- [ ] Configure **resource limits** and requests
- [ ] Set up **monitoring** with Prometheus/Grafana
- [ ] Implement **backup strategies**
- [ ] Use **Helm charts** for easier management
- [ ] Configure **network policies** for security

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🔗 Links & Resources

- 📚 [MongoDB Documentation](https://docs.mongodb.com/)
- 🖥️ [Mongo Express GitHub](https://github.com/mongo-express/mongo-express)
- ☸️ [Kubernetes Documentation](https://kubernetes.io/docs/)
- 🐳 [Docker Hub - MongoDB](https://hub.docker.com/_/mongo)

---

<div align="center">

**⭐ If this project helped you, please give it a star! ⭐**

Made with ❤️ by [hilalahmad0101](https://github.com/hilalahmad0101)

</div>

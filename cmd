kubectl exec -it podname -n mongodb-ui -- bash
kubectl port-forward -n mongodb-ui svc/mongodb-express-service 8080:8080 --address=0.0.0.0
kubectl port-forward -n mongodb-ui svc/mongodb-express-service 8081:8082 --address=0.0.0.0
mongosh -u mongoadmin -p secret --authenticationDatabase admin

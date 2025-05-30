#!/bin/bash

echo "🚀 Desplegando microservicios y base de datos en Kubernetes..."

kubectl apply -f ../k8s/postgres/pv.yaml
kubectl apply -f ../k8s/postgres/pvc.yaml
kubectl apply -f ../k8s/postgres/deployment.yaml
kubectl apply -f ../k8s/postgres/service.yaml

kubectl apply -f ../k8s/create/
kubectl apply -f ../k8s/read/
kubectl apply -f ../k8s/update/
kubectl apply -f ../k8s/delete/

echo "✅ Despliegue completado."

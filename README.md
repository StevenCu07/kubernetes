# Proyecto de Microservicios en Kubernetes con PostgreSQL

Este proyecto implementa cuatro microservicios (`create`, `read`, `update`, `delete`) desarrollados con Spring Boot, empaquetados con Docker, y desplegados en Kubernetes junto a una base de datos PostgreSQL con almacenamiento persistente.

## Requisitos Previos

- Docker
- Minikube o KIND (Kubernetes local)
- kubectl
- Docker Hub (cuenta e inicio de sesión)

## Estructura del Proyecto

```
/apiv1
├── create/
├── read/
├── update/
├── delete/
├── k8s/
│   ├── create/
│   ├── read/
│   ├── update/
│   ├── delete/
│   └── postgres/
└── README.md
```

## Paso a Paso para Ejecutar el Proyecto en otro PC

### 1. Clona el repositorio
```bash
git clone https://github.com/StevenCu07/kubernetes.git
cd apiv1
```

### 2. Inicia sesión en Docker Hub
```bash
docker login
```

### 3. Construye y sube las imágenes de los microservicios
Reemplaza `TU_USUARIO_DOCKER_HUB` por tu nombre de usuario real de Docker Hub:

```bash
docker build -t TU_USUARIO_DOCKER_HUB/create-ms ./create
docker build -t TU_USUARIO_DOCKER_HUB/read-ms ./read
docker build -t TU_USUARIO_DOCKER_HUB/update-ms ./update
docker build -t TU_USUARIO_DOCKER_HUB/delete-ms ./delete

docker push TU_USUARIO_DOCKER_HUB/create-ms
docker push TU_USUARIO_DOCKER_HUB/read-ms
docker push TU_USUARIO_DOCKER_HUB/update-ms
docker push TU_USUARIO_DOCKER_HUB/delete-ms
```
> Nota: Asegúrate de que los `Dockerfile` estén correctamente definidos en cada carpeta del microservicio.

### 4. Actualiza los deployments
En cada manifiesto de deployment (`k8s/<servicio>/deployment.yaml`), reemplaza la línea:
```yaml
image: stevencu/<servicio>-ms:latest
```
por:
```yaml
image: TU_USUARIO_DOCKER_HUB/<servicio>-ms:latest
```

### 5. Despliega PostgreSQL
```bash
kubectl apply -f k8s/postgres/pv.yaml
kubectl apply -f k8s/postgres/pvc.yaml
kubectl apply -f k8s/postgres/deployment.yaml
kubectl apply -f k8s/postgres/service.yaml
```

### 6. Despliega los microservicios
```bash
kubectl apply -f k8s/create/
kubectl apply -f k8s/read/
kubectl apply -f k8s/update/
kubectl apply -f k8s/delete/
```

### 7. Verifica el estado de los pods y servicios
```bash
kubectl get pods
kubectl get svc
```

### 8. Prueba los endpoints
Abre Postman o el navegador y prueba las URLs:
- `http://localhost:30001/api/usuario/create` → create-ms
- `http://localhost:30002/api/usuario/list` → read-ms
- `http://localhost:30003/api/usuario/update/{id}` → update-ms
- `http://localhost:30004/api/usuario/delete/{id}` → delete-ms

## Consideraciones
- Los servicios usan tipo `NodePort` para facilitar el acceso local sin Ingress.
- Asegúrate de que la imagen en cada deployment apunte al nombre correcto.
- PostgreSQL usa almacenamiento persistente con `PersistentVolume` y `PersistentVolumeClaim`.

## Reinicio del Proyecto
Si apagas el PC o el clúster:
```bash
kubectl delete all --all
kubectl apply -f k8s/postgres/
kubectl apply -f k8s/create/
kubectl apply -f k8s/read/
kubectl apply -f k8s/update/
kubectl apply -f k8s/delete/
```


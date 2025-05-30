#!/bin/bash

echo "🧪 Iniciando evaluación del proyecto..."

# 1. Validar que los pods estén en Running
echo "🔍 Verificando pods..."
pods=(create-ms read-ms update-ms delete-ms postgres)
for pod in "${pods[@]}"; do
    status=$(kubectl get pods -l app=${pod} -o jsonpath="{.items[0].status.phase}")
    if [ "$status" == "Running" ]; then
        echo "✅ $pod en estado Running"
    else
        echo "❌ $pod no está en estado Running (Estado actual: $status)"
    fi
done

# 2. Validar que los servicios estén definidos
echo -e "\n🔍 Verificando servicios..."
for svc in "${pods[@]}"; do
    if kubectl get svc "$svc" &>/dev/null; then
        echo "✅ Servicio $svc existe"
    else
        echo "❌ Servicio $svc no encontrado"
    fi
done

# 3. Verificar endpoints HTTP reales
echo -e "\n📡 Probando operaciones HTTP reales..."
JSON_BODY='{"id":1,"nombre":"Test","apellido":"Usuario","correo":"test@correo.com"}'

# POST - Crear
resp=$(curl -s -o /dev/null -w "%{http_code}" -X POST http://localhost:30001/api/usuario/save \
  -H "Content-Type: application/json" \
  -d "$JSON_BODY")
if [[ $resp == 2* ]]; then
    echo "📤 POST (crear) ... ✅ Código $resp"
else
    echo "📤 POST (crear) ... ❌ Código $resp"
fi

# GET - Listar
resp=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:30002/api/usuario/list)
if [[ $resp == 2* ]]; then
    echo "📥 GET (listar) ... ✅ Código $resp"
else
    echo "📥 GET (listar) ... ❌ Código $resp"
fi

# PUT - Actualizar
resp=$(curl -s -o /dev/null -w "%{http_code}" -X PUT http://localhost:30003/api/usuario/update \
  -H "Content-Type: application/json" \
  -d "$JSON_BODY")
if [[ $resp == 2* ]]; then
    echo "✏️ PUT (actualizar) ... ✅ Código $resp"
else
    echo "✏️ PUT (actualizar) ... ❌ Código $resp"
fi

# DELETE - Eliminar
resp=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE http://localhost:30004/api/usuario/delete/1)
if [[ $resp == 2* ]]; then
    echo "🗑️ DELETE (eliminar) ... ✅ Código $resp"
else
    echo "🗑️ DELETE (eliminar) ... ❌ Código $resp"
fi

# 4. Verificar CronJob de respaldo
echo -e "\n📆 Verificando cronjob de respaldo..."
if kubectl get cronjob backup-postgres &>/dev/null; then
    echo "✅ CronJob backup-postgres existe"
else
    echo "❌ CronJob backup-postgres no encontrado"
fi

# 5. Verificar archivo de respaldo desde logs
echo -e "\n💾 Verificando archivo de respaldo en logs del job..."
kubectl get pods -l job-name=backup-postgres --no-headers 2>/dev/null | awk '{print $1}' | while read pod; do
    if kubectl logs "$pod" | grep -q ".sql"; then
        echo "✅ Archivo .sql generado en logs del respaldo"
    else
        echo "❌ No se encontró salida indicando .sql generado"
    fi
done

# 6. Verificar existencia local de backup
echo -e "\n📂 Buscando archivos .sql locales..."
if ls ./scripts/backups/*.sql &>/dev/null; then
    echo "✅ Archivo de respaldo local encontrado"
else
    echo "❌ No se encontró archivo de respaldo local"
fi

echo -e "\n✅ Evaluación finalizada"

#!/bin/bash

DATE=$(date +%Y-%m-%d-%H-%M-%S)
BACKUP_DIR="./backups"
FILENAME="$BACKUP_DIR/postgres-backup-$DATE.sql"

mkdir -p $BACKUP_DIR

kubectl exec -i deploy/postgres -- \
  pg_dump -U postgres -d postgresdb > $FILENAME

if [ $? -eq 0 ]; then
  echo "✅ Backup guardado en: $FILENAME"
else
  echo "❌ Error al realizar el backup."
fi

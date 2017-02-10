#! /bin/bash

cd "$(dirname "$0")"

BACKUP_DIR="/var/backups/kimai"

mkdir -p "${BACKUP_DIR}"
rm -rfv "${BACKUP_DIR}"/*

TIMESTAMP=$(date +"%Y-%m-%d-%H:%M:%S")
FILE="${BACKUP_DIR}/kimai-dump_${TIMESTAMP}.sql"

echo "Dumping to ${FILE}"

docker-compose exec -T db sh -c 'exec mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" $MYSQL_DATABASE' > "${FILE}"

#!/bin/bash

source .env

NEWEST_DUMP=$(find ${BACKUP_DIR} -type f -exec stat -c '%X %n' {} \; -name "*.sql" | sort
    -nr | awk 'NR==1 {print $2}')


# Stop Keycloak Container
docker stop ${KEYCLOAK_CONTAINER}

# Drop current Database
docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_DATABASE}

# Create new Database
docker exec -it ${DB_CONTAINER} createdb -U ${DB_USER} -O ${DB_USER} ${DB_DATABASE}

# Import Dump
docker exec -it ${DB_CONTAINER} sh -c "psql -U ${DB_USER} ${DB_DATABASE} < ${NEWEST_DUMP}"

# Start Keycloak Container
docker start ${KEYCLOAK_CONTAINER}

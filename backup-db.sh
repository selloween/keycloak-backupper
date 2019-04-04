source .env
docker exec -it ${DB_CONTAINER} pg_dump -U ${DB_USER} ${DB_DATABASE} > ${BACKUP_DIR}_keycloak_`date +%d-%m-%Y"_"%H_%M_%S`.sql


#!/bin/bash
#
# Backup a Postgresql database into a daily file.
#
# add the following line in pg_hba.conf
# local XXXXX  XXXX  trust
#
wait_for_dependency_service(){
  echo "[INFO]: Checking PostgreSQL Port";
  while ! nc -z postgres 5432; do sleep 3; done
  echo "[INFO]: PostgreSQL Port Available";
}
sleep 10s
BACKUP_DIR=/mnt/PSQL_BACKUP
DAYS_TO_KEEP=3
FILE_SUFFIX=_Project-Name_backup.sql
DATABASE=Project-Name
USER=XXXX
FILE=`date +"%Y%m%d%H%M"`${FILE_SUFFIX}
OUTPUT_FILE=${BACKUP_DIR}/${FILE}
if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p $BACKUP_DIR
fi
# do the database backup (dump)
# use this command for a database server on localhost. add other options if need be.
wait_for_dependency_service
pg_dump -h postgres -U ${USER} ${DATABASE} -F p -f ${OUTPUT_FILE}
# gzip the mysql database dump file
gzip $OUTPUT_FILE
echo "${OUTPUT_FILE}.gz was created:`date`" >>$BACKUP_DIR/backup.log
echo "${OUTPUT_FILE}.gz was created:`date`"
# prune old backups
find $BACKUP_DIR -maxdepth 1 -mtime +$DAYS_TO_KEEP -name "*${FILE_SUFFIX}.gz" -exec rm -rf '{}' ';'
/usr/bin/aws s3 sync $BACKUP_DIR s3://Project-Name-postgresql-backup >> $BACKUP_DIR/backup.log
echo "Upload to s3 bucket `date`" >>$BACKUP_DIR/backup.log
echo "Upload to s3 bucket `date`"
sleep 10s

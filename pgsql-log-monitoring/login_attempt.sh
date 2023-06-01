#!/bin/bash

function log_file_search() {
   find /home/gisadmin/networks/kvwmap_prod/services/pgsql/logs/ -type f -mmin -1
}

failed_login_attempted=$(log_file_search)
log_passwort_auth=$(cat $failed_login_attempted | grep "password authentication failed for user"  | wc -l)
log_no_hba=$(cat $failed_login_attempted | grep "no pg_hba.conf entry for host" | wc -l)

function tolog(){
  #currentDate=`date`
  echo "$log_no_hba" > /etc/zabbix/zabbix_conf/pgsql-log-monitoring/pgsql_login_attempts.log
  echo "$log_passwort_auth" > /etc/zabbix/zabbix_conf/pgsql-log-monitoring/pgsql_wrong_pass.log

}

tolog "$log_passwort_auth"
tolog "$log_no_hba"

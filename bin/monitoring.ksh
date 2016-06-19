#!/bin/sh

SHARED_DIRECTORY="/product/shared"
SHARED_SH_LIB="${SHARED_DIRECTORY}/lib/sh"
CONFIG_MONITORING_FILE="${CONFIG_DIR}/fs_monitoring.cfg"
CONFIG_MONITORING_PROCESS="${CONFIG_DIR}/process_monitoring.cfg"

SCRIPT_NAME=$(basename $0)
SCRIPT_NAME=$(basename "${SCRIPT_NAME}" .ksh)

. "${SHARED_SH_LIB}/logging.sh"
. "${SHARED_SH_LIB}/common.sh"
. "${PRODUCT_DIR}/bin/sql_exec.sh"

usage ()
{
	echo "Usage"
}

readConfig ()
{
	logInfo "Lecture du fichier de configuration"

	check_file_exists "${CONFIG_MONITORING_FILE}"
	check_file_exists "${CONFIG_MONITORING_PROCESS}"

	for line in $(cat "${CONFIG_MONITORING_FILE}")
	do
		folder=$(echo $line | cut -d ';' -f1)
		limit=$(echo $line | cut -d';' -f2)

		if [ ! -d "${folder}" ]
		then
			logInfo "The input value ${folder} should be a folder"
			exit 100
		fi
	done
	logInfo  "Read configuration file ${CONFIG_MONITORING_FILE}"
	for line in $(cat "${CONFIG_MONITORING_PROCESS}")
	do
	       process=$(echo $line | cut -d ';' -f1)
	       command=$(echo $line | cut -d ';' -f2)
	       monitoringTask "$process" "$command"
	done

}


monitorFS ()
{
	logInfo "Monitor FS"
}

monitoringTask ()
{
	processName="$1"
	logInfo "Monitoring process ${processName}"
	nbProcess=$(ps -ef | grep "${processName}" | grep -v grep | wc -l)
	if [ "${nbProcess}" -le 0 ]
	then
		logError "The process ${processName} should be up"
	fi

	logInfo "Test database sql : "
	result=$()

}

#
# Init log file
##################################################

initLog "${SCRIPT_NAME}"

#
# Main :
# 	Start monitoring system
##################################################


logInfo "**************** Début du script de supervision ***********************"

#Check configuration
checkEnv

#Start monitoring
readConfig

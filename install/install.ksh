#!/bin/sh


SSA_NAME="monitoring"
PRODUCT_DIR="/product"
SHARED_FOLDER="${PRODUCT_DIR}/shared/lib"

export LOG_DIR="/varsoft/jenkins/logs/monitoring"

#
#	Use KSH lib 
#
##########################################################
. "${SHARED_FOLDER}/sh/common.sh"
. "${SHARED_FOLDER}/sh/logging.sh"


SSA_PRODUCT_DIR="${PRODUCT_DIR}/${SSA_NAME}"
DEV_DIR="/home/mathieu/dev${SSA_PRODUCT_DIR}"

INSTALLATION_TYPE="${1}"

if [ -z "${INSTALLATION_TYPE}" ]
then
	DEST_FOLDER="${DEV_DIR}"
else
	case "${INSTALLATION_TYPE}" in
		'PROD')
			logInfo "Start installation for ${INSTALLATION_TYPE}"
			DEST_FOLDER="${SSA_PRODUCT_DIR}"
			;;
		'DEV')
			logInfo "Start installation for ${INSTALLATION_TYPE}"
			DEST_FOLDER="${DEV_DIR}"
			;;
		*)
			logError "No installation available for parameter ${INSTALLATION_TYPE}"
			exit 5
			;;
	esac

fi

clean_dev()
{
	logInfo "Cleaning dev directory : ${DEV_DIR}"
	rm -rf "${DEV_DIR}"
	returnCode=$?
	if [ "${returnCode}" -ne 0 ]
	then
		logError "Failed to clean Monitoring environnement"
		exit 1
	fi

	mkdir "${DEV_DIR}"
	returnCode=$?
	if [ "${returnCode}" -ne 0 ]
	then
		logError "Failed to create directory ${DEV_DIR}"
		exit 1
	fi

}

backup_previous_version()
{
	if [ -d "${SSA_PRODUCT_DIR}/monitoring" ]
	then
		rm "${SSA_PRODUCT_DIR}/monitoring"
	fi
}

prepare_new_version()
{
	cd "${SSA_PRODUCT_DIR}"
	checkVariable "${VERSION}"
	mkdir "${SSA_PRODUCT_DIR}/Monitoring.${VERSION}"
	ln -s "${SSA_PRODUCT_DIR}/Monitoring.${VERSION}" "monitoring"
}

initLog "monitoring_install"
logInfo "*********** Start installation ********************"
logInfo "Workspace : ${WORKSPACE}"
logInfo "Deploy directory : ${DEV_DIR}"

cd "${WORKSPACE}"
logInfo "Generate package..."
tar -zcvf "monitoring.tar.gz" ./*
returnCode=$?
if [ "${returnCode}" -ne 0 ]
then
	logError "Failed to package Monitoring project"
	exit 1
fi


if [ "${INSTALLATION_TYPE}" = "DEV" ]
then
	clean_dev
else
	backup_previous_version
fi

logInfo "Transfert package to ${DEST_FOLDER}"
mv "${WORKSPACE}/monitoring.tar.gz" "${DEST_FOLDER}"
returnCode=$?
if [ "${returnCode}" -ne 0 ]
then
	logError "Failed to transfert package Monitoring.tar.gz"
	exit 1
fi

if [ "${INSTALLATION_TYPE}" = "${PROD}" ] 
then
	prepare_new_version
fi

logInfo "Extract package to ${DEST_FOLDER}"
cd "${DEST_FOLDER}"
tar -zxvf monitoring.tar.gz
returnCode=$?
if [ "${returnCode}" -ne 0 ]
then
	logError "Failed to deploy package Monitoring.tar.gz"
	exit 1
fi

logInfo "Install GUI to ${DEST_FOLDER}/gui"
cd "${DEST_FOLDER}/gui"
npm install
returnCode=$?
if [ "${returnCode}" -ne 0 ]
then
	logError "Failed to install GUI"
	exit 1
fi

logInfo "Start server"
export BUILD_ID=dontKillMe
nohup npm start &

returnCode=$?
if [ "${returnCode}" -ne 0 ]
then
	logError "Failed to start GUI"
	exit 1
fi

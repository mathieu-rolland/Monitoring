#!/bin/ksh


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

logInfo "Transfert package to ${DEV_DIR}"
mv "${WORKSPACE}/monitoring.tar.gz" "${DEV_DIR}"
returnCode=$?
if [ "${returnCode}" -ne 0 ]
then
	logError "Failed to transfert package Monitoring.tar.gz"
	exit 1
fi

logInfo "Extract package to ${DEV_DIR}"
cd "${DEV_DIR}"
tar -zxvf monitoring.tar.gz
returnCode=$?
if [ "${returnCode}" -ne 0 ]
then
	logError "Failed to deploy package Monitoring.tar.gz"
	exit 1
fi

logInfo "Install GUI to ${DEV_DIR}/gui"
cd "${DEV_DIR}/gui"
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

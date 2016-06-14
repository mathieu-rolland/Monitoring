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
tar -zcvf "monitoring.tar.gz" ./*

cd "${DEV_DIR}"
rm -rf "${DEV_DIR}"
mkdir "${DEV_DIR}"

mv "${WORKSPACE}/monitoring.tar.gz" "${DEV_DIR}"
cd "${DEV_DIR}"
tar -zxvf monitoring.tar.gz

cd "${DEV_DIR}/gui"
npm install

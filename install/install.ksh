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

SSA_PRODUCT_DIR="${PRODUCT}/${SSA_NAME}"
DEV_DIR="/home/mathieu/dev${SSA_PRODUCT_DIR}"

logInit "monitoring_install"

logInfo "Workspace : ${WORKSPACE}"
logInfo "Deploy directory : ${DEV_DIR}"

cd ${WORKSPACE}
cd /product/monitoring/
cd gui/
#npm install

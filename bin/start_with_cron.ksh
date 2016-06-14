#!/bin/ksh

PROJECT_DIR="/product/monitoring"
ENVIRONNMENT_DIR="${PROJECT_DIR}/admin"
BIN_DIR="${PROJECT_DIR}"/bin

. "${ENVIRONNMENT_DIR}/env.cfg"


"${BIN_DIR}/./monitoring.ksh"

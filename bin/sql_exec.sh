#!/bin/sh

execute_sql()
{
	SQL_CMD="${1}"
	checkVariable "${LOGIN_PATH_NAME}"
	checkVariable "${DATABASE_NAME}"

	result=$(mysql --login-path="${LOGIN_PATH_NAME}" -e "${SQL_CMD}" ${DATABASE_NAME} 2> "${LOG_FILE}")
	retCode=$?
	
	if [ "${retCode}" -ne 0 ]
	then
		logError "Failed to execute query ${SQL_CMD} on database ${DATABASE_NAME} due to error ${retCode}"
		exit 1
	fi

	echo $result

}

execute_sql_file()
{
	SQL_SCRIPT="${1}"
	checkVariable "${LOGIN_PATH_NAME}"
	checkVariable "${DATABASE_NAME}"

	result=$(mysql --login-path="${LOGIN_PATH_NAME}" -e "${SQL_CMD}" ${DATABASE_NAME} < ${SQL_SCRIPT} 2> "${LOG_FILE}")
	retCode=$?
	
	if [ "${retCode}" -ne 0 ]
	then
		logError "Failed to execute query ${SQL_CMD} on database ${DATABASE_NAME} due to error ${retCode}"
		exit 1
	fi

	echo $result

}
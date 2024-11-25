#!/bin/bash

module_name="email_service"
main_module="" 		## keep it empty "" if there is no main module 
log_level="INFO" 	## INFO, DEBUG, ERROR

########### DO NOT CHANGE ANY CODE OR TEXT AFTER THIS LINE #########

. ~/.bash_profile

build="${module_name}.jar"

status=`ps -ef | grep $build | grep java`

if [ "${status}" != "" ]  ## Process is currently running
then
  echo "${module_name} already started..."

else  ## No process running
 
  if [ "${main_module}" == "" ]
  then
     build_path="${APP_HOME}/${module_name}_module"
     log_path="${LOG_HOME}/${module_name}_module"
  else
     build_path="${APP_HOME}/${main_module}_module/${module_name}"
     log_path="${LOG_HOME}/${main_module}_module/${module_name}"
  fi

  cd ${build_path}

  ## Starting the process

  echo "Starting ${module_name} module..."
  java -Dlog4j.configurationFile=./log4j2.xml -Dlog.level=${log_level} -Dlog.path=${log_path} -Dmodule.name=${module_name} -Dspring.config.location=file:./application.properties,file:${commonConfigurationFile} -jar $build 1>/dev/null 2>${log_path}/${module_name}.error &

fi

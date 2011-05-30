#!/bin/bash

version="`grep artifactId.*parent ../pom.xml -A1 | grep version | gsed -re 's/.*<version>(.*)<\/version>/\1/'`"
read -p "Version? [$version] " input_version
if [ $input_version ]; then
  version=$input_version
fi
echo "Deploying $version"


while true; do
    read -p "Have you remembered to run mvn clean install? " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "You must answer yes or no";;
    esac
done

server_suffix=".muda.no"
servers=( "node1" "node2" "node3")
artifacts=("../jetty-pkg/target/jetty-pkg-$version.zip")
config_dir="../config"
config_files=("deploy.config" "webapp.properties")
script_files=("deploy.sh" "server_monitor.sh" "startup.sh")

upload_file() {
  local server=$1
  local file=$2
	if [ -f $artifact ]; then
		echo "Uploading $file to $server"
		scp $file roots@$server:/srv/roots/
		if [ "$?" -ne "0" ]; then
			echo "scp $file roots@$server:/srv/roots/ failed! Quitting..."
			exit 127
		fi
	else
	    echo "Couldn't find $file"
	    exit 127
	fi
}

for server in ${servers[@]}
do
  server_host="$server$server_suffix"
	for artifact in ${artifacts[@]}
	do
    upload_file $server_host $artifact
	done
  if [ "$1" != "--noconfig" ]; then
        for script in ${script_files[@]}
        do
    upload_file $server_host $script
        done
	for conf in ${config_files[@]}
	do
    upload_file $server_host "$config_dir/$server/$conf"
	done
  fi
done

for server in ${servers[@]}
do
  server_host="$server$server_suffix"
	echo "Deploying jetty-pkg on $server_host"
	ssh -tt roots@$server_host "cd /srv/roots; nohup ./deploy.sh jetty-pkg $version > /dev/null 2>&1 </dev/null"
	if [ "$?" -ne "0" ]; then
		echo "deploy.sh for jetty-pkg over ssh failed! Quitting..."
		exit 127
	fi
done

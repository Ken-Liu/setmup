#!/bin/bash

RE_VIRTHOSTROOTURL="(([a-zA-Z0-9\._-]+\.[a-zA-Z]{2,6})|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\&%_\./-~-]*)?"

RE_CONTPORT="[1][0-9][2-9][4-9]|[2-9][0-9]{3}|[1-3][0-9]{4}|[4][0-9][0-1][0-5][0-1]"

if [ "$#" = "2"  ]; then
  if  [[ "$1" =~ $RE_VIRTHOSTROOTURL ]];then
       if [[ "$2" =~ $RE_CONTPORT ]];then
       :  
       else
         echo "Invalid arguments"
         echo "[example]: setmup url port"
	 echo "[example] url : wiki.maodou.io or 192.168.1.1"
         echo "[example] port  goes from 1024 to 49151" 
         exit -1
       fi
  fi      
  if [  -f "./mup.json" ]; then
     sed -i '/\"virtual_host\"/s/\:.*/\: \"'"$1"'\"/g' ./mup.json
     sed -i '/\"ROOT_URL\"/s/\:.*/\: \"http\:\/\/'"$1"'\"/g' ./mup.json
     sed -i '/\"meteor_container_port\"/s/\:.*/\: \"'"$2"'\"/g' ./mup.json
  else
     echo "mup.json is not exist"
     exit -1
  fi
else if [ "$#"="1" -a "$1"="--help" ]; then
       echo "[use it like this]: #./setmup url port"
       echo "[example]: setmup maodou.io 8000"
     else  
       echo "[Syntax Error]: You typed the wrong number of arguments to that command."
     fi
fi

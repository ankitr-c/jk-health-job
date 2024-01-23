#!/bin/bash

ip_addr=$1

if [ -z "$ip_addr" ]; then
  echo "IP address not provided"
  exit 1
fi

result=$(gcloud compute instances list --filter="networkInterfaces.accessConfigs.natIP:${ip_addr} OR networkInterfaces.networkIP:${ip_addr}" | awk 'NR==1 {print $1, $NF; exit}')

echo $result

result=$(gcloud compute instances list --filter="networkInterfaces.accessConfigs.natIP:$ip_addr OR networkInterfaces.networkIP:$ip_addr" --format="value(status)")

if [ -z "$result" ]; then
  echo "Status is: DELETED or VM Unavailable"
elif [ "$result" = "RUNNING" ]; then
  echo "Status is: RUNNING"  
elif [ "$result" = "TERMINATED" ]; then
  echo "Status is: STOPPED"
fi
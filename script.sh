ip_addr=$1
result=$(gcloud compute instances list --filter="networkInterfaces.accessConfigs.natIP:${ip_addr} OR networkInterfaces.networkIP:${ip_addr}" | awk 'NR>1 {print $NF}')

if [ -z "$ip" ]
    then
        echo "IP address not Provided"
        exit 1
elif [ $result=="RUNNING" ] 
then
    echo "Status is: RUNNING"
elif [ $result=="TERMINATED" ]
then
    echo "Status is: STOPPED"
else
    echo "Status is: DELETED or VM Unavailabe"
fi

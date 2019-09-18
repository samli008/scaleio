scli --login --username admin --password liyang@008
scli --query_all_sds
read -p "pls input add sds node ip: " sds
read -p "pls input protection domain name: " protection

ssh $sds "rpm -ivh /root/scaleio/EMC-ScaleIO-sds-3.0-200.104.el7.x86_64.rpm"

sleep 5

scli --add_sds --sds_ip $sds --sds_ip_role all --protection_domain_name $protection --sds_name SDS_$sds

scli --query_all_sds

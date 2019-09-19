scli --login --username admin --password liyang@008
scli --query_all_sdc
read -p "pls input sdc ip: " ip
read -p "pls input mdm vip: " vip
ssh $ip rpm -ivh /root/scaleio/sdc.rpm
sleep 5
ssh $ip "/bin/emc/scaleio/drv_cfg --add_mdm --ip $vip"
scli --query_all_sdc
ssh $ip "/bin/emc/scaleio/drv_cfg --query_version"

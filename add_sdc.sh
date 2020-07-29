scli --login --username admin --password liyang@008
scli --query_all_sdc
read -p "pls input sdc ip: " ip
read -p "pls input mdm vip: " vip
ssh $ip rpm -ivh /root/scaleio/sdc.rpm
ssh $ip rpm -ivh /root/scaleio/lia.rpm
ssh $ip "echo mdm $vip >> /etc/emc/scaleio/drv_cfg.txt"
ssh $ip systemctl restart scini
sleep 5
scli --add_sdc --sdc_ip $ip
scli --query_all_sdc

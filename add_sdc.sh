scli --login --username admin --password liyang@008
scli --query_all_sdc
read -p "pls input sdc ip: " ip
read -p "pls input mdm vip: " vip
ssh $ip rpm -ivh /root/scaleio/EMC-ScaleIO-lia-3.0-200.104.el7.x86_64.rpm
ssh $ip rpm -ivh /root/scaleio/EMC-ScaleIO-sdc-3.0-200.104.el7.x86_64.rpm
ssh $ip "echo mdm $vip >> /etc/emc/scaleio/drv_cfg.txt"
ssh $ip systemctl restart scini
sleep 5
scli --add_sdc --sdc_ip $ip
scli --query_all_sdc

read -p "pls input mdm node ip: " mdm
read -p "pls input cluster name: " cluster
read -p "pls input cluster vip: " vip
read -p "pls input vip interface: " int 
read -p "pls input slave node ip: " slave
read -p "pls input tb node ip: " tb
read -p "pls input scaleio software dir[/root/scaleio]: " dir
read -p "pls input protection domain name: " protection
read -p "pls input storage pool name: " pool

scp -r $dir $slave:/root/
scp -r $dir $tb:/root/

ssh $mdm "MDM_ROLE_IS_MANAGER=1 rpm -ivh $dir/EMC-ScaleIO-mdm-3.0-200.104.el7.x86_64.rpm" 
ssh $slave "MDM_ROLE_IS_MANAGER=1 rpm -ivh $dir/EMC-ScaleIO-mdm-3.0-200.104.el7.x86_64.rpm" 
ssh $tb "MDM_ROLE_IS_MANAGER=0 rpm -ivh $dir/EMC-ScaleIO-mdm-3.0-200.104.el7.x86_64.rpm" 

scli --create_mdm_cluster --master_mdm_ip $mdm --cluster_virtual_ip $vip --master_mdm_name $cluster --master_mdm_virtual_ip_interface $int

scli --login --username admin --password admin
scli --set_password
scli --login --username admin --password liyang@008

scli --add_standby_mdm --new_mdm_ip $slave --mdm_role manager --new_mdm_virtual_ip_interface $int
scli --add_standby_mdm --new_mdm_ip $tb --mdm_role tb
scli --switch_cluster_mode --add_slave_mdm_ip $slave --add_tb_ip $tb --cluster_mode 3_node

scli --add_protection_domain --protection_domain_name $protection
scli --add_storage_pool --storage_pool_name $pool --protection_domain_name $protection --media_type HDD
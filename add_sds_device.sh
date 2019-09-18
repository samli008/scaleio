scli --login --username admin --password liyang@008
scli --query_all_sds
read -p "pls input sds ip: " ip
read -p "pls input sds device name[sdb]: " block
read -p "pls input storage pool name: " pool
if [ ! -b "/dev/$block" ];then
echo "sorry /dev/$block not exist !"
exit 1
else
scli --add_sds_device --sds_ip $ip --storage_pool_name $pool --device_path /dev/$block
fi

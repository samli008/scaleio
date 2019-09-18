scli --login --username admin --password liyang@008
scli --query_all_sds

read -p "pls input sds ip: " ip
read -p "pls input storage pool name: " pool

scli --query_sds_device_info --sds_ip $ip --all_devices |grep -i path

read -p "pls input sds device name[sdb]: " block
if [ ! -b "/dev/$block" ];then
echo "sorry /dev/$block not exist !"
exit 1
else
scli --add_sds_device --sds_ip $ip --storage_pool_name $pool --device_path /dev/$block
scli --query_sds_device_info --sds_ip $ip --all_devices |grep -i path
fi

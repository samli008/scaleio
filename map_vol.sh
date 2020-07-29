scli --login --username admin --password liyang@008
read -p "pls input 1 to map or 0 to unmap: " map

if [ $map == 1 ];then
scli --query_all_sdc
scli --query_all_vol |grep -i unmapped
read -p "pls input vol name: " name
read -p "pls input sdc ip: " ip
scli --map_volume_to_sdc --volume_name $name --allow_multi_map --sdc_ip $ip

elif [ $map == 0 ];then
scli --query_all_sdc
scli --query_all_vol |grep -i to
read -p "pls input vol name: " name
scli --query_volume --volume_name $name
read -p "pls input sdc ip: " ip
scli --unmap_volume_from_sdc --volume_name $name --sdc_ip $ip

else
echo "input error!"
exit 1
fi

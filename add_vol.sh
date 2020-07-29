scli --login --username admin --password liyang@008
read -p "pls input 1 to add or 0 to remove: " add

if [ $add == 1 ];then
scli --query_all |grep -i total
read -p "pls input vol name: " vol
read -p "pls input vol size: " size
read -p "pls input pool name: " pool
scli --add_volume --protection_domain_name $pool --storage_pool_name $pool --size_gb $size --volume_name $vol
scli --query_all_vol |grep -i unmapped

elif [ $add == 0 ];then
scli --query_all_vol |grep -i unmapped
read -p "pls input vol name: " vol
scli --remove_volume --volume_name $vol 

else
echo "input error!"
exit 1
fi

#!/bin/bash
scli --login --username admin --password liyang@008
echo "scaleIO storage infomation summary:"
for i in `scli --query_all_sds |awk '{print $10}'`;
do echo "SDS_IP: $i"
scli --query_sds_device_info --sds_ip $i --all_devices |grep Original |awk '{print $3}';
done

scli --query_all |grep -i total

# scsi fence device
echo "pls use ll /dev/disk/by-id confirm stonith disk device"
read -p "pls intput node1 hostname: " pcs1
read -p "pls intput node2 hostname: " pcs2
read -p "pls input stonith disk [sdb]: " sd
read -p "pls input nfs vip [192.168.20.174]: " vip

a=`ls -l /dev/disk/by-id | grep $sd |awk NR==2'{print $9}'`
pcs stonith create scsi-shooter fence_scsi pcmk_host_list="$pcs1 $pcs2" devices=/dev/disk/by-id/$a meta provides=unfencing
pcs property set no-quorum-policy=freeze
pcs stonith show scsi-shooter

pcs resource create vip IPaddr2 ip=$vip cidr_netmask=24 op monitor interval=20s OCF_CHECK_LEVEL=10 on-fail=fence --group group1

# create dlm-clone
pcs resource create dlm ocf:pacemaker:controld op monitor interval=30s on-fail=fence clone interleave=true ordered=true

# create gfs2
mkfs.gfs2 -j 2 -p lock_dlm -t cluster1:gfs1 /dev/scinia

# create fs-clone
pcs resource create fs ocf:heartbeat:Filesystem device="/dev/scinia" directory="/kvm" fstype="gfs2" --clone

# create HA-vm
pcs resource create c7-1 VirtualDomain hypervisor="qemu:///system" config="/kvm/c7-1.xml" migration_transport=ssh --group group1

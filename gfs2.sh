# dual primary drbd 
read -p "pls input drbd device [drbd0]: " drbd
pcs cluster cib drbd_cfg
pcs -f drbd_cfg resource create data ocf:linbit:drbd drbd_resource=$drbd op monitor interval=60s
pcs -f drbd_cfg resource master dataClone data master-max=2 master-node-max=1 clone-max=2 clone-node-max=1 notify=true
pcs -f drbd_cfg resource show
pcs cluster cib-push drbd_cfg

# create dlm-clone
pcs resource create dlm ocf:pacemaker:controld op monitor interval=30s on-fail=fence clone interleave=true ordered=true

# create gfs2
mkfs.gfs2 -j 2 -p lock_dlm -t cluster1:gfs1 /dev/drbd0

# create fs-clone
pcs resource create fs ocf:heartbeat:Filesystem device="/dev/drbd0" directory="/kvm" fstype="gfs2" --clone

# create HA-vm
pcs resource create c7-1 VirtualDomain hypervisor="qemu:///system" config="/kvm/c7-1.xml" migration_transport=ssh --group group1

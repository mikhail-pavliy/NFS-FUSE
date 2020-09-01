sudo su
yum update -y
yum install -y nfs-utils nfs-utils-lib
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap
mkdir /media/nfs_share
 mount -t nfs 192.168.50.10:/nfs_share/ /media/nfs_share/  -o rw,noatime,noauto,x-systemd.automount,noexec,nosuid,proto=udp,vers=3
echo '192.168.50.10:/nfs_share/ /media/nfs_share/ nfs rw,sync,hard,intr,noatime,noauto,x-systemd.automount,noexec,proto=udp,vers=3 0 0' >> /etc/fstab
systemctl restart remote-fs.target
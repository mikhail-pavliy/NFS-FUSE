sudo su
yum update -y
yum -y install nfs-utils nfs-utils-lib
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap
mkdir -p /nfs_share
chmod -R 777 /nfs_share
echo '/nfs_share  192.168.50.11/32(rw,sync,no_root_squash,no_all_squash)' >> /etc/exports
exportfs -a
systemctl restart nfs-server
systemctl restart firewalld
firewall-cmd --permanent --add-port=46666/tcp
firewall-cmd --permanent --add-port=42955/tcp
firewall-cmd --permanent --add-port=111/tcp
firewall-cmd --permanent --add-port=111/udp
firewall-cmd --permanent --add-port=20048/tcp
firewall-cmd --permanent --add-port=54302/tcp
firewall-cmd --permanent --add-port=2049/tcp
firewall-cmd --permanent --add-port=2049/udp
firewall-cmd --permanent --add-port=875/tcp
firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --permanent --zone=public --add-service=rpc-bind
firewall-cmd --permanent --zone=public --add-service=mountd
systemctl restart firewalld

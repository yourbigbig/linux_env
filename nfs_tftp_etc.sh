NFSPATH=/home/nfs
TFTPPATH= /home/tftpboot
# NFS服务器配置

if [ ! -e ${NFSPATH} ];then
sudo mkdir  ${NFSPATH}
fi
sudo chmod 777 ${NFSPATH}
sudo sed -i "/nfs/d" /etc/exports
sudo echo ${NFSPATH} *\(rw,sync,no_root_squash\) >> /etc/exports
sudo /etc/init.d/nfs-kernel-server restart



# tftp服务器配置

if [ ! -e ${TFTPPATH} ];then
sudo mkdir ${TFTPPATH}
fi
sudo chmod 777 ${TFTPPATH}
sudo cp -f tftp /etc/xinetd.d/tftp
sudo cp -f tftpd-hpa /etc/default/tftpd-hpa
sudo service tftpd-hpa restart
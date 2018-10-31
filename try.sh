#!/bin/sh
cd /usr/src
echo "nama apa"
read namakau
echo "ip dia"
read ipdia
echo "alias"
read ipalias
echo 'ifconfig_em0_alias'$ipalias'="inet '$ipdia' netmask 255.255.255.255"' >> /etc/rc.conf
/etc/rc.d/netif restart
D=/jails/participant-$namakau
echo $D
pwd
cpdup /jails/participant01 $D
#mkdir -p $D
#make installworld DESTDIR=$D
#make distribution DESTDIR=$D
mount -t devfs devfs $D/dev
j=/etc/jail.conf
echo $namakau '{' >> $j
echo '    host.hostname = '$namakau'.nFWG112;' >> $j
echo '    ip4.addr = '$ipdia';' >> $j
echo '    path ="/jails/participant-'$namakau'";' >> $j
echo '    mount.devfs;' >> $j
echo '    exec.start = "/bin/sh /etc/rc";' >> $j
echo '    exec.stop = "/bin/sh /etc/rc.shutdown";' >> $j
echo '    allow.raw_sockets=1;' >> $j
echo '}' >> $j
echo 'PermitRootLogin yes' >> $D/etc/ssh/sshd_config
echo 'sshd_enable="YES"' > $D/etc/rc.conf
#chflags schg $D/etc/master.passwd
#chflags schg $D/etc/passwd
service jail restart

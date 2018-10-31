#!/bin/sh
echo "nak setup database ke tak? YES/[no]"
read setupdb
if [ "$setupdb" = "YES" ]
then
	echo "ok setup bermula..."
	STR001=$'CREATE DATABASE rawdb;'
	echo "$STR001" > 00a-createdatabase.sql
	mysql --user=root --password=toor --host=192.168.0.71 < 00a-createdatabase.sql
	STR003=$'CREATE USER "rawuser1"@"%" IDENTIFIED BY "rawuser123";'
	echo "$STR003" > 00b-createuser.sql
	mysql --user=root --password=toor --host=192.168.0.71 rawdb < 00b-createuser.sql
	STR004=$'GRANT ALL ON rawdb TO "rawuser1"@"%" WITH GRANT OPTION;'
	echo "$STR004" > 00c-grantuser.sql
	mysql --user=root --password=toor --host=192.168.0.71 rawdb < 00c-grantuser.sql
	
fi
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
#echo 'PermitRootLogin yes' >> $D/etc/ssh/sshd_config
echo "ssh successfully set enable & PermitRootLogin yes"
#echo 'sshd_enable="YES"' > $D/etc/rc.conf
#chflags schg $D/etc/master.passwd
echo "please manually --> chflags schg /etc/master.passwd & /etc/passwd"
#chflags schg $D/etc/passwd
#service jail restart
service jail start $namakau
All=/jails/all/$namakau
mkdir -p $All
cat $namakau > $All/001-h
H=`cat $All/001-h`
DB=$'rawdb'
STR1=$'CREATE TABLE '$H' (
        id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        firstkey VARCHAR(10) NOT NULL,
        lastkey VARCHAR(32) NOT NULL,
        mypoint INT(1) NOT NULL,
        reg_date TIMESTAMP
);'
echo "$STR1" > $All/002-createtable.sql
mysql --user=rawuser1 --password=rawuser123 $DB < $All/002-createtable.sql
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1 > $All/003-randstring
cp $All/003-randstring $D/etc/nad
cp $All/003-randstring /etc/nad
cp $All/003-randstring $All/nad
echo "First Key"
cat  $All/003-randstring
F=`cat $All/003-randstring`
echo "Second Key"
md5 -q $All/003-randstring
L=`md5 -q $All/003-randstring`


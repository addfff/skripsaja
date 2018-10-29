#!/bin/sh
cd /usr/src
echo "nama apa"
read namakau
echo "ip dia"
read ipdia
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
echo '    host.hostname = '$namakau'.nFWG112;                # Hostname' >> $j
echo '    ip4.addr = '$ipdia';                   # IP address of the jail' >> $j
echo '    path ="/jails/participant-'$namakau'";                         # Path to the jail' >> $j
echo '    mount.devfs;                               # Mount devfs inside the jail' >> $j
echo '    exec.start = "/bin/sh /etc/rc";            # Start command' >> $j
echo '    exec.stop = "/bin/sh /etc/rc.shutdown";    # Stop command' >> $j
echo '    allow.raw_sockets=1;' >> $j
echo '}' >> $j
service jail restart


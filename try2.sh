echo "apa nama"
read namakau
echo "ip dia"
read ipdia
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

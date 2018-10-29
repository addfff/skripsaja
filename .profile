# $FreeBSD: releng/11.2/etc/root/dot.profile 325815 2017-11-14 17:05:34Z trasz $
#
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:~/bin
export PATH
HOME=/root
export HOME
TERM=${TERM:-xterm}
export TERM
PAGER=more
export PAGER

# Query terminal size; useful for serial lines.
if [ -x /usr/bin/resizewin ] ; then /usr/bin/resizewin -z ; fi

# Uncomment to display a random cookie on each login.
# if [ -x /usr/bin/fortune ] ; then /usr/bin/fortune -s ; fi

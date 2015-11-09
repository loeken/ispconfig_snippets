#!/bin/bash
echo "enter your servername: ( aka whats being returned by hostname )":
read hostname

echo "enter your fully qualified hostname: ( aka whats being returned by hostname -f )"
read fqhostname

echo "change password for user ime:"
passwd ime

echo "change password for user root:"
passwd

echo "changing /etc/hostname"
sed -i 's/newweb/$hostname/g' /etc/hostname

echo "changing /etc/hosts"
sed -i 's/newweb.internetz.me/$fqhostname/g' /etc/hosts

echo "changing /etc/hosts"
sed -i 's/newweb/$hostname/g' /etc/hosts   

echo "changing /etc/mailname" 
echo "$fqhostname" > /etc/mailname

echo "changing mysql root password"
mysqlpass=`tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1`
echo mysqladmin -u root -p'changeme$!' password $mysqlpass

echo "changing /usr/local/ispconfig/server/lib/mysql_clientdb.conf"
sed -i 's/changeme$!/$mysqlpass/g' /usr/local/ispconfig/server/lib/mysql_clientdb.conf

echo ###########################################################################
echo mysql root password: $mysqlpass
echo new root password: only you know it
echo new ime password: ony you know it
echo ###########################################################################
echo we recommend you to save this message and add your ime/root password
echo ###########################################################################
echo now login to ispconfig and change the  server
echo ###########################################################################

#!/bin/bash
DESTINATION=$1
PASSWD=$2
# PORT=$3
# clone Odoo directory
git clone --depth=1 https://github.com/vindevil/odoo-14-docker-compose $DESTINATION
rm -rf $DESTINATION/.git
# change odoo admin password
sed -i 's/vindevil/'$PASSWD'/g' $DESTINATION/config/odoo.conf  # Substitute 'vindevil' with the real password
# create mapping folders
mkdir -p $DESTINATION/pgdata
mkdir -p $DESTINATION/web-data
mkdir -p $DESTINATION/addons
mkdir -p $DESTINATION/config
# set permission
sudo chmod -R 777 $DESTINATION
# config
if grep -qF "fs.inotify.max_user_watches" /etc/sysctl.conf; then echo $(grep -F "fs.inotify.max_user_watches" /etc/sysctl.conf); else echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/sysctl.conf; fi
sudo sysctl -p
#sed -i 's/10014/'$PORT'/g' $DESTINATION/docker-compose.yml  # Substitute 10014 with port number input
# run Odoo
sudo docker-compose -f $DESTINATION/docker-compose.yml up -d

echo 'Odoo started @ '$PORT' without binding to host.'

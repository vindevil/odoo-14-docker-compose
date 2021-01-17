#!/bin/bash
DESTINATION=$1
# PORT=$2
# clone Odoo directory
git clone --depth=1 https://github.com/vindevil/odoo-14-docker-compose $DESTINATION
rm -rf $DESTINATION/.git
# set permission
mkdir -p $DESTINATION/pgdata
sudo chmod -R 777 $DESTINATION
# config
if grep -qF "fs.inotify.max_user_watches" /etc/sysctl.conf; then echo $(grep -F "fs.inotify.max_user_watches" /etc/sysctl.conf); else echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/sysctl.conf; fi
sudo sysctl -p
#sed -i 's/10014/'$PORT'/g' $DESTINATION/docker-compose.yml  # Substitute 10014 with port number input
# run Odoo
sudo docker-compose -f $DESTINATION/docker-compose.yml up -d

echo 'Odoo started @ '$PORT' without binding to host.'

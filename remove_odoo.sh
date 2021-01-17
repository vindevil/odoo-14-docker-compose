#!/bin/bash
# completely delete/reset Odoo container & data
docker-compose down
rm -rf pgdata
rm -rf web-data
rm -rf addons
rm -rf config
echo 'Odoo deleted completely!'

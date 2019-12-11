#! /bin/bash
dir=$1
description=`jq -r '.description' $dir`
package_path=`jq -r '.package_path' $dir`
service_url=`jq -r '.service_url' $dir`
service_path=`jq -r '.service_path' $dir`
file_name=`jq -r '.file_name' $dir`
FILE=/etc/systemd/system/$file_name.service

if [ -f "$FILE" ]; then
    echo "$FILE exist"
    sudo systemctl restart $file_name.service
else 
    echo "Creating $file_name"
    sudo touch /etc/systemd/system/$file_name.service

    echo "[Unit]
Description=$description
After=network.target

[Service]
ExecStart=$package_path $service_path $service_url
Restart=on-failure

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/$file_name.service
    sudo systemctl daemon-reload
    sudo systemctl enable $file_name.service
    sudo sudo systemctl start $file_name
fi






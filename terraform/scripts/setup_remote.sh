#!/bin/bash

# The starting directory for the script is realtive to package.json
cd ./terraform

# Initialize Terraform and create the infrastructure
terraform init
terraform fmt
terraform validate
terraform apply -auto-approve

rm -rf terraform.pem | :
terraform output -raw ssh_private_key > terraform.pem
chmod 400 terraform.pem

ssh \
ec2-user@$(terraform output -raw instance_public_ip) \
-i terraform.pem \
-o StrictHostKeyChecking=no \
<< EOF
sudo sed -i "s/#GatewayPorts no/GatewayPorts yes/" /etc/ssh/sshd_config
sudo reboot 

EOF

echo "I sleep"
sleep 20
echo "I still sleep"
sleep 20
echo "I still sleep"
sleep 20
echo "Real s___!?"

ssh \
-fNtR \
$(terraform output -raw instance_public_ip):3000:localhost:3000 \
ec2-user@$(terraform output -raw instance_public_ip) \
-i terraform.pem \
-o StrictHostKeyChecking=no

# Post the public_ip address to Slack\
curl \
-X \
POST \
-H 'Content-type: application/json' \
--data '{"text":"'"http://$(terraform output -raw instance_public_ip):3000"'"}' \
https://hooks.slack.com/services/"$(grep SLACK_WEB_HOOK_ADDRESS .env.local | cut -d '=' -f 2-)"

# Remove the key
rm -rf terraform.pem
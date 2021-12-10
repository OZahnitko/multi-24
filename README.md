# Multi-24

## sed -i

In place replacement for the BOIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII!

## This Works

```bash
#!/bin/bash
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
```

Will need to have two commands:

- one to edit sshd_config
- and one to forward the port after the restart

#!/bin/bash

# Create user only if it doesn't exist
id -u agneesh_user_01 >/dev/null 2>&1 || useradd -m -s /bin/bash agneesh_user_01

# Set password
echo "agneesh_user_01:Welcome@123" | chpasswd

# Give sudo access
usermod -aG sudo agneesh_user_01

# Enable password authentication in main SSH config
sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Cloud-init override for Ubuntu EC2 images
mkdir -p /etc/ssh/sshd_config.d
cat > /etc/ssh/sshd_config.d/60-cloudimg-settings.conf <<EOF
PasswordAuthentication yes
EOF

# Validate SSH configuration
sshd -t || exit 1

# Restart SSH service
systemctl restart ssh || systemctl restart sshd

echo "User created successfully"
echo "Username: agneesh_user_01"
echo "Password: Welcome@123"

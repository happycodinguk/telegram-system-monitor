#!/bin/bash

# Inserts text at end of file /etc/pam.d/sshd
echo '## SSH Login Notification Below - ssh-login-warning.sh ' >> /etc/pam.d/sshd
echo 'session optional pam_exec.so type=open_session seteuid "YOUR_INSTALL_DIR"/ssh-login-warning.sh' >> /etc/pam.d/sshd

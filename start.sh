#!/bin/sh

__create_user() {
# Create a user to SSH into as.
SSH_USER=user
SSH_USERPASS=user
useradd $SSH_USER
echo -e "$SSH_USERPASS\n$SSH_USERPASS" | (passwd --stdin $SSH_USER)
echo ssh user password: $SSH_USERPASS
}

# Call all functions
__create_user

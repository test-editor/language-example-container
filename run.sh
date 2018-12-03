#!/bin/sh

if [ "$REPOSITORY_URL" == "" ]; then
  REPOSITORY_URL="https://github.com/test-editor/language-examples"
fi

# If there is some public key in keys folder
# then it copies its contain in authorized_keys file
cd /home/git
cat /git-server/keys/*.pub > .ssh/authorized_keys
chown -R git:git .ssh
chmod 700 .ssh
chmod -R 600 .ssh/*

# Checking permissions and fixing SGID bit in repos folder
# More info: https://github.com/jkarlosb/git-server-docker/issues/1
cd /git-server/repos
git clone $REPOSITORY_URL --bare
chown -R git:git .
chmod -R ug+rwX .
find . -type d -exec chmod g+s '{}' +

mkdir -p ~/.ssh
cat /git-server/keys/*.pub > ~/.ssh/authorized_keys

# -D flag avoids executing sshd as a daemon
/usr/sbin/sshd -D

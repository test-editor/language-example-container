#!/bin/sh
ps | grep sshd | grep -v grep || exit 1
ssh-keyscan -p 22 gitrepo || exit 1
exit 0

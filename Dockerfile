FROM alpine:3.4

LABEL license="EPL 1.0" \
      name="testeditor/git-examples"

RUN apk add --no-cache \
  openssh \
  git

# Key generation on the server
RUN ssh-keygen -A

WORKDIR /git-server/

# -D flag avoids password generation
# -s flag changes user's shell
RUN mkdir -p /git-server/keys \
  && mkdir -p /git-server/repos \
  && adduser -D -s /usr/bin/git-shell git \
  && echo git:12345 | chpasswd \
  && mkdir /home/git/.ssh

# sshd_config file is edited for enable access key and disable access password
COPY sshd_config /etc/ssh/sshd_config
COPY run.sh run.sh
COPY id_rsa.pub /git-server/keys/id_rsa.pub
COPY healthcheck.sh /git-server/healthcheck.sh

EXPOSE 22

CMD ["/bin/sh", "run.sh"]
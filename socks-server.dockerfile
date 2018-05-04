FROM alpine

RUN apk --update add --no-cache openssh &&\
	rm -rf /var/cache/apk/*

RUN ssh-keygen -N '' -t rsa -f /root/.ssh/id_rsa &&\
	cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys &&\
	chmod 640 /root/.ssh/authorized_keys

VOLUME /root/.ssh/

EXPOSE 1080

CMD ssh -CNv -D 0.0.0.0:1080 -o StrictHostKeyChecking=no sshd-server

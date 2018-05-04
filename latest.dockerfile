FROM alpine

RUN apk --update add --no-cache openssh &&\
	rm -rf /var/cache/apk/*

RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config &&\
	sed -ie 's/#Port 22/Port 22/g' /etc/ssh/sshd_config &&\
	sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_key/HostKey \/etc\/ssh\/ssh_host_key/g' /etc/ssh/sshd_config &&\
	sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_rsa_key/HostKey \/etc\/ssh\/ssh_host_rsa_key/g' /etc/ssh/sshd_config &&\
	sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_dsa_key/HostKey \/etc\/ssh\/ssh_host_dsa_key/g' /etc/ssh/sshd_config &&\
	sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ecdsa_key/HostKey \/etc\/ssh\/ssh_host_ecdsa_key/g' /etc/ssh/sshd_config &&\
	sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ed25519_key/HostKey \/etc\/ssh\/ssh_host_ed25519_key/g' /etc/ssh/sshd_config &&\
	ssh-keygen -A &&\
	ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_key

RUN ssh-keygen -N '' -t rsa -f /root/.ssh/id_rsa &&\
	cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys &&\
	chmod 640 /root/.ssh/authorized_keys

EXPOSE 1080

CMD /usr/sbin/sshd && ssh -CNv -D 0.0.0.0:1080 -o StrictHostKeyChecking=no localhost

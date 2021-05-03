from ubuntu:20.04


ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.1/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer /
RUN apt-get update -y && apt-get -y install openssh-server
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
ADD services.d/ssh /root/ssh.sh
RUN chmod 755 /root/ssh.sh
ENTRYPOINT ["/root/ssh.sh"]

#ENTRYPOINT /root/ssh.sh
#RUN apt-get update && \
#    apt-get install -y nginx && \
#    echo "daemon off;" >> /etc/nginx/nginx.conf
#ENTRYPOINT ["/init"]
#CMD ["ssh"]

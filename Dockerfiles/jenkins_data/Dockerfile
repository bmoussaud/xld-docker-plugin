FROM jenkins:weekly

USER jenkins

RUN mkdir -p  /var/jenkins_home
ADD jenkins_home /var/jenkins_home
VOLUME ["/var/jenkins_home"]
CMD ["/bin/sh"]

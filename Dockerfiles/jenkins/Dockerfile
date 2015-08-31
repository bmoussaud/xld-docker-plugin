FROM jenkins:weekly

USER root

RUN wget -qO- https://get.docker.com/ | sh

RUN groupmod -g 233 docker && \
    usermod -a -G docker jenkins

ADD init/*.groovy /usr/share/jenkins/init.groovy.d/

RUN mkdir -p /usr/share/jenkins/plugins && \
    chown -R jenkins /usr/share/jenkins/plugins /usr/share/jenkins/init.groovy.d

ADD plugins.awk plugins.csv /usr/share/jenkins/

RUN awk -f /usr/share/jenkins/plugins.awk /usr/share/jenkins/plugins.csv | sh

ADD jenkins-init.sh /usr/local/bin/jenkins-init.sh

VOLUME ["/var/jenkins_home"]

ENV JAVA_OPTS -Djava.security.egd=file:/dev/./urandom

ENTRYPOINT ["/usr/local/bin/jenkins-init.sh"]

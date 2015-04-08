FROM jenkins

COPY hudson.tasks.Maven.xml /var/jenkins_home/hudson.tasks.Maven.xml
COPY com.xebialabs.deployit.ci.DeployitNotifier.xml /var/jenkins_home/com.xebialabs.deployit.ci.DeployitNotifier.xml
#RUN mkdir -p /var/jenkins_home/jobs/PetPortal
#COPY jobs/PetPortal/config.xml /var/jenkins_home/jobs/PetPortal/config.xml


COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt





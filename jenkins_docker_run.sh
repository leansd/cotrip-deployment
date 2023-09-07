docker run  --name jenkins -u root -p 9090:8080 -v /var/run/docker.sock:/var/run/docker.sock --volume jenkins-data:/var/jenkins_home  -d jenkins/jenkins:2.421-jdk17

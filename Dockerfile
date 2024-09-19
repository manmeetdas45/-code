FROM openjdk:8-jre

RUN apt-get update
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt install -f ./google-chrome-stable_current_amd64.deb -y

RUN mkdir /var/lib/tomcat8.5
WORKDIR /var/lib/tomcat8.5

ADD ./server_files/apache-tomcat-8.5.83.tar.gz .
RUN mv apache-tomcat-8.5.83/* /var/lib/tomcat8.5

EXPOSE 8080

COPY . /var/lib/tomcat8.5/webapps/ROOT

RUN chmod -R 777 /var/lib/tomcat8.5/webapps/ROOT
RUN rm -frv /var/lib/tomcat8.5/webapps/ROOT/favicon.ico
COPY ./resources/favicon.ico /var/lib/tomcat8.5/webapps/ROOT

RUN mkdir /var/lib/mongodb-atlas
COPY ./mongodb-atlas /var/lib/mongodb-atlas
RUN chmod -R 777 /var/lib/mongodb-atlas

RUN rm -frv /var/lib/tomcat8.5/webapps/ROOT/config/*
CMD ["/var/lib/tomcat8.5/bin/catalina.sh", "run"]


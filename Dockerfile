# Tomcat 8.5와 Java 8을 사용하는 이미지를 기반으로 사용
FROM tomcat:8.5-jdk8-openjdk-slim

# 로컬 시스템의 server.xml 파일을 도커 컨테이너 내부의 톰캣 conf 디렉토리로 복사
#COPY server.xml /usr/local/tomcat/conf/server.xml

# WAR 파일을 Tomcat의 webapps 폴더로 복사
COPY target/dsicgram-1.0.0.war /usr/local/tomcat/webapps/ROOT.war

# 컨테이너의 8080 포트를 외부로 노출
EXPOSE 8080

# Tomcat을 실행하는 명령어
#CMD ["catalina.sh", "run"]

# COPY {export한 파일명} /docker-entrypoint-initdb.d/
#COPY Dump20241216.sql /docker-entrypoint-initdb.d/
FROM openjdk:11
EXPOSE 8085
ADD target/spring-boot-jpa-postgresql-0.0.1.jar spring-boot-jpa-postgresql-0.0.1.jar
ENTRYPOINT ["java", "-jar", "/spring-boot-jpa-postgresql-0.0.1.jar"]

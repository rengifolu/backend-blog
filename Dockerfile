FROM openjdk:11
EXPOSE 8085
ADD target/backend-blog.jar backend-blog.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
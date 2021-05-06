FROM openjdk:11
EXPOSE 8085
ADD target/backend-blog-0.0.1.jar backend-blog-0.0.1.jar
ENTRYPOINT ["java", "-jar", "/backend-blog-0.0.1.jar"]
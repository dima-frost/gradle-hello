FROM openjdk
WORKDIR /app
COPY build/libs/*jar /app/hello.jar
CMD ["java", "-jar", "hello.jar"]


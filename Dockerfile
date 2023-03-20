FROM openjdk:17
USER 185
EXPOSE 8080
ADD https://dtdg.co/latest-java-tracer /app/dd-java-agent.jar
ADD build/libs/*-all.jar app.jar
ENTRYPOINT ["java", "-javaagent:/app/dd-java-agent.jar", "-jar", "app.jar"]
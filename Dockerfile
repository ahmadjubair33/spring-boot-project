FROM maven AS first
WORKDIR /capstone
COPY . . 
RUN ls
RUN  mvn clean package
#RUN echo "I am in current dir"



FROM openjdk:11-jre-slim
COPY --from=first /capstone/target/hello-0.0.1-SNAPSHOT.jar .

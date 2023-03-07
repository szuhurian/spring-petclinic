FROM maven:3.8.7-amazoncorretto-17 AS build-env
WORKDIR /PetClinic_DockerHub

COPY pom.xml ./
RUN mvn dependency:go-offline
RUN mvn spring-javaformat:help

COPY . ./
RUN mvn spring-javaformat:apply
RUN mvn package -DfinalName=petclinic

FROM amazoncorretto:17-al2-jdk
EXPOSE 8080
WORKDIR /PetClinic_DockerHub

COPY --from=build-env PetClinic_DockerHub/target/spring-petclinic-3.0.0-SNAPSHOT.jar ./petclinic.jar
CMD ["/usr/bin/java", "-jar", "/PetClinic_DockerHub/petclinic.jar"]

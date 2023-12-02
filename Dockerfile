# Utiliser une image de base avec Maven et JDK pour la construction
FROM maven:3.8.1-jdk-11 AS build

# Copier les fichiers sources dans l'image
COPY src /var/lib/jenkins/workspace/pipeline-triangle
COPY pom.xml /var/lib/jenkins/workspace/pipeline-triangle

# Exécuter mvn package pour construire l'application
RUN mvn -f /var/lib/jenkins/workspace/pipeline-triangle/pom.xml clean package

# Utiliser une image de base avec JRE pour l'exécution
FROM openjdk:11-jre-slim

# Copier le fichier JAR construit depuis l'étape de build
COPY --from=build /var/lib/jenkins/workspace/pipeline-triangle/target/*.jar //var/lib/jenkins/workspace/pipeline-triangle/target/nomprojet-1.0-SNAPSHOT.jar

# Exposer le port sur lequel l'application s'exécute
EXPOSE 8080

# Commande pour démarrer l'application
ENTRYPOINT ["java","-jar","/var/lib/jenkins/workspace/pipeline-triangle/target/nomprojet-1.0-SNAPSHOT.jar"]


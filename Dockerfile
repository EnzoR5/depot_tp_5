# Utiliser une image de base avec Maven et JDK pour la construction
FROM maven:3.8.1-jdk-11 AS build

# Copier les fichiers sources dans l'image
COPY src /home/app/src
COPY pom.xml /home/app

# Exécuter mvn package pour construire l'application
RUN mvn -f /home/app/pom.xml clean package

# Utiliser une image de base avec JRE pour l'exécution
FROM openjdk:11-jre-slim

# Copier le fichier JAR construit depuis l'étape de build
COPY --from=build /home/app/target/*.jar /usr/local/lib/nomprojet-1.0-SNAPSHOT.jar

# Exposer le port sur lequel l'application s'exécute
EXPOSE 8080

# Commande pour démarrer l'application
ENTRYPOINT ["java","-jar","/usr/local/lib/nomprojet-1.0-SNAPSHOT.jar"]


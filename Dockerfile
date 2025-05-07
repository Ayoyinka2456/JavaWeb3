# Stage 1: Build with Maven
FROM maven:3.8.6-openjdk-8 AS builder

# Set working directory
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src/ ./src/

# Build the project (produces target/*.war)
RUN mvn clean package

# Stage 2: Deploy to Tomcat
FROM tomcat:9.0-jdk8-openjdk

# Remove default webapps (optional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy built WAR to Tomcat webapps as ROOT.war
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]

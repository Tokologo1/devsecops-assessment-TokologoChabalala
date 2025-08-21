# Use Maven + JDK image to build and run
FROM maven:3.9.3-eclipse-temurin-17

WORKDIR /app

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Copy project files
COPY pom.xml .
COPY src ./src

# Package the app
RUN mvn clean package -DskipTests

# Expose port
EXPOSE 8081

# Run the app
CMD ["java", "-jar", "target/country-service-0.0.1-SNAPSHOT.jar"]

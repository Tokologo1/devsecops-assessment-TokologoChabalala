# ===============================
# Stage 1: Build Backend (Spring Boot)
# ===============================
FROM maven:3.9.9-eclipse-temurin-17 AS backend-build
WORKDIR /src

# Cache deps
COPY backend/pom.xml .
RUN mvn -q -DskipTests dependency:go-offline

# Build
COPY backend/src ./src
RUN mvn -q -DskipTests clean package

# ===============================
# Stage 2: Runtime (minimal, non-root)
# ===============================
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Minimal runtime deps & CA certs
RUN apk add --no-cache ca-certificates tzdata && update-ca-certificates

# Non-root user
RUN addgroup -S app && adduser -S app -G app
USER app

# Copy built jar
COPY --from=backend-build /src/target/*-SNAPSHOT.jar app.jar

# Healthcheck (expects Spring Boot Actuator)
HEALTHCHECK --interval=30s --timeout=5s --retries=5 \
  CMD wget -qO- http://127.0.0.1:8081/actuator/health || exit 1

ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -XX:MaxRAMPercentage=75"
EXPOSE 8081

ENTRYPOINT ["sh","-c","java $JAVA_OPTS -jar /app/app.jar"]

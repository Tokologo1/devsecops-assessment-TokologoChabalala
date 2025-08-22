# ===============================
# Stage 1: Build Backend (Spring Boot)
# ===============================
FROM maven:3.9.3-eclipse-temurin-17 AS backend-build
WORKDIR /app/backend

# Copy backend code
COPY backend/pom.xml .
COPY backend/src ./src

# Build backend JAR
RUN mvn clean package -DskipTests

# ===============================
# Stage 2: Build Frontend (React)
# ===============================
FROM node:20-alpine AS frontend-build
WORKDIR /app/frontend

# Copy frontend code
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

# ===============================
# Stage 3: Final image
# ===============================
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy backend JAR
COPY --from=backend-build /app/backend/target/country-service-0.0.1-SNAPSHOT.jar ./backend.jar

# Copy frontend build (static files)
COPY --from=frontend-build /app/frontend/build ./frontend

# Expose backend port
EXPOSE 8081

# Start backend
ENTRYPOINT ["java","-jar","backend.jar"]

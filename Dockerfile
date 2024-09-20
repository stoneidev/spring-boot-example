# Stage 1: Build the application
FROM openjdk:23-jdk-slim AS build
WORKDIR /app

# 소스 파일 복사
COPY . .

# gradlew에 실행 권한 부여
RUN chmod +x ./gradlew

# Gradle Wrapper를 사용하여 애플리케이션 빌드
RUN ./gradlew bootJar --no-daemon

# Stage 2: Run the application
FROM openjdk:23-jdk-slim
WORKDIR /app

# 애플리케이션 JAR 파일을 복사합니다
COPY --from=build /app/build/libs/*.jar app.jar

# 비루트 사용자 생성 및 사용
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
USER appuser

# 애플리케이션 실행 명령 설정
ENTRYPOINT ["java", "-jar", "app.jar"]

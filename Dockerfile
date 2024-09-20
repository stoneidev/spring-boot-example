# Stage 1: Build the application
FROM gradle:8.3-jdk23 AS build
WORKDIR /app

# 필요한 파일 복사
COPY build.gradle settings.gradle ./
COPY gradle ./gradle

# 의존성 캐시를 위해 먼저 의존성만 다운로드
RUN gradle build -x test --no-daemon || return 0

COPY src ./src
RUN gradle bootJar --no-daemon

# Stage 2: Run the application
FROM openjdk:23-jdk-slim
WORKDIR /app

# 애플리케이션 JAR 파일을 복사합니다
COPY --from=build /app/build/libs/*.jar app.jar

# 비루트 사용자 생성 및 사용
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
USER appuser

# 애플리케이션 실행 명령 설정
ENTRYPOINT ["java", "-jar", "app.jar"]s
# 첫 번째 스테이지: Gradle 빌드
FROM gradle:8.5-jdk17 AS builder

WORKDIR /app

# 프로젝트 소스를 컨테이너에 복사
COPY . .

# Gradle 빌드 실행 (테스트 제외)
RUN ./gradlew build -x test

# 두 번째 스테이지: 실행
FROM openjdk:17-jdk-slim

# 빌드된 JAR 파일을 복사
COPY --from=builder /app/build/libs/*.jar koolcart_b.jar

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "koolcart_b.jar"]
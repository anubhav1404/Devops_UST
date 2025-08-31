# Dockerfile Best Practices


---

## 1. Multi-Stage Builds
- Separate build and runtime environments.
- Only the necessary artifacts (like JAR files or build output) are copied to the final image.
- Keeps the production image small and clean.

---

## 2. Lightweight Base Images
- Use Alpine-based images (`openjdk:17-jre-alpine`, `node:18-alpine`, `nginx:alpine`) wherever possible.
- Smaller images are faster to pull and have a smaller attack surface.

---

## 3. Dependency Caching
- Install dependencies before copying source code to take advantage of Docker layer caching.
- Examples:
  - Java: `mvn dependency:go-offline`
  - Node.js: `npm ci`
- Makes rebuilds faster when dependencies don’t change.

---

## 4. Non-Root User
- Create and use a non-root user to run the application.
- Examples:
  - Java: `adduser` / `addgroup` and `USER appuser`
- Improves container security.

---

## 5. Correct File Ownership
- Copy files with proper ownership for the non-root user.
- Example: `COPY --chown=appuser:appgroup ...`
- Prevents permission issues at runtime.

---

## 6. Clean Runtime Environment
- Remove unnecessary files from the runtime image.
- Example: `rm -rf /usr/share/nginx/html/*` before copying the app.
- Keeps the image tidy and avoids serving unwanted files.

---

## 7. Explicit Working Directory
- Set a consistent working directory (`WORKDIR /app` or `/build`) for all commands.
- Avoids path-related errors and makes the Dockerfile easier to read.

---

## 8. Expose Only Necessary Ports
- Declare only the ports that the application needs (`EXPOSE 80`, `EXPOSE 8080`, `EXPOSE 8081`).
- Documents intended usage and reduces the attack surface.

---

## 9. Minimal Runtime Dependencies
- Only include what is needed to run the application.
- Example: use `-jre-alpine` instead of full JDK in production.
- Keeps the final image lightweight and secure.

---

## 10. Clear Entry Point
- Define the main process for the container.
- Examples:
  - Java: `ENTRYPOINT ["java", "-jar", "app.jar"]`
  - Nginx: `CMD ["nginx", "-g", "daemon off;"]`
- Ensures predictable container behavior.

---

## 11. Separate Dependencies from Source Code
- Install dependencies before copying the source code.
- Helps leverage Docker caching for faster builds.
- Example:
  - Node.js: copy `package.json` → install dependencies → copy source
  - Maven: copy `pom.xml` → fetch dependencies → copy source

---

These practices help make our Docker images **secure, efficient, and easy to maintain**.

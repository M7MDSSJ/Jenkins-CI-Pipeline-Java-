# Jenkins CI Pipeline Lab (Java)

## Overview

This repository demonstrates a complete Continuous Integration (CI) pipeline implemented using Jenkins for a Java-based application.  
The project represents a production-like CI lab where multiple DevOps tools are integrated to automate testing, enforce code quality, manage artifacts, and provide team notifications.

The pipeline follows a quality-first CI model, ensuring that source code is validated and analyzed before any build artifact is published.

---

## Architecture Diagram

![CI Architecture](screenshots/architecture-diagram.png)

---

## Tool Stack

| Category | Tool |
|--------|------|
| Source Control | GitHub |
| CI Orchestration | Jenkins |
| Build & Test | Maven |
| Code Style Enforcement | Checkstyle |
| Static Code Analysis | SonarQube |
| Quality Gate Enforcement | SonarQube |
| Artifact Repository | Nexus Repository |
| Notifications | Slack |
| Infrastructure Provisioning | Vagrant |
| Virtualization | VirtualBox |
| Runtime | JDK 17 |
| Database | PostgreSQL |
| Reverse Proxy | Nginx |

---

## End-to-End CI Flow

1. A developer pushes code to the GitHub repository  
2. Jenkins fetches the source code using Git integration  
3. Unit tests are executed using Maven  
4. Code style is validated using Checkstyle  
5. The application is built using Maven  
6. Static code analysis is performed using SonarQube  
7. The SonarQube Quality Gate is evaluated  
8. If all quality checks pass, the build artifact is published to Nexus Repository  
9. Jenkins sends the build result to Slack  

Each stage depends on the success of the previous stage, enforcing fail-fast behavior and preventing low-quality artifacts from being published.

---

## Project Purpose

- Demonstrate a real-world Jenkins CI pipeline
- Showcase integration between CI, quality, and artifact tools
- Enforce automated quality gates before artifact publishing
- Serve as a hands-on DevOps CI laboratory
- Provide a portfolio-ready CI reference implementation

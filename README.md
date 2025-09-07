# Kubernetes Microservices Deployment Guide

This document provides an overview of the deployment configuration for the microservices architecture.

---

## Frontend Deployment
- Defined **resource requests and limits** (`10m–50m CPU`, `20–64Mi memory`) → ensures efficient scheduling and prevents resource hogging.  
- Added **liveness & readiness probes** → improves reliability by auto-restarting unhealthy pods and only serving traffic when ready.  
- Kept **lightweight image (Nginx)** for static hosting → good choice for frontend delivery.  

---

## Backend Deployment
- Used **Spring Boot health actuator** for liveness & readiness probes (`/actuator/health`).  
- Applied **resource requests & limits** suitable for backend (`50m–250m CPU`, `200–512Mi memory`).  
- Structured **environment variables** for DB connection.  

---

## AI Service Deployment
- Sensitive credentials (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`) are loaded from **Kubernetes Secrets** → ✅ security best practice.  
- Added **resource requests & limits** (`50m–200m CPU`, `200–512Mi memory`).  
- Defined **liveness & readiness probes** on `/actuator/health`.  
- Kept **AWS region configurable** as environment variable → good design for portability and security.  

---

## PostgreSQL (StatefulSet)
- Used **StatefulSet** (not Deployment) → correct for stateful workloads like databases.  
- Configured **PersistentVolumeClaim (PVC)** for data persistence.  
- Added **liveness & readiness probes** via TCP check on port `5432`.  
- Defined **service (postgres-service)** for stable network identity.  

---

## Postgres Storage (PVC + PV)
- Created a **PersistentVolumeClaim (PVC)** to decouple storage requests from the actual volume → portable and reusable.  
- Defined a **PersistentVolume (PV)** with `Retain` reclaim policy → ensures data is preserved even if PVC is deleted (prevents accidental data loss).  
- Used **hostPath** for local development → quick and easy for testing.  
- Correct access mode (`ReadWriteOnce`) for Postgres, since only one node should write to the volume at a time.  

---

## Services
- Each microservice has its own **Service object** → ensures stable DNS-based communication.  
- Used **label selectors** (`app: frontend`, `app: backend`, `app: ai-service`) → clean separation and maintainability.  
- Exposed services on **port 80** for uniformity while mapping to different target ports (`8080` for backend, `8081` for AI) → simplifies client communication.  
- Created dedicated **service for PostgreSQL (postgres-service)** → ensures stable DB connectivity for backend.  

---

## NetworkPolicies
- **Microservice-to-microservice isolation:**  
  - Backend accepts traffic from frontend.  
  - Postgres only accepts traffic from backend.  
  - AI service only accepts traffic from frontend and ingress-nginx.  
  - Frontend only accepts traffic from ingress-nginx.  

- **DNS egress rules included** → ensures pods can still resolve domain names while restricting other unnecessary outbound traffic.  
- **Least privilege model**: only explicitly allowed traffic flows are permitted → zero-trust inside the cluster.  
- **Policies cover both Ingress and Egress**, which is often overlooked.  

---

## Ingress (frontend-ingress.yaml)
- Used **Ingress resource** (instead of NodePort/LB directly) → centralizes routing and is production-ready.  
- Defined **path `/` with Prefix type** → clean routing of all frontend traffic.  
- Explicit `ingressClassName: nginx` → ensures rule binds specifically to the NGINX ingress controller (avoids conflicts if multiple controllers exist).  
- Decoupled ingress from frontend service by referencing **frontend-service** → modular design.  

---

## Ingress-NGINX Controller Service
- Configured **ingress-nginx controller** as a **NodePort Service**, making it externally accessible without a cloud load balancer (perfect for bare-metal/minikube/dev).  
- Exposed both **HTTP (30080)** and **HTTPS (30443)** NodePorts for external access.  
- Properly matched **selector labels** (`app.kubernetes.io/name: ingress-nginx`, `component: controller`) → ensures correct pod targeting.  

---

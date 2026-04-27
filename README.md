# AI Service Desk Automation Stack

A self-hosted, AI-powered IT Service Desk automation platform using local LLMs and workflow orchestration.
(Ollama | n8n | Open WebUI | HTML Client | Docker)

Overview

This system processes IT service requests using a locally hosted Large Language Model (LLM) and returns structured JSON outputs for automation, triage, and routing.

Designed as a foundation for AIOps and intelligent service desk automation, the platform emphasizes privacy, cost efficiency, and extensibility.

---

## System Flow
```
User
↓
HTML Client (Web UI / API / PowerShell)
↓  
n8n Webhook (Workflow Engine)  
↓  
Ollama (Local LLM Inference)  
↓  
AI Processing Layer  
↓  
Structured JSON Output  
↓  
Client / Automation / Logging Systems
```
---

## Purpose of this Project

This project demonstrates:

- AI workflow orchestration
- Local LLM deployment (no external APIs)
- DevOps and containerized infrastructure
- Prompt engineering for structured outputs
- API + UI integration
- Automation-first design

---

## Architecture Decisions

Why Local LLM (Ollama)
- No external API dependency (privacy-first)
- No token-based cost model
- Full control over model execution
- Offline capability

Why n8n
- Rapid workflow orchestration
- Visual pipeline design
- Faster iteration vs custom backend
- Easy integration with APIs and automation tools

Why Single Model Architecture
- Eliminates model routing complexity
- Ensures consistent output format
- Reduces latency
- Simplifies debugging and maintenance

---

## LLM Model Selection (llama3.1:8b)

This system uses llama3.1:8b as the primary model.

Why this model
- Strong instruction-following for structured JSON output
- Reliable for classification and summarization tasks
- Lower hallucination compared to smaller models (phi3-mini, gemma-2b)
- Balanced performance vs resource usage
- Optimized for local execution via Ollama

Why not larger models
- Higher RAM/VRAM requirements
- Increased latency
- Not practical for local-first architecture

Why not smaller models
- Lower accuracy in classification
- Inconsistent structured output
- Higher error rate in reasoning

---

## Core Capabilities
- Request classification (incident | service_request | change | other)
- Priority assignment (low | medium | high)
- Query summarization
- Reasoning generation
- Confidence scoring (0.0–1.0)
- Team routing suggestion (network | identity | security | endpoint | app | developer | finance | hr | other)

---

## Architecture
```
| Component |	Role |
|-----------|------|
| Ollama | Local LLM runtime |
| n8n | Workflow automation engine |
| Open WebUI | Model testing interface |
| HTML Client |	Request submission UI |
| Docker | Container orchestration |
```
---

## Project Structure
```
AI-ITOps-Intelligence-Platform/
│
├── docker-compose.yml
├── README.md
├── .env.example
├── .gitignore
│
├── frontend-web/
│   └── ai_help_desk.html
│
├── installer-scripts/
│   └── pull-models.ps1
│
├── ai-prompts/
│   └── prompt.json
│
└── n8n-workflows/
    └── ai_request_classifier.json
```
---

## Prerequisites

Docker
```bash
docker --version
docker compose version
```
---

## Deployment / Quick Start
1. Start services
```bash
docker compose up -d
```
2. Access services
```
| Service | URL |
|---------|-----|
| n8n | http://localhost:5678 |
| Open WebUI | http://localhost:3000 |
| Ollama | http://localhost:11434 |
```
3. Pull LLM model

  a. Manual:
```bash
  docker exec -it ollama ollama pull llama3.1:8b
```

  b. Or automated:
```bash
  ./installer-scripts/pull-models.ps1
```

## Hardware & Resource Requirements

### Minimum (Functional)
- CPU: 4 cores
- RAM: 8 GB (may be unstable)
- Storage: 15 GB
- GPU: Not required

Expected:
- Slow responses (5–15s)
- Possible instability

### Recommended (Stable)
- CPU: 6–8 cores
- RAM: 16 GB
- Storage: SSD (20+ GB)
- GPU: Optional

Expected:
- Response time: 2–6 seconds
- Stable multi-service execution

### High Performance (Optimized)
- CPU: 8+ cores
- RAM: 32 GB+
- Storage: NVMe SSD
- GPU: NVIDIA (optional)

Expected:
- Faster inference (<2–3s)
- Better concurrency handling

---

## Resource Usage Insights

| Component | Usage |
|-----------|-------|
| Ollama (LLM) | High CPU & RAM |
| n8n | Low–Moderate |
| Open WebUI | Low |
| Docker | Adds baseline overhead |

## Key Observations
- LLM is primary resource consumer
- RAM is critical for stability
- CPU affects latency
- Docker introduces overhead vs native execution

---

## Deployment Tradeoffs (Docker vs Native)

Docker Benefits
- Consistent environment
- Easy setup
- Service isolation
- Portability

Docker Considerations
- Higher CPU & RAM overhead
- Slower startup times
- Less efficient on low-spec machines

Native Alternative
- Run Ollama directly
- Run n8n via Node.js
- Serve frontend via lightweight server

When to use native
- Low-resource environments
- Performance-sensitive setups

---

## System Limitations
- No RAG (no external knowledge base)
- Stateless processing (no memory)
- Limited reasoning vs large cloud models
- Performance tied to local hardware
- Not optimized for high concurrency
- Prompt-based accuracy (no fine-tuning)

--- 

## Example Request
```json
{
  "text": "VPN is not working"
}
```
## Example Response
```json
{
  "status": "processed",
  "ai_output": {
    "type": "incident",
    "priority": "high",
    "summary": "VPN connectivity failure",
    "reasoning": "User cannot access VPN service",
    "confidence": 0.92,
    "suggested_team": "network"
  }
}
```

## Environment Variables
```
N8N_ENCRYPTION_KEY=your_secure_key_here
```

## Security Considerations
- Fully local AI execution
- No external API exposure
- Encrypted n8n credentials
- No hardcoded secrets

## Design Principles
- Stateless processing
- Structured JSON output
- Modular workflow architecture
- Model-agnostic design
- Automation-first approach

## Future Enhancements
- RAG (vector database integration)
- Multi-model routing strategy
- ServiceNow integration
- Microsoft Teams / Email alerts
- Azure AD authentication
- Observability (Prometheus + Grafana)
- Kubernetes deployment (AKS / K3s)

## Real-World Use Case

This platform can be used to:
- Automate IT service desk triage
- Reduce manual ticket classification
- Route incidents to correct teams
- Serve as a foundation for AIOps platforms

---

## Final Note

This project is designed as a production-oriented prototype, demonstrating how local AI models can be integrated into enterprise-style automation workflows while balancing performance, cost, and architectural simplicity.
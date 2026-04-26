# AI Service Desk Automation Stack

A self-hosted AI-powered IT Service Desk automation system using local LLMs and workflow orchestration.
(Ollama | n8n | Open WebUI | HTML Client)

---

## Overview

This system processes IT requests using local AI models and returns structured outputs for automation.

---

## System Flow
```
User
↓
HTML Client (Web UI / API / PowerShell)
↓  
n8n Webhook (workflow engine)  
↓  
Ollama (Local LLM inference)  
↓  
AI Processing Layer  
↓  
JSON Response  
↓  
Client (html) / Automation / Logs  
```
---

## Purpose of this Project

This project demonstrates:
    - DevOps infrastructure design
    - AI workflow orchestration
    - Local LLM deployment
    - API + UI integration
    - Automation engineering

---

## llama3.1:8b Model Selection Rationale

This system uses **llama3.1:8b** as the single LLM model.

### Why this model was chosen:

- Strong instruction following for structured JSON output
- Good balance between speed and reasoning quality
- Stable performance for classification tasks
- Lower hallucination rate compared to smaller models (phi3-mini, gemma-2b)
- Efficient enough to run locally via Ollama on consumer hardware

### Why single model approach:

- Removes routing complexity
- Improves consistency in classification
- Reduces latency (no model switching overhead)
- Simplifies n8n workflow design
- Easier to maintain and debug

## Core Capabilities

- Request classification (incident|change|service_request|other)
- Priority assignment (low|medium|high)
- Query summarization
- Reasoning generation
- Confidence scoring (0.0 to 1.0)
- Team routing suggestion (network|identity|security|endpoint|app|developer|finance|hr|other)

---

## Architecture

| Component    | Role |
|--------------|------|
| Ollama       | Local LLM runtime |
| n8n          | Workflow automation engine |
| Open WebUI   | Model testing interface |
| HTML Client  | Request submission UI |
| Docker       | Container orchestration |

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

## Deployment/Quick Start

1. Start system
```bash
docker compose up -d
```

2. Access services

| Service    |	   URL	  |
|------------|------------|
| n8n        |	http://localhost:5678  |
| Open WebUI |	http://localhost:3000  |
| Ollama     |	http://localhost:11434 |

3. LLM Model Setup (llama3.1:8b)

Pull model manually
```bash
docker exec -it ollama ollama pull llama3.1:8b
```
Or automated
```bash
./installer-scripts/pull-models.ps1
```

---

## HTML Test Client

A lightweight UI to send IT requests to the AI pipeline.

Input Fields
|   Field   |   Description   |
|-----------|-----------------|
| Request Text | User IT request |

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
---

## Environment Variables
```
N8N_ENCRYPTION_KEY=your_secure_key_here
```

---

## Security
    - Fully local AI execution
    - No external API dependency
    - Encrypted n8n credentials
    - No hardcoded secrets

---

## Design Principles
    - Stateless API processing
    - Structured JSON output only
    - Modular workflow design
    - Model-agnostic architecture

---

## Future Enhancements
    - Confidence-based routing (auto vs manual triage)
    - ServiceNow integration
    - Teams / Email notifications
    - Azure AD authentication
    - RAG knowledge base
    - Observability dashboard

---
# =====================================
# Ollama Model Bootstrap Script
# Run after: docker compose up -d
# Usage: .\pull-models.ps1
# =====================================

Write-Host "Checking Ollama container..." -ForegroundColor Cyan

# Check container is running
$containerRunning = docker ps --filter "name=ollama" --format "{{.Names}}" | Select-String "ollama"

if (-not $containerRunning) {
    Write-Host "Ollama container is not running. Start with: docker compose up -d" -ForegroundColor Red
    exit 1
}

Write-Host "Waiting for Ollama API to be ready..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

$models = @(
    "llama3.1:8b"
)

foreach ($model in $models) {
    Write-Host "Pulling model: $model" -ForegroundColor Yellow

    docker exec ollama ollama pull $model

    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to pull model: $model" -ForegroundColor Red
        exit 1
    }

    Write-Host "Successfully pulled: $model" -ForegroundColor Green
}

Write-Host "All models are ready." -ForegroundColor Green
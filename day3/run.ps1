# Autonomous Supply Chain - Master Run Script (PowerShell)
# Starts all services: Vision Agent, Supplier Agent, Control Tower

$ErrorActionPreference = "Stop"

$scriptDir = $PSScriptRoot

Write-Host "Starting Autonomous Supply Chain Services..." -ForegroundColor Cyan
Write-Host "============================================="
Write-Host ""

# ============================================================================
# Check Environment Variables
# ============================================================================

if (-not (Test-Path "$scriptDir\.env")) {
    Write-Host "ERROR: .env file missing! Please copy .env.example to .env and configure it." -ForegroundColor Red
    exit 1
}

Write-Host "Environment checked."

# Install dependencies if not present
function Install-Deps($dir) {
    Write-Host "Installing dependencies for $dir..." -ForegroundColor Yellow
    Push-Location $dir
    python -m pip install -q -r requirements.txt
    Pop-Location
}

# ============================================================================
# Start Services
# ============================================================================

# Ensure logs dir exists
if (-not (Test-Path "$scriptDir\logs")) {
    New-Item -ItemType Directory -Force -Path "$scriptDir\logs" | Out-Null
}

Install-Deps "$scriptDir\agents\vision-agent"
Write-Host "Starting Vision Agent..." -ForegroundColor Green
Start-Process "python" -ArgumentList "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8081" -WorkingDirectory "$scriptDir\agents\vision-agent" -RedirectStandardOutput "$scriptDir\logs\vision-agent.log" -RedirectStandardError "$scriptDir\logs\vision-agent-err.log" -WindowStyle Hidden -PassThru | Set-Variable VisionProc -ErrorAction SilentlyContinue

Install-Deps "$scriptDir\agents\supplier-agent"
Write-Host "Starting Supplier Agent..." -ForegroundColor Green
Start-Process "python" -ArgumentList "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8082" -WorkingDirectory "$scriptDir\agents\supplier-agent" -RedirectStandardOutput "$scriptDir\logs\supplier-agent.log" -RedirectStandardError "$scriptDir\logs\supplier-agent-err.log" -WindowStyle Hidden -PassThru | Set-Variable SupplierProc -ErrorAction SilentlyContinue

Install-Deps "$scriptDir\frontend"
Write-Host "Starting Control Tower..." -ForegroundColor Green
Start-Process "python" -ArgumentList "-m", "uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080" -WorkingDirectory "$scriptDir\frontend" -RedirectStandardOutput "$scriptDir\logs\frontend.log" -RedirectStandardError "$scriptDir\logs\frontend-err.log" -WindowStyle Hidden -PassThru | Set-Variable FrontendProc -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host "  All Services Started!                          " -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host "  Control Tower:  http://localhost:8080          " -ForegroundColor Cyan
Write-Host "  Vision Agent:   http://localhost:8081          " -ForegroundColor Cyan
Write-Host "  Supplier Agent: http://localhost:8082          " -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Check the logs folder for output files."
Write-Host "To stop the servers, close this terminal or manually terminate the uvicorn processes."

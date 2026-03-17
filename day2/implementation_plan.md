# Cymbal Transit Multi-Agent System - Day 2 Plan

This document outlines the step-by-step plan to build the **Cymbal Transit** system using **LangChain4J** and **MCP Toolbox for Databases**, based on the Google Codelab.

We will focus on setting up the environment, database, and running the agent application locally.

---

## 📋 Table of Contents
1. [Prerequisites & GCP Setup](#1-prerequisites--gcp-setup)
2. [Step 1: Database Setup (AlloyDB)](#step-1-database-setup-alloydb)
3. [Step 2: Schema & Data Provisioning](#step-2-schema--data-provisioning)
4. [Step 3: MCP Toolbox Setup & Deployment](#step-3-mcp-toolbox-setup--deployment)
5. [Step 4: Running the Agent Application Locally](#step-4-running-the-agent-application-locally)

---

## 1. Prerequisites & GCP Setup
Before starting, ensure you have:
- [ ] A Google Cloud Project with **billing enabled**.
- [ ] `gcloud` CLI installed and authenticated on your local machine.
- [ ] Java 17+ and Maven installed locally.

---

## Step 1: Database Setup (AlloyDB)
We will create an **AlloyDB for PostgreSQL** cluster.

### Actions:
1.  **Clone Setup Script** (or create manually):
    The lab suggests using a helper script: `https://github.com/AbiramiSukumaran/easy-alloydb-setup`.
2.  **Provision Cluster**:
    Create a cluster and instance.
    *   **Crucial for Local Testing**: Enable **Public IP Connectivity** and authorize your local IP or `0.0.0.0/0` (temporarily) to access it from your machine.

---

## Step 2: Schema & Data Provisioning
Using AlloyDB Studio (Cloud Console) or a local tool connected to the Public IP.

### Actions:
1.  **Enable Extensions**:
    Enable vector search and AI extensions.
2.  **Create Tables**:
    `transit_policies`, `bus_schedules`, `bookings`.
3.  **Insert Data**:
    Insert policies (with embeddings) and schedule records.

---

## Step 3: MCP Toolbox Setup & Deployment
The Toolbox acts as the bridge between the AI Agent and the Database.

### Actions:
1.  **Create `tools.yaml`**:
    Define operations like `find-bus-schedules`, `query-schedules`, etc.
2.  **Deploy to Cloud Run**:
    Deploy the Toolbox container image to Cloud Run.

---

## Step 4: Running the Agent Application Locally
Now we run the Spring Boot app on your machine.

### Actions:
1.  **Project Location** (✅ Flattened):
    The project files have been cloned and moved directly into the root of `day2` for ideal accessibility. No navigation depth navigation required.
3.  **Configure Application**:
    Update configuration files with `GCP_PROJECT_ID`, `GCP_REGION`, `GEMINI_MODEL_NAME`, `MCP_TOOLBOX_URL`.
4.  **Run**:
    ```bash
    mvn spring-boot:run
    ```

---
*Created for Day 2 of Code Vipassana Season 14.*

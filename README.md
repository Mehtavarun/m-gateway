# 🏗️ Home Gateway Infrastructure

The core infrastructure configuration for the **Home Operating System**. This repository orchestrates the gateway, log collection, and application services using Docker Compose.

It ties together the sibling repositories (`dashboard` and `clipboard`) into a unified local cloud.

## 🌟 Architecture

* **Gateway:** [Caddy Server](https://caddyserver.com/) (Reverse Proxy, Auto-TLS, Auth).
* **Observability:** OpenTelemetry Collector (Log aggregation and file splitting).
* **Orchestration:** Docker Compose.

## 📂 Directory Structure

```text
gateway/
├── Caddyfile            # Gateway routing & Security rules
├── otel-config.yaml     # Log routing configuration
├── docker-compose.yml   # Multi-container definition
└── logs/                # Centralized storage for service logs
```

## 🚀 Getting Started

### Prerequisites
* Docker & Docker Compose installed.
* **Sibling Repositories:** Ensure your workspace folder structure looks like this:
    ```text
    workspace/
    ├── gateway/       (This repo)
    ├── dashboard/     (Sibling repo)
    └── clipboard/     (Sibling repo)
    ```

### Installation

1.  **Clone the repositories:**
    ```bash
    # (In your workspace folder)
    git clone https://github.com/yourname/gateway.git
    git clone https://github.com/yourname/dashboard.git
    git clone https://github.com/yourname/clipboard.git
    ```

2.  **Start the Platform:**
    ```bash
    cd gateway
    docker-compose up -d --build
    ```

## 🔗 Access Points

| Service | Local URL | Container Name | Description |
| :--- | :--- | :--- | :--- |
| **Dashboard** | `https://mehta.local` | `dashboard` | Central landing page. |
| **Clipboard** | `https://clipboard.mehta.local` | `clipboard` | Secure sharing app. |
| **Gateway** | N/A | `gateway` | The Proxy handling HTTPS. |

## 🛠️ Configuration

* **Adding New Apps:** Add a new service in `docker-compose.yml` (e.g., `build: ../new-app`) and a new route in `Caddyfile`.
* **Log Routing:** Update `otel-config.yaml` to change how logs are named or rotated.

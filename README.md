# Interesting Kubectl Krew Plugins

A comprehensive setup script for installing useful kubectl krew plugins categorized by functionality. This repository contains a curated collection of essential Kubernetes plugins for daily operations, security, diagnostics, monitoring, and more.

## Overview

This setup script installs **65+ kubectl krew plugins** organized into the following categories:

- **Security Plugins** - RBAC, policy management, security scanning
- **Diagnostics & Troubleshooting** - Debugging, analysis, cluster health
- **Management Plugins** - Context switching, namespace management, resource cleanup
- **Observability & Monitoring** - Logs, events, resource visibility
- **Networking Plugins** - Network debugging, port forwarding, service visualization
- **Resource Footprint & Scalability Analysis** - Performance profiling, resource monitoring
- **Cost Management** - Cost allocation and analysis
- **Utilities** - Certificate management, secret viewing, testing tools

## Quick Start

1. **Install Krew** (if not already installed):
   ```bash
   (
     set -x; cd "$(mktemp -d)" &&
     OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
     ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
     KREW="krew-${OS}_${ARCH}" &&
     curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
     tar zxvf "${KREW}.tar.gz" &&
     ./"${KREW}" install krew
   )
   ```

2. **Add krew to your PATH**:
   ```bash
   export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
   ```

3. **Run the setup script**:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

## Plugin Categories

### Security Plugins
- `permissions` - Traces service account permissions
- `who-can` - Shows who has RBAC permissions
- `access-matrix` - Visualizes RBAC access matrix
- `kyverno` - Policy engine for Kubernetes
- `advise-policy` - Suggests OPA/Gatekeeper policies
- `score` - Kubernetes static code analysis
- `sudo` - Run commands with elevated permissions
- `kubesec-scan` - Security scanning

### Diagnostics & Troubleshooting
- `resource-capacity` - Cluster resource usage
- `pod-dive` - Pod workload tree visualization
- `topology` - Network topology visualization
- `node-admin` - Node-level administration
- `doctor` - Cluster health checker
- `explore` - Interactive API explorer
- `lineage` - Resource dependency viewer
- `mounts` - Volume mount information
- `preflight` - Pre-installation validation
- `support-bundle` - Diagnostic bundle creation
- `strace` - System call tracing
- `pod-shell` - Interactive pod shell access
- `debug-shell` - Enhanced debugging shell
- `trace` - Kernel-level bpftrace

### Management Plugins
- `ns` - Quick namespace switching
- `ctx` - Quick context switching
- `tree` - Resource hierarchy visualization
- `neat` - Clean YAML/JSON output
- `prune-unused` - Remove unused resources
- `outdated` - Find outdated container images
- `image` - Query container images
- `images` - List all container images
- `mc` - Multi-cluster command execution

### Observability & Monitoring
- `tail` - Stream logs from multiple pods
- `blame` - Resource change history
- `view-allocations` - Resource allocations
- `view-quotas` - Resource quotas
- `view-utilization` - Cluster utilization
- `view-cert` - Certificate information
- `view-webhook` - Webhook configurations
- `viewnode` - Nodes with pods visualization
- `stern` - Enhanced log tailing

### Networking Plugins
- `whoami` - Show authenticated user
- `service-tree` - Service dependency tree
- `sniff` - Network traffic capture
- `multiforward` - Multi-service port forwarding

### Resource Footprint & Scalability
- `ktop` - Top-like resource monitoring
- `node-shell` - Node shell access
- `flame` - CPU/memory flame graphs
- `node-resource` - Node resource allocation
- `nodepools` - Node pool management

### Cost Management
- `cost` - Cost allocation analysis

### Utilities
- `ca-cert` - Print cluster CA certificate
- `df-pv` - Persistent volume usage
- `oidc-login` - OIDC authentication
- `deprecations` - Check deprecated APIs
- `get-all` - List all resources
- `view-secret` - Decode secrets
- `grep` - Filter resources by name
- `count` - Count resources by kind
- `exec-cronjob` - Run CronJobs on-demand
- `evict-pod` - Evict pods safely
- `kuttl` - Kubernetes testing tool
- `rook-ceph` - Rook Ceph management

## Usage Examples

### Daily Workflow
```bash
# Switch contexts and namespaces quickly
kubectl ctx
kubectl ns

# Clean up YAML output
kubectl get pod my-pod -o yaml | kubectl neat

# Search for resources
kubectl grep pod "my-app"

# View resource allocations
kubectl view-allocations

# Check cluster health
kubectl doctor
```

### Security & Compliance
```bash
# Check who can perform actions
kubectl who-can get pods

# Analyze security
kubectl score deploy/my-app

# View RBAC matrix
kubectl access-matrix
```

### Debugging & Troubleshooting
```bash
# Get shell access to pods
kubectl pod-shell

# Trace system calls
kubectl strace pod/my-pod

# View events
kubectl events pod/my-pod

# Generate support bundle
kubectl support-bundle https://support-bundle.example.com
```

### Monitoring & Analysis
```bash
# Real-time resource monitoring
kubectl ktop

# View utilization
kubectl view-utilization

# Check node resources
kubectl node-resource

# View quotas
kubectl view-quotas
```

## Plugin Management

List all installed plugins:
```bash
kubectl krew list
```

Search for plugins:
```bash
kubectl krew search <keyword>
```

Get plugin information:
```bash
kubectl krew info <plugin-name>
```

Upgrade all plugins:
```bash
kubectl krew update
kubectl krew upgrade
```

## Notes

- The script uses `|| echo` pattern to gracefully handle plugins that are already installed
- Some plugins require additional cluster permissions (RBAC, privileged pods, etc.)
- All plugins are from the official krew-index and may show security warnings
- The script is idempotent - safe to run multiple times

## Requirements

- kubectl installed
- krew installed (see Quick Start above)
- Kubernetes cluster access (for plugin usage)
- Some plugins require metrics-server for resource metrics

## Contributing

Feel free to add more plugins or improve the categorization. The script is organized by functionality for easy navigation and maintenance.

## References

- [Krew Plugin Index](https://krew.sigs.k8s.io/plugins/)
- [Krew Documentation](https://krew.sigs.k8s.io/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)

## License

This setup script and documentation are provided as-is for convenience. Individual plugins are subject to their own licenses.


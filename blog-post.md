# Supercharge Your Kubernetes Workflow with Krew Plugins: A Complete Guide

*Extend kubectl's capabilities with essential plugins and learn to build your own*

---

## What is Krew?

[Krew](https://krew.sigs.k8s.io/) is the package manager for kubectl plugins, making it easy to discover, install, and manage extensions that enhance your Kubernetes command-line experience. Think of it as the "apt" or "brew" for kubectl—it provides a centralized repository of community-contributed plugins that solve common Kubernetes operational challenges.

Krew is maintained by the Kubernetes SIG CLI community and offers a curated index of 200+ plugins. Each plugin follows the `kubectl-<name>` naming convention, so once installed, you simply run `kubectl <name>` to use it (where `<name>` can be a verb like `explore`, noun like `ctx` or `events`, or compound like `access-matrix`).

**Installation:**
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
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
```

---

## Must-Have Krew Plugins

Here are essential plugins organized by category. For a complete list of 65+ plugins, check out the [interesting-krew-plugins repository](https://github.com/deepak-muley/interesting-krew-plugins).

### 🔒 Security Plugins

**1. `who-can`** - RBAC Permission Checker  
Quickly identify who has permissions to perform specific actions on resources. Essential for security audits and troubleshooting access issues.

```bash
kubectl krew install who-can
kubectl who-can get pods
kubectl who-can delete deployments
```

**2. `access-matrix`** - RBAC Access Matrix Visualizer  
Visualize RBAC access rights across all resources in your cluster. Provides a comprehensive view of permissions for security audits.

```bash
kubectl krew install access-matrix
kubectl access-matrix
```

### 🔍 Diagnostics & Troubleshooting

**1. `doctor`** - Cluster Health Checker  
Scans your cluster and reports anomalies, misconfigurations, and potential issues. Run this regularly to catch problems early.

```bash
kubectl krew install doctor
kubectl doctor
```

**2. `explore`** - Interactive API Explorer  
Better than `kubectl explain`—interactively explore Kubernetes API resources with fuzzy search. Perfect for discovering available fields and understanding resource schemas.

```bash
kubectl krew install explore
kubectl explore pods
```

### ⚙️ Management Plugins

**1. `ctx` & `ns`** - Context and Namespace Switchers  
Switch between Kubernetes contexts and namespaces instantly. These are game-changers for multi-cluster and multi-namespace workflows.

```bash
kubectl krew install ctx ns
kubectl ctx  # Interactive context switcher
kubectl ns   # Interactive namespace switcher
```

**2. `neat`** - Clean YAML Output  
Remove clutter from kubectl YAML/JSON output. Perfect for creating clean manifests from existing resources.

```bash
kubectl krew install neat
kubectl get pod my-pod -o yaml | kubectl neat
```

### 📊 Observability & Monitoring

**1. `stern`** - Multi-Pod Log Tailing  
Tail logs from multiple pods simultaneously with color coding and better filtering than standard `kubectl logs`.

```bash
kubectl krew install stern
kubectl stern deployment/my-app
kubectl stern ".*nginx.*"
```

**2. `events`** - Enhanced Event Viewer  
Display Kubernetes events with filtering capabilities. Essential for understanding what's happening with your resources.

```bash
kubectl krew install events
kubectl events pod/my-pod
```

### 🌐 Networking Plugins

**1. `sniff`** - Network Traffic Capture  
Capture and inspect network traffic from pods using tcpdump/wireshark. Great for debugging networking issues.

```bash
kubectl krew install sniff
kubectl sniff my-pod
```

**2. `service-tree`** - Service Dependency Visualizer  
Visualize service dependencies and backend relationships in a tree format.

```bash
kubectl krew install service-tree
kubectl service-tree
```

### 📈 Resource & Scalability Analysis

**1. `ktop`** - Real-Time Resource Monitor  
Top-like interface for monitoring CPU and memory usage of pods and nodes in real-time.

```bash
kubectl krew install ktop
kubectl ktop
```

**2. `flame`** - CPU/Memory Profiling  
Generate flame graphs for CPU and memory profiling of pods. Essential for performance analysis.

```bash
kubectl krew install flame
kubectl flame my-pod -t 1m
```

### 🛠️ Utilities

**1. `grep`** - Resource Search  
Filter Kubernetes resources by matching their names. Like grep for kubectl.

```bash
kubectl krew install grep
kubectl grep pod "my-app"
```

**2. `exec-cronjob`** - Run CronJobs On-Demand  
Execute CronJobs immediately without waiting for their schedule. Perfect for testing.

```bash
kubectl krew install exec-cronjob
kubectl exec-cronjob my-cronjob
```

---

## How to Write Your Own Krew Plugin

Creating a custom kubectl plugin is simpler than you might think. You have three main approaches:

### Option 1: Simple Shell Script (Easiest)

The simplest way is to create an executable script named `kubectl-<plugin-name>`. Place it in your PATH, and kubectl will automatically recognize it. The name can be a verb (like `explore`), noun (like `events`), or compound word (like `access-matrix`).

**Example: `kubectl-hello`**
```bash
#!/bin/bash
# kubectl-hello - A simple greeting plugin

echo "Hello from kubectl! You're connected to:"
kubectl config current-context
```

Make it executable:
```bash
chmod +x kubectl-hello
mv kubectl-hello /usr/local/bin/  # or anywhere in your PATH
kubectl hello  # Works!
```

### Option 2: Go Plugin (Recommended for Complex Logic)

For more sophisticated plugins, Go is the preferred language. Here's a minimal template:

**Project Structure:**
```
kubectl-myplugin/
├── main.go
├── go.mod
└── Makefile
```

**`main.go`:**
```go
package main

import (
    "fmt"
    "os"
    
    "k8s.io/client-go/kubernetes"
    "k8s.io/client-go/tools/clientcmd"
)

func main() {
    if len(os.Args) < 2 {
        fmt.Fprintf(os.Stderr, "Usage: kubectl myplugin <resource>\n")
        os.Exit(1)
    }
    
    // Load kubeconfig
    config, err := clientcmd.BuildConfigFromFlags("", clientcmd.RecommendedHomeFile)
    if err != nil {
        panic(err)
    }
    
    // Create clientset
    clientset, err := kubernetes.NewForConfig(config)
    if err != nil {
        panic(err)
    }
    
    // Your plugin logic here
    fmt.Printf("Connected to cluster: %s\n", config.Host)
    
    // Example: List pods
    pods, _ := clientset.CoreV1().Pods("default").List(context.TODO(), metav1.ListOptions{})
    fmt.Printf("Found %d pods\n", len(pods.Items))
}
```

**Reference Implementations:**
- **[sample-cli-plugin](https://github.com/kubernetes/sample-cli-plugin)** - Official Kubernetes sample plugin in Go
- **[kubectl-karbon](https://github.com/nutanix/kubectl-karbon)** - Real-world example connecting to Nutanix Karbon clusters

### Option 3: Using a Template

Use the [krew-plugin-template](https://github.com/replicatedhq/krew-plugin-template) for a ready-made structure:

```bash
git clone https://github.com/replicatedhq/krew-plugin-template.git kubectl-myplugin
cd kubectl-myplugin
# Customize the template
```

### Publishing to Krew Index

To make your plugin available via `kubectl krew install`, you need to:

1. **Create a Plugin Manifest** (YAML file):
```yaml
apiVersion: krew.googlecontainertools.github.com/v1alpha2
kind: Plugin
metadata:
  name: myplugin
spec:
  version: v1.0.0
  shortDescription: Short description of your plugin
  homepage: https://github.com/yourusername/kubectl-myplugin
  platforms:
  - selector:
      matchLabels:
        os: darwin
        arch: amd64
    uri: https://github.com/yourusername/kubectl-myplugin/releases/v1.0.0/kubectl-myplugin-darwin-amd64.tar.gz
    sha256: <checksum>
    bin: kubectl-myplugin
  - selector:
      matchLabels:
        os: linux
        arch: amd64
    uri: https://github.com/yourusername/kubectl-myplugin/releases/v1.0.0/kubectl-myplugin-linux-amd64.tar.gz
    sha256: <checksum>
    bin: kubectl-myplugin
```

2. **Submit to krew-index**: Open a PR to [kubernetes-sigs/krew-index](https://github.com/kubernetes-sigs/krew-index) with your plugin manifest.

3. **When to create a plugin**: Create a plugin when you find yourself repeatedly running the same kubectl command combinations or when you need functionality that doesn't exist. Plugins are perfect for:
   - Automating common workflows
   - Integrating with external tools (like the Nutanix Karbon example)
   - Providing domain-specific Kubernetes operations
   - Wrapping complex kubectl commands in simpler interfaces

For detailed documentation, see the [Krew Developer Guide](https://krew.sigs.k8s.io/docs/developer-guide/).

---

## Quick Start: Install All Must-Have Plugins

To install all the plugins mentioned above quickly, check out the [interesting-krew-plugins](https://github.com/deepak-muley/interesting-krew-plugins) repository which provides a setup script with 65+ curated plugins:

```bash
git clone https://github.com/deepak-muley/interesting-krew-plugins.git
cd interesting-krew-plugins
chmod +x setup.sh
./setup.sh
```

---

## Summary

Krew plugins transform kubectl from a basic CLI tool into a powerful, extensible platform. Whether you're using existing plugins to streamline your workflow or building custom ones to solve specific problems, Krew makes it easy to extend Kubernetes operations.

**Key Takeaways:**
- Krew provides 200+ plugins in a curated index
- Essential plugins cover security, diagnostics, management, observability, and more
- Creating plugins is simple—start with shell scripts or use Go for complex logic
- Reference examples like `kubectl-karbon` and `sample-cli-plugin` for inspiration

**Resources:**
- [Krew Official Documentation](https://krew.sigs.k8s.io/)
- [Krew Plugin Index](https://krew.sigs.k8s.io/plugins/)
- [interesting-krew-plugins Repository](https://github.com/deepak-muley/interesting-krew-plugins)
- [Kubernetes sample-cli-plugin](https://github.com/kubernetes/sample-cli-plugin)
- [kubectl-karbon Example](https://github.com/nutanix/kubectl-karbon)
- [Krew Plugin Template](https://github.com/replicatedhq/krew-plugin-template)

---

*Happy kubectl plugin-ing! 🚀*


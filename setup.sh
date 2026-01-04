#!/bin/bash

# Kubectl Krew Plugins Setup Script
# This script installs useful kubectl krew plugins categorized by functionality
# Docs: https://krew.sigs.k8s.io/

set -e

# Update krew index first
echo "Updating krew index..."
kubectl krew update

echo ""
echo "Installing krew plugins..."
echo ""

# ============================================================================
# SECURITY PLUGINS (Top 3 + your requested ones)
# ============================================================================

echo "=== Installing Security Plugins ==="

# 1. permissions - Displays and traces service account permissions
# Shows what permissions a service account has and traces them
# Docs: https://krew.sigs.k8s.io/plugins/permissions/
kubectl krew install permissions || echo "permissions already installed or failed"

# 2. rakkess - Shows an access matrix for server resources (RBAC viewer)
# Displays who can do what in your cluster - great for security audits
# Docs: https://github.com/corneliusweig/rakkess
kubectl krew install rakkess || echo "rakkess already installed or failed"

# 3. who-can - Shows who has RBAC permissions to perform actions on resources
# Quick way to check who can perform specific actions on resources
# Docs: https://github.com/aquasecurity/kubectl-who-can
kubectl krew install who-can || echo "who-can already installed or failed"

# 4. view-serviceaccount-kubeconfig - Show kubeconfig for service account authentication
# Generates kubeconfig snippet for authenticating with a service account
# Docs: https://krew.sigs.k8s.io/plugins/view-serviceaccount-kubeconfig/
kubectl krew install view-serviceaccount-kubeconfig || echo "view-serviceaccount-kubeconfig already installed or failed"

# 5. saconfig - Generate a kubeconfig file for authenticating as a service account
# Creates kubeconfig for service account authentication
# Docs: https://krew.sigs.k8s.io/plugins/saconfig/
kubectl krew install saconfig || echo "saconfig already installed or failed"

# 6. kubesec-scan - Scans resources with kubesec.io for security issues
# Scans Kubernetes manifests for security best practices and vulnerabilities
# Note: You already have this installed
# Docs: https://krew.sigs.k8s.io/plugins/kubesec-scan/
kubectl krew install kubesec-scan || echo "kubesec-scan already installed or failed"

# 7. access-matrix - Shows an RBAC access matrix for server resources
# MUST HAVE: Visualizes RBAC access rights across resources - essential for security audits
# Better alternative to rakkess with clearer output format
# Docs: https://krew.sigs.k8s.io/plugins/access-matrix/
kubectl krew install access-matrix || echo "access-matrix already installed or failed"

# 8. kyverno - Kyverno is a policy engine for Kubernetes
# Policy engine for Kubernetes - validate and test policy behavior on resources
# Essential for policy management and validation in Kubernetes clusters
# Docs: https://krew.sigs.k8s.io/plugins/kyverno/
# More info: https://kyverno.io/docs/kyverno-cli/
kubectl krew install kyverno || echo "kyverno already installed or failed"

# 9. advise-policy - Suggests PodSecurityPolicies and OPA Policies for cluster
# Suggests OPA (Open Policy Agent) Policies and PodSecurityPolicies for your cluster
# Useful for OPA/Gatekeeper policy management and recommendations
# Docs: https://krew.sigs.k8s.io/plugins/advise-policy/
kubectl krew install advise-policy || echo "advise-policy already installed or failed"

# 10. score - Kubernetes static code analysis
# Analyzes Kubernetes manifests for security issues and best practices
# Provides scores based on configuration quality - essential for security and reliability
# Docs: https://krew.sigs.k8s.io/plugins/score/
# More info: https://github.com/zegl/kube-score
kubectl krew install score || echo "score already installed or failed"

# 11. sudo - Run Kubernetes commands impersonated as group/system:authenticated
# Execute kubectl commands with elevated permissions by impersonating system:authenticated
# Useful for testing permissions and running commands that require elevated access
# Docs: https://krew.sigs.k8s.io/plugins/sudo/
kubectl krew install sudo || echo "sudo already installed or failed"

# Additional Security Plugins (commented for future use)
# kubectl krew install rbac-lookup            # Finds roles/clusterroles bound to users/serviceaccounts - Docs: https://github.com/FairwindsOps/rbac-lookup
# kubectl krew install rbac-view              # Interactive RBAC visualization tool - Docs: https://github.com/jasonrichardsmith/rbac-view
# kubectl krew install np-viewer              # Visualizes network policy rules - Docs: https://github.com/networkop/kubectl-np-viewer
# kubectl krew install advise-psp             # Suggests PodSecurityPolicies for your cluster - Docs: https://krew.sigs.k8s.io/plugins/advise-psp/

# ============================================================================
# DIAGNOSTICS & TROUBLESHOOTING PLUGINS (Top 3)
# ============================================================================

echo ""
echo "=== Installing Diagnostics Plugins ==="

# 1. resource-capacity - Shows cluster resource usage and capacity
# Provides insights into cluster resource usage, requests, limits, and utilization
# Docs: https://github.com/robscott/kube-capacity
# Note: You already have this installed
kubectl krew install resource-capacity || echo "resource-capacity already installed or failed"

# 2. pod-dive - Displays pod's workload tree and information inside a node
# Shows pod relationships, node information, and detailed pod status
# Docs: https://github.com/caicloud/pod-dive
kubectl krew install pod-dive || echo "pod-dive already installed or failed"

# 3. debug - Debug pods by creating a new container with troubleshooting tools
# Creates an ephemeral container with debugging tools to troubleshoot pods
# Docs: https://github.com/aylei/kubectl-debug
kubectl krew install debug || echo "debug already installed or failed"

# 4. topology - Shows network topology and relationships
# Provides insight into the network topology of a Kubernetes cluster
# Shows relationships between pods, services, and network policies
# Docs: https://krew.sigs.k8s.io/plugins/topology/
kubectl krew install topology || echo "topology already installed or failed"

# 5. node-admin - Spins up a privileged pod with host node mounted
# Creates a privileged pod with the host node mounted for node administration
# Useful for node-level troubleshooting and administration tasks
# Docs: https://krew.sigs.k8s.io/plugins/node-admin/
kubectl krew install node-admin || echo "node-admin already installed or failed"

# 6. spy - Spins up a privileged busybox pod for debugging
# Creates a privileged busybox pod that can attach to another pod for debugging
# Useful for troubleshooting and debugging container issues
# Docs: https://krew.sigs.k8s.io/plugins/spy/
kubectl krew install spy || echo "spy already installed or failed"

# 7. snap - Deletes half of the resources in your cluster (testing purposes)
# WARNING: Use with caution! Deletes half of resources - mainly for testing/chaos engineering
# Useful for testing disaster recovery and resource cleanup scenarios
# Docs: https://krew.sigs.k8s.io/plugins/snap/
kubectl krew install snap || echo "snap already installed or failed"

# 8. doctor - Scans your cluster and reports anomalies
# MUST HAVE: Comprehensive cluster health checker - identifies issues and misconfigurations
# Essential for cluster maintenance and troubleshooting
# Docs: https://krew.sigs.k8s.io/plugins/doctor/
kubectl krew install doctor || echo "doctor already installed or failed"

# 9. explore - A better kubectl explain with fuzzy finder
# MUST HAVE: Interactive API resource explorer - better than 'kubectl explain'
# Helps discover and understand Kubernetes API resources with search
# Docs: https://krew.sigs.k8s.io/plugins/explore/
kubectl krew install explore || echo "explore already installed or failed"

# 10. lineage - Display all dependent resources or resource dependencies
# Shows resource dependencies and relationships - displays what resources depend on a resource or what a resource depends on
# Useful for understanding resource relationships and dependencies in your cluster
# Docs: https://krew.sigs.k8s.io/plugins/lineage/
kubectl krew install lineage || echo "lineage already installed or failed"

# 11. mounts - Show Pods' Volumes and VolumeMounts in the current namespace
# Displays detailed information about volume mounts in pods - volume types, mount paths, and configurations
# Essential for troubleshooting storage issues and auditing volume usage
# Docs: https://krew.sigs.k8s.io/plugins/mounts/
kubectl krew install mounts || echo "mounts already installed or failed"

# 12. preflight - Executes application preflight tests in a cluster
# Runs pre-installation checks to validate cluster requirements and readiness
# Essential for validating cluster configuration before deploying applications
# Docs: https://krew.sigs.k8s.io/plugins/preflight/
# More info: https://troubleshoot.sh/docs/
kubectl krew install preflight || echo "preflight already installed or failed"

# 13. support-bundle - Creates support bundles for off-cluster analysis
# Collects logs and cluster information for troubleshooting and analysis
# Essential for creating diagnostic bundles for support and debugging
# Docs: https://krew.sigs.k8s.io/plugins/support-bundle/
# More info: https://troubleshoot.sh/docs/
kubectl krew install support-bundle || echo "support-bundle already installed or failed"

# 14. strace - Capture strace logs from a running workload
# Captures system call traces from running workloads for debugging and analysis
# Useful for low-level debugging and understanding system call behavior
# Docs: https://krew.sigs.k8s.io/plugins/strace/
kubectl krew install strace || echo "strace already installed or failed"

# 15. pod-shell - Display a list of pods to execute a shell in
# Interactive pod selection tool to execute shell commands in pods
# Easy way to get shell access to pods - displays list and lets you choose
# Docs: https://krew.sigs.k8s.io/plugins/pod-shell/
kubectl krew install pod-shell || echo "pod-shell already installed or failed"

# 16. debug-shell - Create pod with interactive kube-shell
# Creates a pod with interactive kube-shell for debugging and troubleshooting
# Provides enhanced shell environment with Kubernetes tools pre-installed
# Docs: https://krew.sigs.k8s.io/plugins/debug-shell/
kubectl krew install debug-shell || echo "debug-shell already installed or failed"

# 17. trace - Schedules execution of bpftrace programs in cluster
# Enables kernel-level tracing using bpftrace programs for deep debugging
# Useful for low-level performance analysis and kernel event tracing
# Docs: https://krew.sigs.k8s.io/plugins/trace/
# More info: https://github.com/iovisor/kubectl-trace
kubectl krew install trace || echo "trace already installed or failed"

# Additional Diagnostics Plugins (commented for future use)
# Note: node-shell is now in Resource Footprint & Scalability Analysis section
# kubectl krew install view-allocations       # Displays resource allocations for pods and nodes - Docs: https://github.com/davidB/kubectl-view-allocations (already enabled in Observability section)
# kubectl krew install events                 # Shows events for resources with filtering - Docs: https://krew.sigs.k8s.io/plugins/events/ (already enabled in Observability section)

# ============================================================================
# MANAGEMENT PLUGINS (Top 3)
# ============================================================================

echo ""
echo "=== Installing Management Plugins ==="

# 1. ns - Quickly switch between Kubernetes namespaces
# Fast namespace switching to improve kubectl workflow
# Docs: https://github.com/ahmetb/kubectl-extras/tree/master/ns
# Note: You already have this installed
kubectl krew install ns || echo "ns already installed or failed"

# 2. ctx - Easily switch between kubectl contexts
# Fast context switching between different Kubernetes clusters
# Docs: https://github.com/ahmetb/kubectl-extras/tree/master/ctx
kubectl krew install ctx || echo "ctx already installed or failed"

# 3. tree - Shows sub-resources of Kubernetes API objects in a tree view
# Visualizes Kubernetes resource hierarchies in a tree format
# Docs: https://github.com/ahmetb/kubectl-tree
kubectl krew install tree || echo "tree already installed or failed"

# 4. neat - Cleans up Kubernetes YAML/JSON output for readability
# MUST HAVE: Removes unnecessary fields from kubectl output - use daily with: kubectl get <resource> -o yaml | kubectl neat
# Makes YAML manifests readable by removing metadata, status, and other clutter
# Docs: https://github.com/itaysk/kubectl-neat
kubectl krew install neat || echo "neat already installed or failed"

# 5. prune-unused - Prunes unused resources
# Identifies and removes unused Kubernetes resources to optimize cluster resources
# Helps clean up orphaned resources and reduce cluster clutter
# Docs: https://krew.sigs.k8s.io/plugins/prune-unused/
kubectl krew install prune-unused || echo "prune-unused already installed or failed"

# 6. outdated - Finds outdated container images running in a cluster
# Scans your cluster to identify containers running outdated image versions
# Helps with security updates and version management
# Docs: https://krew.sigs.k8s.io/plugins/outdated/
kubectl krew install outdated || echo "outdated already installed or failed"

# 7. image - Query container images by namespace/cluster
# Query and inspect container images used in namespaces or across the cluster
# Useful for image inventory and tracking
# Docs: https://krew.sigs.k8s.io/plugins/image/
kubectl krew install image || echo "image already installed or failed"

# 8. images - Show container images used in the cluster
# Displays all container images used in your cluster with details
# Great for auditing and tracking what images are deployed
# Docs: https://krew.sigs.k8s.io/plugins/images/
kubectl krew install images || echo "images already installed or failed"

# 9. mc - Run kubectl commands against multiple clusters
# Execute kubectl commands across multiple Kubernetes clusters simultaneously
# Essential for multi-cluster management and operations
# Docs: https://krew.sigs.k8s.io/plugins/mc/
kubectl krew install mc || echo "mc already installed or failed"

# Additional Management Plugins (commented for future use)
# kubectl krew install resource-snapshot     # Takes snapshot of cluster resources - Docs: https://krew.sigs.k8s.io/plugins/resource-snapshot/
# kubectl krew install eksporter             # Exports resources to YAML/JSON - Docs: https://github.com/micnncim/kubectl-eksporter
# Note: get-all, view-secret, and deprecations are now in Utilities section

# ============================================================================
# OBSERVABILITY & MONITORING PLUGINS (Top 3)
# ============================================================================

echo ""
echo "=== Installing Observability Plugins ==="

# 1. tail - Streams logs from multiple pods in real-time
# Tails logs from multiple pods/containers simultaneously with filtering
# Docs: https://github.com/boz/kail
kubectl krew install tail || echo "tail already installed or failed"

# 2. blame - Shows who/what changed a Kubernetes resource
# Displays the history of changes to a resource with author information
# Docs: https://github.com/jesseduffield/kubectl-blame
# Note: You already have this installed
kubectl krew install blame || echo "blame already installed or failed"

# 3. view-allocations - Displays resource allocations for pods and nodes
# Shows CPU/memory allocations across pods and nodes
# Docs: https://github.com/davidB/kubectl-view-allocations
kubectl krew install view-allocations || echo "view-allocations already installed or failed"

# 4. view-quotas - List resource quotas in colors
# Displays resource quotas with color-coded output for easy visualization
# Useful for monitoring and managing resource quotas across namespaces
# Docs: https://krew.sigs.k8s.io/plugins/view-quotas/
kubectl krew install view-quotas || echo "view-quotas already installed or failed"

# 5. view-utilization - Shows cluster cpu and memory utilization
# Displays cluster-wide CPU and memory utilization metrics
# Essential for monitoring cluster resource usage and capacity planning
# Docs: https://krew.sigs.k8s.io/plugins/view-utilization/
kubectl krew install view-utilization || echo "view-utilization already installed or failed"

# 6. view-cert - View certificate information stored in secrets
# Displays certificate details from Kubernetes secrets - expiration, issuer, subject, etc.
# Essential for certificate management and monitoring certificate expiration
# Docs: https://krew.sigs.k8s.io/plugins/view-cert/
kubectl krew install view-cert || echo "view-cert already installed or failed"

# 7. view-webhook - Visualize your webhook configurations
# Visualizes webhook configurations in your cluster
# Useful for understanding and debugging admission webhooks
# Docs: https://krew.sigs.k8s.io/plugins/view-webhook/
kubectl krew install view-webhook || echo "view-webhook already installed or failed"

# 8. viewnode - Displays nodes with their pods and containers
# Shows nodes along with their associated pods and containers in a structured view
# Useful for visualizing node-to-pod relationships and container distribution
# Docs: https://krew.sigs.k8s.io/plugins/viewnode/
kubectl krew install viewnode || echo "viewnode already installed or failed"

# 9. events - Shows events for resources with filtering
# MUST HAVE: Displays Kubernetes events for troubleshooting - essential for daily debugging
# Shows what's happening with your resources (pods, deployments, etc.)
# Docs: https://krew.sigs.k8s.io/plugins/events/
kubectl krew install events || echo "events already installed or failed"

# 5. stern - Tails multiple pod logs with color and timestamps
# MUST HAVE: Better alternative to tail - colored logs, better filtering, and pod matching
# Usage: kubectl stern <pod-name-pattern> or kubectl stern deployment/my-app
# Docs: https://github.com/stern/stern
kubectl krew install stern || echo "stern already installed or failed"

# Additional Observability Plugins (commented for future use)
# kubectl krew install pod-inspect           # Inspects pod details and status - Docs: https://krew.sigs.k8s.io/plugins/pod-inspect/
# kubectl krew install resource-usage        # Shows resource usage metrics - Docs: https://krew.sigs.k8s.io/plugins/resource-usage/
# Note: ktop and flame are now in Resource Footprint & Scalability Analysis section

# ============================================================================
# NETWORKING PLUGINS (Top 3)
# ============================================================================

echo ""
echo "=== Installing Networking Plugins ==="

# 1. whoami - Shows the subject that's currently authenticated
# Displays the current authenticated user/serviceaccount
# Docs: https://github.com/rajatjindal/kubectl-whoami
# Note: You already have this installed
kubectl krew install whoami || echo "whoami already installed or failed"

# 2. service-tree - Shows a tree of services and their backends
# Visualizes service dependencies and backend relationships
# Docs: https://github.com/steveteuber/kubectl-graph
kubectl krew install service-tree || echo "service-tree already installed or failed"

# 3. sniff - Captures and inspects network traffic in pods
# Captures and analyzes network traffic from pods using tcpdump/wireshark
# Docs: https://github.com/eldadru/ksniff
kubectl krew install sniff || echo "sniff already installed or failed"

# 4. multiforward - Port Forward to multiple Kubernetes Services
# Forward ports to multiple Kubernetes services simultaneously
# Useful for forwarding multiple services at once for local development and testing
# Docs: https://krew.sigs.k8s.io/plugins/multiforward/
kubectl krew install multiforward || echo "multiforward already installed or failed"

# Additional Networking Plugins (commented for future use)
# kubectl krew install np-viewer             # Visualizes network policy rules - Docs: https://github.com/networkop/kubectl-np-viewer
# kubectl krew install net-forward           # Forwards local ports to pods - Docs: https://krew.sigs.k8s.io/plugins/net-forward/
# kubectl krew install ingress-nginx         # Manages NGINX Ingress resources - Docs: https://krew.sigs.k8s.io/plugins/ingress-nginx/
# kubectl krew install cilium                # Interacts with Cilium for network observability - Docs: https://krew.sigs.k8s.io/plugins/cilium/

# ============================================================================
# RESOURCE FOOTPRINT & SCALABILITY ANALYSIS PLUGINS (Top 3)
# ============================================================================

echo ""
echo "=== Installing Resource Footprint & Scalability Analysis Plugins ==="

# 1. ktop - Displays resource usage metrics in a top-like interface
# Real-time CPU/memory usage monitoring for pods and nodes - essential for scalability analysis
# Docs: https://github.com/vladimirvivien/ktop
kubectl krew install ktop || echo "ktop already installed or failed"

# 2. node-shell - Creates a pod with shell access on a node for troubleshooting
# Access nodes directly to check etcd, system resources, and node-level metrics
# Useful for analyzing etcd performance and node-level resource consumption
# Docs: https://github.com/kvaps/kubectl-node-shell
kubectl krew install node-shell || echo "node-shell already installed or failed"

# 3. flame - Generates flame graphs for CPU and memory profiling
# Performance profiling tool to identify CPU and memory hotspots in your workloads
# Essential for understanding resource consumption patterns as scale increases
# Docs: https://github.com/bboreham/kubectl-flame
kubectl krew install flame || echo "flame already installed or failed"

# 4. node-resource - Show node allocations/utilization list or summary
# Shows node resource allocation and actual utilization - displays total pod resource requests per node
# Essential for understanding node resource consumption and identifying over-committed or underutilized capacity
# Docs: https://krew.sigs.k8s.io/plugins/node-resource/
# More info: https://github.com/ahmetb/kubectl-node_resource
kubectl krew install node-resource || echo "node-resource already installed or failed"

# 5. nodepools - List node pools/groups
# Lists node pools/groups within a Kubernetes cluster - shows nodes within node pools
# Useful for managing node pools, supports Karpenter and custom node pool labels
# Docs: https://krew.sigs.k8s.io/plugins/nodepools/
kubectl krew install nodepools || echo "nodepools already installed or failed"

# Additional Resource Footprint & Scalability Plugins (commented for future use)
# Note: For etcd monitoring, you can use etcdctl (not a krew plugin)
# Install etcdctl: brew install etcd (macOS) or apt-get install etcd-client (Linux)
# Then access etcd: kubectl get pods -n kube-system | grep etcd
# Example etcdctl commands (requires etcd pod access):
#   etcdctl endpoint health
#   etcdctl endpoint status --write-out=table
#   etcdctl --endpoints=https://<etcd-ip>:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key endpoint status
# For etcd metrics via API server proxy: kubectl proxy & curl http://localhost:8001/api/v1/namespaces/kube-system/pods/<etcd-pod-name>:2379/proxy/metrics
# 
# kubectl krew install resource-usage        # Shows resource usage metrics (if available) - Docs: https://krew.sigs.k8s.io/plugins/resource-usage/
# Note: events is now in Observability section
# Note: Use 'kubectl top nodes' and 'kubectl top pods' (requires metrics-server) for real-time resource usage
# Note: Use 'kubectl describe nodes' to see node resource capacity and allocation

# ============================================================================
# COST MANAGEMENT PLUGINS (Top 3)
# ============================================================================

echo ""
echo "=== Installing Cost Management Plugins ==="

# 1. cost - Shows cost allocation for Kubernetes resources
# Provides cost allocation and resource usage insights
# Docs: https://github.com/kubecost/kubectl-cost
# Note: You already have this installed
kubectl krew install cost || echo "cost already installed or failed"

# Additional Cost Management Plugins (commented for future use)
# kubectl krew install resource-capacity     # Shows resource usage which helps with cost planning (you already have this)
# kubectl krew install view-allocations      # Shows allocations which helps with cost analysis (already in observability)

# ============================================================================
# UTILITIES & MISC PLUGINS (Top 3)
# ============================================================================

echo ""
echo "=== Installing Utility Plugins ==="

# 1. ca-cert - Prints the PEM CA certificate of the current cluster
# Useful for certificate management and cluster authentication setup
# Docs: https://krew.sigs.k8s.io/plugins/ca-cert/
kubectl krew install ca-cert || echo "ca-cert already installed or failed"

# 2. df-pv - Checks usage of persistent volumes
# Shows persistent volume usage similar to Unix df command
# Essential for storage footprint analysis and capacity planning
# Docs: https://github.com/yashbhutwala/kubectl-df-pv
kubectl krew install df-pv || echo "df-pv already installed or failed"

# 3. oidc-login - Facilitates OIDC authentication to Kubernetes clusters
# Simplifies OIDC authentication workflow for Kubernetes
# Docs: https://github.com/int128/kubelogin
kubectl krew install oidc-login || echo "oidc-login already installed or failed"

# 4. deprecations - Checks for deprecated APIs in your cluster
# Identifies deprecated Kubernetes APIs and helps with cluster upgrade planning
# Essential for maintaining compatibility and planning migrations
# Docs: https://github.com/rikatz/kubepug
kubectl krew install deprecations || echo "deprecations already installed or failed"

# 5. get-all - Lists all resources in a namespace
# Quickly lists all Kubernetes resources in a namespace - useful for inventory and audits
# Docs: https://github.com/corneliusweig/get-all
kubectl krew install get-all || echo "get-all already installed or failed"

# 6. view-secret - Decodes and displays Kubernetes secrets
# Safely views and decodes Kubernetes secrets for debugging and verification
# Docs: https://github.com/elsesiy/kubectl-view-secret
kubectl krew install view-secret || echo "view-secret already installed or failed"

# 7. grep - Filter Kubernetes resources by matching their names
# MUST HAVE: Search/filter resources by name pattern - like grep for kubectl
# Essential for finding resources quickly: kubectl grep pod "my-app"
# Docs: https://krew.sigs.k8s.io/plugins/grep/
kubectl krew install grep || echo "grep already installed or failed"

# 8. count - Count resources by kind
# Useful for quick statistics - count pods, services, deployments, etc.
# Usage: kubectl count pods --all-namespaces
# Docs: https://krew.sigs.k8s.io/plugins/count/
kubectl krew install count || echo "count already installed or failed"

# 9. exec-cronjob - Run a CronJob immediately as Job
# MUST HAVE: Execute CronJobs on-demand without waiting for schedule
# Very useful for testing and debugging CronJobs
# Docs: https://krew.sigs.k8s.io/plugins/exec-cronjob/
kubectl krew install exec-cronjob || echo "exec-cronjob already installed or failed"

# 10. evict-pod - Evicts the given pod
# Safely evict pods from nodes - useful for testing pod disruption budgets
# Docs: https://krew.sigs.k8s.io/plugins/evict-pod/
kubectl krew install evict-pod || echo "evict-pod already installed or failed"

# 11. kuttl - Declaratively run and test operators
# Kubernetes Test Tool (KUTTL) - declarative testing framework for Kubernetes operators
# Essential for testing Kubernetes applications and operators with declarative test cases
# Docs: https://krew.sigs.k8s.io/plugins/kuttl/
# More info: https://github.com/kudobuilder/kuttl
kubectl krew install kuttl || echo "kuttl already installed or failed"

# 12. rook-ceph - Rook plugin for Ceph management
# Manage and troubleshoot Rook Ceph clusters directly through kubectl
# Essential for Ceph storage cluster management, health checks, and maintenance
# Usage: kubectl rook-ceph ceph health detail, kubectl rook-ceph ceph status
# Docs: https://krew.sigs.k8s.io/plugins/rook-ceph/
# More info: https://rook.io/docs/rook/v1.10/Troubleshooting/krew-plugin/
kubectl krew install rook-ceph || echo "rook-ceph already installed or failed"

# Additional Utility Plugins (commented for future use)
# Note: neat is now in Management section
# kubectl krew install eksporter             # Exports resources to YAML/JSON - Docs: https://github.com/micnncim/kubectl-eksporter
# kubectl krew install popeye                # Scans cluster for potential issues - Docs: https://github.com/derailed/popeye

echo ""
echo "=== Installation Complete ==="
echo ""
echo "To see all installed plugins, run: kubectl krew list"
echo "To update plugins, run: kubectl krew update && kubectl krew upgrade"
echo ""
echo "Useful commands:"
echo "  kubectl krew list                    # List installed plugins"
echo "  kubectl krew search <keyword>        # Search for plugins"
echo "  kubectl krew info <plugin-name>      # Get plugin info"
echo "  kubectl krew upgrade                 # Upgrade all plugins"
echo ""

# kpt Project Overview

## What is kpt?

**kpt** (pronounced "kept") is a package-centric toolchain for automating Kubernetes configuration editing. It's a CNCF Sandbox project that helps manage Kubernetes platforms and infrastructure at scale.

### Core Concept: Configuration as Data

kpt follows the "Configuration as Data" philosophy:
- **Configuration is the source of truth** (not live cluster state)
- **Uniform data model** (YAML/KRM format)
- **Separation of concerns** (code that acts on config is separate from the data)
- **Storage abstraction** (works with git, OCI images, etc.)

Think of it like this: Instead of running imperative commands (`kubectl create`, `kubectl edit`), you manipulate YAML files declaratively, and kpt helps you automate that manipulation.

## Why kpt?

kpt enables **WYSIWYG (What You See Is What You Get)** editing of Kubernetes configs with automation. It's like having a smart assistant that can:
- Transform your configs automatically
- Validate them before deployment
- Track what's deployed and prune old resources
- Work with GitOps workflows

## kpt Components

### 1. kpt CLI
The main command-line tool with three key areas:

**Package Operations:**
```bash
kpt pkg get <repo>/<package>  # Fetch a package
kpt pkg update <package>       # Update a package
kpt pkg diff <package>         # See what changed
```

**Function Operations:**
```bash
kpt fn eval <package> --image <function>  # Run a function
kpt fn render <package>                   # Run pipeline of functions
```

**Deployment Operations:**
```bash
kpt live init <package>        # Initialize for deployment
kpt live apply <package>       # Deploy to cluster
kpt live status <package>      # Check deployment status
kpt live destroy <package>     # Remove from cluster
```

### 2. Function SDK
Tools to create your own KRM functions in Go (and other languages). Functions are like plugins that transform or validate YAML configs.

**Example use cases:**
- Set namespace on all resources
- Add labels/annotations
- Validate security policies
- Generate resources from templates
- Custom business logic

### 3. Function Catalog
A library of pre-built, tested functions you can use immediately:
- `set-namespace` - Set namespace on resources
- `set-labels` - Add labels to resources
- `set-annotations` - Add annotations
- `starlark` - Run custom Python-like scripts
- Many more at [catalog.kpt.dev](https://catalog.kpt.dev)

## How kpt Works

### Example Workflow

1. **Get a package** (collection of Kubernetes YAML files):
```bash
kpt pkg get https://github.com/example/nginx-package
```

2. **Customize it** using functions:
```yaml
# Kptfile - defines a pipeline of functions
apiVersion: kpt.dev/v1
kind: Kptfile
metadata:
  name: nginx
pipeline:
  mutators:
    - image: ghcr.io/kptdev/krm-functions-catalog/set-namespace:latest
      configMap:
        namespace: production
    - image: ghcr.io/kptdev/krm-functions-catalog/set-labels:latest
      configMap:
        env: prod
        team: platform
```

3. **Render the package** (apply transformations):
```bash
kpt fn render nginx/
```

4. **Deploy it**:
```bash
kpt live init nginx/
kpt live apply nginx/
```

5. **Track what's deployed**:
```bash
kpt live status nginx/
```

## Key Features

### 1. Package Management
- Fetch packages from git or OCI registries
- Update packages while preserving local changes
- Version control and dependency management

### 2. Function Pipeline
- Chain multiple functions together
- Declarative transformation pipeline
- Reusable, composable functions

### 3. Live Apply
- Tracks deployed resources (inventory)
- Prunes deleted resources automatically
- Shows aggregated status
- Better preview of changes

### 4. GitOps Ready
- Works with any GitOps tool (Flux, ArgoCD, etc.)
- Config stored in git
- Automated rendering in CI/CD

## Real-World Use Cases

### 1. Multi-Environment Deployment
Use the same base package, customize per environment:
```
base-app/
├── dev/     (set-namespace: dev, replicas: 1)
├── staging/ (set-namespace: staging, replicas: 2)
└── prod/    (set-namespace: prod, replicas: 5)
```

### 2. Policy Enforcement
Run validation functions to ensure:
- All resources have required labels
- Security policies are met
- Resource limits are set
- Naming conventions followed

### 3. Config Generation
Generate repetitive configs:
- Create namespaces for multiple teams
- Generate RBAC rules
- Create monitoring configs

### 4. Platform Engineering
Build internal platforms:
- Standardized app templates
- Automated compliance checks
- Self-service for developers

## kpt vs Alternatives

| Tool | Approach | kpt Difference |
|------|----------|----------------|
| **Helm** | Templating | kpt uses functions (more flexible), no template syntax |
| **Kustomize** | Overlays | kpt includes kustomize + functions + deployment tracking |
| **kubectl** | Imperative | kpt is declarative, tracks inventory |
| **Terraform** | Infrastructure | kpt focuses on Kubernetes configs, lighter weight |

## Project Status

- **CNCF Sandbox Project** (official Kubernetes ecosystem project)
- **Active development** by Google and community
- **Production-ready** (used by many organizations)
- **Open source** (Apache 2.0 license)

## Community

- **Slack**: #kpt channel on Kubernetes Slack
- **GitHub**: https://github.com/kptdev/kpt
- **Docs**: https://kpt.dev
- **Function Catalog**: https://catalog.kpt.dev
- **Community meetings**: Weekly on Zoom

## Your Work on kpt

You've been contributing to kpt as part of a mentorship program! Your contributions include:

### Completed PRs:
1. ✅ **PR #4392** - Fixed README installation link
2. ✅ **PR #4401** - Improved tenant onboarding docs
3. ✅ **PR #4405** - Added auto-create directory for `pkg init`
4. 🔄 **PR #1220** - Added copyright headers to krm-functions-catalog
5. 🔄 **PR #4391** - Added CEL-based conditional function execution (HARD issue!)

### Current Work:
- **Issue #4297** - Updating E2E tests to use latest function versions
  - This helps catch breaking changes early
  - Improves test reliability
  - Ensures functions work with current versions

### Why This Matters:

**E2E Tests** are critical because:
- They test the entire workflow (not just unit tests)
- They use real Docker containers with actual functions
- They catch integration issues
- They verify the user experience works

**Using `:latest` versions** is important because:
- Old pinned versions (v0.2.0 from years ago) don't reflect reality
- Tests should catch breaking changes in functions
- Users will use latest versions, tests should too
- Helps function developers know if they break things

## Technical Architecture

### KRM (Kubernetes Resource Model)
kpt works with KRM - a standard format for Kubernetes resources:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  namespace: default
spec:
  replicas: 3
```

### Functions
Functions are containers that:
- **Input**: List of KRM resources (YAML)
- **Process**: Transform or validate
- **Output**: Modified list of KRM resources (YAML)

They follow a standard interface, so any function works with any tool.

### Kptfile
The `Kptfile` is like a `package.json` or `Makefile` for configs:
```yaml
apiVersion: kpt.dev/v1
kind: Kptfile
metadata:
  name: my-app
info:
  description: My application package
pipeline:
  mutators:
    - image: set-namespace:latest
      configMap:
        namespace: prod
  validators:
    - image: kubeval:latest
```

## Learning Resources

1. **Official Docs**: https://kpt.dev/book/
2. **Function Catalog**: https://catalog.kpt.dev
3. **Examples**: https://github.com/kptdev/kpt/tree/main/package-examples
4. **Videos**: Search "kpt kubernetes" on YouTube

## Summary

kpt is a powerful tool for managing Kubernetes configurations at scale. It treats configuration as data, uses functions for automation, and provides deployment tracking. Your work on updating E2E tests helps ensure the quality and reliability of this critical infrastructure tool used by many organizations!

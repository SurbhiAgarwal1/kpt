Hi @CsatariGergely,

Is this issue still relevant? I'd like to work on it.

I see you referenced the krm-functions-sdk. From what I understand, you're looking for a CLI tool that can:
1. Scaffold a new KRM function project (similar to `kpt fn init` but with Docker support)
2. Generate Dockerfiles for Go-based KRM functions
3. Build and tag Docker images for functions in the catalog

The SDK provides the framework, but there's no convenient command to handle the Docker build workflow. Would something like this work?

```bash
kpt fn docker init <function-name>  # Creates function scaffold with Dockerfile
kpt fn docker build                  # Builds Docker image
kpt fn docker push                   # Pushes to registry
```

Or would you prefer a standalone tool? Let me know the specific workflow you'd like to improve and I can work on it.

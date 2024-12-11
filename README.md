# Kubernetes Auto Reloader

This repository demonstrates the **auto-reloading of dynamic applications** (such as Flask or FastAPI apps) deployed on Kubernetes. It leverages **git-sync** to synchronize application code from a remote Git repository and automatically reload the application whenever updates are detected.

## How It Works
1. **Persistent Volume**:
   - A persistent volume is shared between containers to store the application code.

2. **git-sync**:
   - The git-sync container keeps the codebase in sync with the specified Git repository.

3. **Custom Bash Script**:
   - A script monitors changes in the synchronized directory and reloads the application when updates occur.

This approach is applicable to any dynamic application that supports live reloading, making it ideal for setups that require frequent updates directly from a Git repository.

## Features
- **Automatic Synchronization**: Keeps your application code up-to-date with the remote repository.
- **Automatic Reloading**: Reloads the application on code changes without manual intervention.
- **Customizability**: Configurable for different types of applications and use cases.

## Limitations
- **Single Replica Only**: The current implementation is designed for single-replica deployments. In multi-replica setups, the behavior may be inconsistent or unreliable.
- **Not Production Ready**: While suitable for development or proof-of-concept use cases, this implementation may not be ideal for production environments due to potential flakiness in multi-replica deployments.

## Getting Started
To deploy the auto-reloading setup on Kubernetes:
1. Clone this repository.
2. Customize the deployment YAML files to fit your application's needs.
3. Deploy the application to your Kubernetes cluster.

## Advanced Configuration
For advanced options and configurations, refer to the official **git-sync** documentation:
[https://github.com/kubernetes/git-sync](https://github.com/kubernetes/git-sync)

---

### Why This Setup?
This implementation simplifies the development workflow by reducing the need for manual redeployments when updating the application code. It ensures the application stays synchronized with the latest code changes in the remote repository, enabling faster iteration and testing cycles.

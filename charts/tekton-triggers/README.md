# Tekton triggers

The Helm chart was created from the [v0.16.0 manifest](https://storage.googleapis.com/tekton-releases/triggers/previous/v0.16.0/release.yaml).

## Upgrading

When upgrading, download the manifests from the [official GitHub repo](https://github.com/tektoncd/triggers/releases) and replace the old manifests in `templates` and `crds`. You should separate the CRDs from all other resources to avoid installation problems.

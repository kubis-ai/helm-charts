# argocd-vault-plugin

The Helm chart was created from the Kustomize [v1.3.1 manifest](https://github.com/IBM/argocd-vault-plugin/tree/v1.3.1/manifests). The manifest was not edited in any way.

## Upgrading

When upgrading, use `kustomize build . > manifests.yaml` to generate the manifest and replace the old manifest in `templates` with the new one.

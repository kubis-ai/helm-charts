#  kube2iam

The Helm chart was created based on the [v2.6.0 Kustomize base](github.com/jtblin/kube2iam/kustomize/base?ref=kube2iam-2.6.0). The manifest was obtained from a custom Kustomize module using `kustomize build . > manifest.yaml`. Note that this module included additional resources and patches.

## Upgrading
When upgrading, just replace the reference to the Kustomization base in the custom Kustomize module. Then generate the new manifest file and replace the old file in `templates`.
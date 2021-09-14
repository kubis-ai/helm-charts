#  EFS driver

The Helm chart was created from the [v1.2 Kustomize overlay](github.com/kubernetes-sigs/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/ecr?ref=release-1.2). The manifest was first generated using `kustomize build . > manifest.yaml`. The manifest was then editted to include two parameters:
* IAM role ARN
* AWS region: used to select the right container image

## Upgrading
When upgrading, replace the old manifest in `templates` with the new one and edit it to include the two parameters above.
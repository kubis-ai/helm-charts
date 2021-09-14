#  kube2iam

The Helm chart was created based on the [v2.2.0 manifest](https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml). The `templates/manifests.yaml` was obtained from a custom Kustomize module using `kustomize build . > manifests.yaml`. The main difference between the official release and this one is the added configuration to enable access to the service using AWS application load balancer. For this purpose the following parameters were added:
* Node Port
* Target group ARN

## Upgrading
When upgrading:
* Replace the base reference in the custom Kustomize kubernetes-dashboard module;
* Run `kustomize build . > manifests.yaml` to obtain the resulting manifests;
* Copy this file to `templates` in the Helm chart;
* Edit `manifests.yaml` to account for the parameters added.
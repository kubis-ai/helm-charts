# Kubeflow Pipelines
> The comments below refer to Kubeflow Pipelines version 1.5.0!

The Helm chart for AWS was developed based on the corresponding [Helm chart for GCP](https://github.com/kubeflow/pipelines/tree/master/manifests/gcp_marketplace/chart/kubeflow-pipelines?ref=1.5.0) supported by the project. We use the same repository images in sync with the official KubeFlow Pipelines release. The images used are controlled by the parameter `pipelinesVersion`.

Two components need permission to access the artifact store: minio and ml-pipeline.

## Third-party components

### minIO
The minIO server image officially supported by Kubeflow Pipelines is much older than the latest image available. minIO can be deployed in two different ways:

* mounted volume: objects are stored in a Volume when `managedArtifactStore.enabled = false`. Ee use a local Persistent Volume which means that all data is lost when the container is detroyed. Other Persistent Volume types could be provisioned but were not tested. References: [[1]](https://docs.min.io/docs/minio-docker-quickstart-guide.html, https://kubernetes.io/docs/concepts/storage/persistent-volumes/#types-of-persistent-volumes).

* S3 bucket: objects are stored in an S3 bucket provisioned by AWS when `managedArtifactStore.enabled = true`. minIO acts as a gateway for S3. This setup requires that minIO image is called with the arguments `gateway` and `s3`. This is in distinction from the official [Kustomize manifests for AWS using s3 and minIO](https://github.com/kubeflow/pipelines/tree/master/manifests/kustomize/env/aws?ref=1.5.0) where the arguments used are `server` and the vertigial `/data` volume mount. Reference: [[1]](https://docs.min.io/docs/minio-gateway-for-s3.html)

### Argo Workflows
Argo Workflows can either communicate directly with S3 buckets or using minIO as a gateway. The current implementation uses minIO as a gateway but this can be changed in `workflow-controller-configmap` under `artifactRepository` settings. When argo is deployed in a single namespace (using the container argument `namespaced`) the logs will show the warning `Controller doesn't have RBAC access for ClusterWorkflowTemplates`. This warning is expected because argo does not run with clusterrole. Reference: [[1]](https://github.com/argoproj/argo-workflows/tree/master/manifests).

### MySQL
MySQL can be deployed either directly using a container image and a volume or using RDS managed service.

* mounted volume: when `managedArtifactStore.enabled = false` the server is created using a MySQL container image and uses the local Persistent Volume to store data. This means all data is lost after the container is destroyed. This should only be used for tests. As with non-managed minIO, other types of Persisten Volumes could be used but were not tested.

* RDS database: uses an RDS instance when `managedArtifactStore.enabled = true`.

## Pipeline components

### ml-pipeline-ui

* `DEPLOYMENT`: argument that changes how the UI is rendered (whether the sidebar is shown or whether an initial page with links to GCP is present). It has three options: `MARKETPLACE`, `KUBEFLOW` and `UNDEFINED`. For a standalone Pipelines deployment, not setting this variable is the best choice (which defaults to `UNDEFINED`). All configurable variables are found [here](https://github.com/kubeflow/pipelines/blob/d9c019641ef9ebd78db60cdb78ea29b0d9933008/frontend/server/configs.ts?ref=1.5.0).

## Addons

### Exposing services

We use an application load balancer to access services created by Kubeflow Pipelines from outside the cluster. It is assumed that:
* [AWS Load Balancer Controller](https://github.com/kubernetes-sigs/aws-load-balancer-controller) is installed;
* The load balancer, listeners, target groups and security groups have been deployed outside Kubenetes using a tool such as Terraform. 

For each service that needs to be exposed we should configure a TargetGroupBinding. This essentially tells the load balancer controller to associate a target group with a service. The target group ARN and node port should be configured and passed as configuration arguments.

Important! When using AWS Load Balancer controller do not define Ingress resources. This causes the controller to create a load balancer and associated resources which will be managed outside of Terraform or other such tool. When Terraform does not manage the load balancer, it becomes difficult to associate DNS names to the load balancer programatically.




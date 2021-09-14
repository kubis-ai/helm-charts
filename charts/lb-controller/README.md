# AWS load balancer controller

The Helm chart was created from the [v2.1.2 manifest](https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.1.2/docs/install/v2_1_2_full.yaml). The manifest was changed to include two parameters:
* IAM role annotation
* Cluster name

## Upgrading
When upgrading, replace the old manifest in `templates` and edit it to include the two parameters mentioned above.
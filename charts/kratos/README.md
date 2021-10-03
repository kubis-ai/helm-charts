# Kratos

The Helm chart was created based on the latest version of the official [Kratos helm chart](https://github.com/ory/k8s/tree/master/helm/charts/kratos).

## Upgrading

A single change was made: adding a cert-manager issuer in `templates/issuer.yaml`. When upgrading the chart, only the file with the issuer needs to be added.

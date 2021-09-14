# Jupyter

This is a custom Helm chart that deploys Jupyter.

## Container images

The [jupyter/docker-stacks repo](https://github.com/jupyter/docker-stacks) provides a set of [pre-built container images](https://hub.docker.com/u/jupyter) and their Dockerfiles. These images can be used directly. If startup hooks are to be used, however, it is necessary to build a custom container in order to copy the scripts to the container.

## Exposing the service

The Jupyter service can be exposed by setting `service.isExposed = true`. The `nodePort` should match the port defined in the target group `targetGroupARN`. The target group is created by the load balancer using Terraform and the Kubernetes Service is associated with the target group by the AWS Load balancer controller.

## File system

The Elastic File System (EFS) was chosen as volume mount. The manifest mounts the file system at `elasticFileSystem.mountPath`. The `elasticFileSystem.id` is used by the Amazon EFS CSI driver to mount the volume. Mounting the EFS causes some file permission issues. For more information read [[1]](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html#docker-options). The option `chownHome` was set to solve this problem.

## Startup hooks

We can customize the notebook container by supplying startup hooks. These are scripts or executables that must be located in either of these folders: `/usr/local/bin/start-notebook.d/` and `/usr/local/bin/before-notebook.d/`. These hook files must be copied to the container at container building. `container/Dockerfile` has been set up to create the custom container. To help we already provide two empty scripts: `container/start-notebook.sh` and `container/before-notebook.sh` to be filled in with custom code. Reference: [[1]](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html#startup-hooks)
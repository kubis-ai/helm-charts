# Modified from: https://github.com/jupyter/docker-stacks/blob/master/tensorflow-notebook/Dockerfile 
ARG BASE_CONTAINER=jupyter/scipy-notebook
FROM $BASE_CONTAINER

# Install Tensorflow
RUN mamba install --quiet --yes \
    'tensorflow=2.4.1' && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Copy startup hook scripts
COPY start-notebook.sh /usr/local/bin/start-notebook.d/
COPY before-notebook.sh /usr/local/bin/before-notebook.d/
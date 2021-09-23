# Jupyter container used for Galaxy IPython (+other kernels) Integration

# from 5th March 2021
FROM jupyter/datascience-notebook:d990a62010ae

MAINTAINER Björn A. Grüning, bjoern.gruening@gmail.com

ENV DEBIAN_FRONTEND noninteractive

# Python packages
RUN conda config --add channels conda-forge && \
    conda config --add channels bioconda && \
    conda install --yes --quiet \
    biopython \
    rpy2 \
    bash_kernel \
    ansible-kernel \
    bioblend galaxy-ie-helpers \
    jupytext \
    cython patsy statsmodels cloudpickle dill r-xml && conda clean -yt && \
    pip install jupyterlab_hdf
    pip install papermill

# ENV variables to replace conf file
ENV DEBUG=false \
    GALAXY_WEB_PORT=10000 \
    NOTEBOOK_PASSWORD=none \
    CORS_ORIGIN=none \
    DOCKER_PORT=none \
    API_KEY=none \
    HISTORY_ID=none \
    REMOTE_HOST=none \
    GALAXY_URL=none

RUN papermill NotebookTest.ipynb NotebookTestOut.ipynb


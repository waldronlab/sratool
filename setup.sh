#!/bin/sh

biocIMG=bioconductor/bioconductor_docker:devel

docker pull $biocIMG

DOCKER_RPKGS="$HOME/.docker-devel-packages"
R_LIBS='/usr/local/lib/R/host-site-library:/usr/local/lib/R/site-library:/usr/local/lib/R/library'

mkdir -p "$DOCKER_RPKGS"

echo "Installed packages will go in host directory: $DOCKER_RPKGS"
# echo "RStudio home directory will be mounted on host directory: $DOCKER_HOME"

docker image build -t waldronlab/sratool:latest .

docker run -ti --user rstudio \
    -v $DOCKER_RPKGS:/usr/local/lib/R/host-site-library \
    -w /home/rstudio \
    waldronlab/sratool:latest bash


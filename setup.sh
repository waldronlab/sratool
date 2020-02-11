#!/bin/sh

biocIMG=bioconductor/bioconductor_docker:devel

docker pull $biocIMG

DOCKER_RPKGS="$HOME/.docker-devel-packages"
DOCKER_HOME="$HOME/dockerhome"
R_LIBS='/usr/local/lib/R/host-site-library:/usr/local/lib/R/site-library:/usr/local/lib/R/library'

mkdir -p "$DOCKER_RPKGS"
mkdir -p "$DOCKER_HOME"

if [ ! -f "$DOCKER_HOME"/.Renviron ]; then
    echo "R_LIBS=$R_LIBS" > $DOCKER_HOME/.Renviron
fi

TOKEN_EXP='^GITHUB_[P|T].*'

GPAT=`grep "$TOKEN_EXP" ~/.Renviron`
GRENV=`grep "$TOKEN_EXP" $DOCKER_HOME/.Renviron`

if [ ! -z "${GPAT// }" ] && [ -z "${GRENV// }" ]; then
    echo $GPAT >> $DOCKER_HOME/.Renviron
fi

echo "Installed packages will go in host directory: $DOCKER_RPKGS"
# echo "RStudio home directory will be mounted on host directory: $DOCKER_HOME"

docker image build -t waldronlab/sratool:latest .

docker run -ti --user rstudio \
    -v $DOCKER_HOME:/home/rstudio \
    -v $DOCKER_RPKGS:/usr/local/lib/R/host-site-library \
    -w /home/rstudio \
    waldronlab/sratool:latest bash


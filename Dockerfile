# inherit from bioconductor_docker:devel
FROM bioconductor/bioconductor_docker:devel

LABEL name="waldronlab/sratool" \
      version="0.99.1" \
      url="https://github.com/waldronlab/sratool" \
      vendor="Waldron Lab" \
      maintainer="marcel.ramos@sph.cuny.edu" \
      description="SRAtool for downloading and processing data on the cloud" \
      license="Artistic-2.0"

ENV USER rstudio
ENV HOME /home/rstudio

VOLUME $HOME/github
VOLUME $HOME/src
VOLUME $HOME/ncbi/public

ADD install.R /tmp/

RUN cd $HOME/github \
    && R -f /tmp/install.R

# RUN cd $HOME/github \
#     git clone https://github.com/waldronlab/SingleCellMultiModal
#
# RUN cd $HOME/src \
#     && wget "http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.10.2/sratoolkit.2.10.2-ubuntu64.tar.gz" \
#     && tar -xzf sratoolkit.2.10.2-ubuntu64.tar.gz


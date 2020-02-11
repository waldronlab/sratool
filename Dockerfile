# inherit from bioconductor_docker:devel
FROM bioconductor/bioconductor_docker:devel

LABEL name="waldronlab/sratool" \
      version="0.99.1" \
      url="https://github.com/waldronlab/sratool" \
      vendor="Waldron Lab" \
      maintainer="marcel.ramos@sph.cuny.edu" \
      description="SRAtool for downloading and processing data on the cloud" \
      license="Artistic-2.0"

RUN mkdir -p $HOME/ncbi/public $HOME/src \
    && cd $HOME/src \
    && wget "http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.10.2/sratoolkit.2.10.2-ubuntu64.tar.gz" \
    && tar -xzf sratoolkit.2.10.2-ubuntu64.tar.gz


FROM mambaorg/micromamba:2.0.5
LABEL org.opencontainers.image.title="Professional viral metagenomics pipeline" \
      org.opencontainers.image.version="2.0.0" \
      org.opencontainers.image.authors="Georges Christian Mbock Mbock"
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /tmp/environment.yml
RUN micromamba install --yes --name base --file /tmp/environment.yml && micromamba clean --all --yes
WORKDIR /pipeline
COPY --chown=$MAMBA_USER:$MAMBA_USER . /pipeline
ENTRYPOINT ["/usr/local/bin/_entrypoint.sh"]
CMD ["snakemake", "--snakefile", "workflow/Snakefile", "--cores", "4", "--resources", "mem_mb=7000", "--printshellcmds", "--rerun-incomplete"]

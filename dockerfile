# Layer Basis
FROM python:3.10

# Metadata
LABEL version="1.0" maintainer="Georges MBOCK M <georgesmbo89@gmail.com>"

# Tempory variable
ARG APT_FLAGS="-y"

# Update and installing basis tools
RUN apt-get update && apt-get install ${APT_FLAGS} \
    wget \
    curl \
    git \
    && apt-get clean

# Installing necessary Python packages 
RUN pip install \
    jupyter \
    numpy \
    pandas \
    matplotlib \
    seaborn \
    biopython

# Launch Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]

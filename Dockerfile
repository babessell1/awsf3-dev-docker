FROM ubuntu:20.04

# general updates & installing necessary Linux components
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN apt update -y && apt upgrade -y &&  apt install -y \
    apt-transport-https \
    bzip2 \
    ca-certificates \
    cron \
    curl \
    fuse \
    git \
    less \
    locales \
    make \
    python3.8 \
    python3-pip \
    python3.8-dev \
    time \
    unzip \
    vim \
    wget \
    software-properties-common \
    libssl-dev \
    libwww-perl \
    libdatetime-perl \
    uuid-dev \
    libgpgme11-dev \
    squashfs-tools \
    libseccomp-dev \
    pkg-config \
    openjdk-8-jre-headless \
    nodejs \
    gnupg \
    lsb-release

RUN apt-get update \
    && apt-get install -y curl python3.8 python3.8-dev python3-pip

WORKDIR /usr/local/bin

# install docker inside docker
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update
RUN apt-get --assume-yes install docker-ce

# Singularity
RUN ARCH="$(dpkg --print-architecture)" && \
    SINGULARITY_VERSION=3.10.4 && \
    wget https://tibanna-dependencies.s3.amazonaws.com/singularity/singularity-ce_${SINGULARITY_VERSION}-focal_${ARCH}.deb && \
    apt install -y ./singularity-ce_${SINGULARITY_VERSION}-focal_${ARCH}.deb && \
    rm singularity-ce_${SINGULARITY_VERSION}-focal_${ARCH}.deb

# goofys
# RUN wget https://github.com/kahing/goofys/releases/download/v0.24.0/goofys && chmod +x goofys
RUN ARCH="$(dpkg --print-architecture)" && \
    wget https://tibanna-dependencies.s3.amazonaws.com/goofys/v0.24.0/${ARCH}/goofys && chmod +x goofys

# python packages
RUN pip install boto3==1.15 awscli==1.18.152 botocore==1.18.11
RUN pip install psutil==5.7.3
RUN pip install cwltool==3.1.20211103193132
RUN pip install ec2metadata==2.0.1

# cromwell for WDL 1.0
RUN wget https://github.com/broadinstitute/cromwell/releases/download/53.1/cromwell-53.1.jar && \
    ln -s cromwell-53.1.jar cromwell.jar
# Old cromwell for WDL draft-2
RUN wget https://github.com/broadinstitute/cromwell/releases/download/35/cromwell-35.jar
RUN wget https://github.com/broadinstitute/cromwell/blob/develop/LICENSE.txt  # cromwell license

# Caper - uses cromwell 59 under the hood
#RUN pip install PyYAML==5.3.1
#RUN pip install docker==4.*
#RUN pip install caper==1.6.3
#RUN pip install PyYAML==5.3.1

RUN pip install \
    argcomplete==1.12.3 \
    attrs==23.1.0 \
    autouri==0.4.4 \
    awscli==1.27.146 \
    backports.zoneinfo==0.2.1 \
    bagit==1.8.1 \
    boto3==1.26.146 \
    botocore==1.29.146 \
    build==0.10.0 \
    bullet==2.2.0 \
    CacheControl==0.12.11 \
    cachetools==5.3.1 \
    caper==1.6.3 \
    certifi==2023.5.7 \
    cffi==1.15.1 \
    charset-normalizer==3.1.0 \
    cleo==2.0.1 \
    colorama==0.4.3 \
    coloredlogs==15.0.1 \
    contourpy==1.0.7 \
    crashtest==0.4.1 \
    cryptography==41.0.1 \
    cwltool==3.1.20211103193132 \
    cycler==0.11.0 \
    dateparser==1.1.8 \
    distlib==0.3.6 \
    docker==6.1.3 \
    docutils==0.15.2 \
    dulwich==0.21.5 \
    ec2metadata==2.0.1 \
    filelock==3.12.0 \
    fonttools==4.39.4 \
    google-api-core==2.11.0 \
    google-auth==2.19.1 \
    google-cloud-core==2.3.2 \
    google-cloud-storage==2.9.0 \
    google-crc32c==1.5.0 \
    google-resumable-media==2.5.0 \
    googleapis-common-protos==1.59.0 \
    html5lib==1.1 \
    humanfriendly==10.0 \
    idna==3.4 \
    importlib-metadata==6.6.0 \
    importlib-resources==5.12.0 \
    installer==0.7.0 \
    isodate==0.6.1 \
    jaraco.classes==3.2.3 \
    jeepney==0.8.0 \
    jmespath==0.10.0 \
    joblib==1.2.0 \
    jsonschema==4.17.3 \
    keyring==23.13.1 \
    kiwisolver==1.4.4 \
    lark==1.1.5 \
    lockfile==0.12.2 \
    lxml==4.9.2 \
    matplotlib==3.7.1 \
    miniwdl==1.10.0 \
    mistune==2.0.5 \
    more-itertools==9.1.0 \
    msgpack==1.0.5 \
    mypy-extensions==1.0.0 \
    networkx==3.1 \
    ntplib==0.4.0 \
    numpy==1.24.3 \
    packaging==23.1 \
    pandas==2.0.2 \
    pexpect==4.8.0 \
    Pillow==9.5.0 \
    pip==23.1.2 \
    pkginfo==1.9.6 \
    pkgutil_resolve_name==1.3.10 \
    platformdirs==3.5.1 \
    poetry==1.5.1 \
    poetry-core==1.6.1 \
    poetry-plugin-export==1.4.0 \
    protobuf==4.23.2 \
    prov==1.5.1 \
    psutil==5.7.3 \
    ptyprocess==0.7.0 \
    pyasn1==0.5.0 \
    pyasn1-modules==0.3.0 \
    pycparser==2.21 \
    pydot==1.4.2 \
    pygtail==0.14.0 \
    pyhocon==0.3.60 \
    pyOpenSSL==23.2.0 \
    pyparsing==3.0.9 \
    pyproject_hooks==1.0.0 \
    pyrsistent==0.19.3 \
    python-dateutil==2.8.2 \
    python-json-logger==2.0.7 \
    pytz==2023.3 \
    PyYAML==5.4.1 \
    rapidfuzz==2.15.1 \
    rdflib==6.0.2 \
    regex==2023.5.5 \
    requests==2.31.0 \
    requests-toolbelt==1.0.0 \
    rsa==4.5 \
    ruamel.yaml==0.17.16 \
    ruamel.yaml.clib==0.2.7 \
    s3transfer==0.6.1 \
    schema-salad==8.4.20230601112322 \
    scikit-learn==1.2.2 \
    scipy==1.10.1 \
    SecretStorage==3.3.3 \
    setuptools==67.7.2 \
    shellescape==3.8.1 \
    shellingham==1.5.0.post1 \
    six==1.16.0 \
    threadpoolctl==3.1.0 \
    tomli==2.0.1 \
    tomlkit==0.11.8 \
    trove-classifiers==2023.5.24 \
    typing_extensions==4.6.3 \
    tzdata==2023.3 \
    tzlocal==5.0.1 \
    urllib3==1.26.16 \
    virtualenv==20.23.0 \
    webencodings==0.5.1 \
    websocket-client==1.5.2 \
    wheel==0.40.0 \
    xdg==6.0.0 \
    zipp==3.15.0

# awsf scripts
COPY run.sh .
COPY cron.sh .
RUN chmod +x run.sh cron.sh
ARG version
#RUN pip install tibanna==$version
RUN curl -sSL https://install.python-poetry.org | python3.8 -
RUN git clone https://github.com/babessell1/tibanna.git
RUN cd tibanna && /root/.local/bin/poetry install
ENV PATH="/root/.venv/bin:$PATH"
RUN echo $(ls -a /root/.venv)
RUN echo $(ls -a /root/.venv/bin)

# Move default docker daemon location to mounted EBS
COPY daemon.json /etc/docker/daemon.json

# supporting UTF-8
RUN locale-gen "en_US.UTF-8" && update-locale LC_ALL="en_US.UTF-8"
ENV LC_ALL=en_US.UTF-8

CMD ["bash"]

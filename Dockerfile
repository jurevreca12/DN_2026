FROM ubuntu:22.04

LABEL description="Anvil and F4PGA Artix-7 FPGA development environment"

ENV DEBIAN_FRONTEND=noninteractive

# --------------------------------------------------
# 1. Install basic system dependencies
# --------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    ca-certificates \
    curl \
    wget \
    git \
    unzip \
    xz-utils \
    tar \
    gzip \
    sed \
    python3 \
    python3-pip \
    python3-venv \
    build-essential \
    gcc \
    g++ \
    make \
    cmake \
    pkg-config \
    flex \
    bison \
    libssl-dev \
    libelf-dev \
    bc \
    pahole \
    libusb-1.0-0-dev \
    libudev-dev \
    libftdi1-dev \
    libhidapi-dev \
    zlib1g-dev \
    iverilog \
    gtkwave \
    && rm -rf /var/lib/apt/lists/*

# --------------------------------------------------
# 2. Create a non-root user
#
# The supplied installer explicitly refuses to run
# as root and uses sudo for system dependencies.
# --------------------------------------------------
RUN useradd --create-home --shell /bin/bash developer \
    && echo 'developer ALL=(ALL) NOPASSWD:ALL' \
       > /etc/sudoers.d/developer \
    && chmod 0440 /etc/sudoers.d/developer

ENV HOME=/home/developer

USER developer

WORKDIR /home/developer

# --------------------------------------------------
# 3. Copy the existing installer
# --------------------------------------------------
COPY --chown=developer:developer install.sh /home/developer/install.sh

RUN chmod +x /home/developer/install.sh

# --------------------------------------------------
# 4. Install the FPGA toolchain
#
# --minimal:
#   Skip RISC-V, board programmer and simulation tools.
#
# --no-test:
#   Skip the final integration test, which would build
#   FPGA projects during the Docker image build.
# --------------------------------------------------

# Use the classic solver for the legacy Conda environment.
# The supplied installer installs Miniconda during execution,
# so patch the environment-creation command before running it.
RUN sed -i \
    's/conda env create -f "\$envyml"/conda env create --solver=classic -f "\$envyml"/' \
    /home/developer/install.sh \
    && /home/developer/install.sh --minimal --no-test

# --------------------------------------------------
# 5. Configure the interactive shell
# --------------------------------------------------
ENV PATH="/home/developer/.local/bin:/home/developer/opt/sv2v:/home/developer/miniconda3/bin:/home/developer/miniconda3/envs/xc7/bin/:${PATH}"

SHELL ["/bin/bash", "-c"]

# Start in the developer's home directory.
WORKDIR /home/developer

CMD ["/bin/bash"]


UID := $(shell id -u)
GID := $(shell id -g)

OS   := $(shell uname -s)
ARCH := $(shell uname -m)

# The F4PGA/Conda toolchain is x86-64 only. On Apple Silicon (arm64) run the
# image under emulation (Rosetta/QEMU in Docker Desktop).
ifeq ($(OS)-$(ARCH),Darwin-arm64)
PLATFORM := --platform linux/amd64
else
PLATFORM :=
endif

# Docker Desktop on macOS runs in a VM: /dev of the Mac cannot be mounted, so
# USB programmers are not available inside the container there.
ifeq ($(OS),Darwin)
DEV_MOUNT :=
else
DEV_MOUNT := -v /dev:/dev
endif

docker-build:
	docker build $(PLATFORM) -t anvil:latest .

docker-run:
	docker run -it $(PLATFORM) $(DEV_MOUNT) -v $(CURDIR):/home/designer -w /home/designer anvil:latest bash

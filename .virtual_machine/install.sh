#!/usr/bin/env bash

# -------------------------------
# Defaults (can be overridden via flags or env)
# -------------------------------
: "${DEBIAN_FRONTEND:=noninteractive}"
: "${LANG:=en_US.UTF-8}"
: "${LANGUAGE:=en_US:en}"
: "${LC_ALL:=en_US.UTF-8}"
: "${INSTALL_DIR:=/opt/4C-dependencies}"
: "${FOUR_C_TESTING_DEPENDENCIES_DIR:=/opt/4C-dependencies-testing}"
: "${NPROCS:=$(command -v nproc >/dev/null 2>&1 && nproc || echo 8)}"
: "${OMPI_MCA_btl_vader_single_copy_mechanism:=none}"

DEPENDENCIES_PATH=""

# -------------------------------
# Helpers
# -------------------------------
log() { printf "\n\033[1;32m[4C setup]\033[0m %s\n" "$*"; }
err() { printf "\n\033[1;31m[4C setup ERROR]\033[0m %s\n" "$*" >&2; }
need_root() {
  if [[ "$(id -u)" -ne 0 ]]; then
    err "Please run as root (use sudo)."
    exit 1
  fi
}

usage() {
  cat <<EOF
Usage: sudo $0 --dependencies-path /path/to/dependencies [options]

Required:
  --dependencies-path PATH   Path to the 'dependencies' directory (the one with current/{cmake,superlu_dist,...})

Options:
  --install-dir PATH         Install prefix for core dependencies (default: ${INSTALL_DIR})
  --testing-dir PATH         Install prefix for testing deps (default: ${FOUR_C_TESTING_DEPENDENCIES_DIR})
  --nprocs N                 Parallel build jobs (default: ${NPROCS})
  -h, --help                 Show this help and exit

Environment variables honored:
  DEBIAN_FRONTEND, LANG, LANGUAGE, LC_ALL, INSTALL_DIR, FOUR_C_TESTING_DEPENDENCIES_DIR, NPROCS,
  OMPI_MCA_btl_vader_single_copy_mechanism, DEPENDENCIES_HASH
EOF
}

# -------------------------------
# Parse args
# -------------------------------
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dependencies-path) DEPENDENCIES_PATH="$2"; shift 2;;
    --install-dir) INSTALL_DIR="$2"; shift 2;;
    --testing-dir) FOUR_C_TESTING_DEPENDENCIES_DIR="$2"; shift 2;;
    --nprocs) NPROCS="$2"; shift 2;;
    -h|--help) usage; exit 0;;
    *) err "Unknown argument: $1"; usage; exit 2;;
  esac
done

if [[ -z "$DEPENDENCIES_PATH" ]]; then
  err "You must provide --dependencies-path pointing to your 'dependencies' directory."
  usage
  exit 2
fi
if [[ ! -d "$DEPENDENCIES_PATH/current" ]]; then
  err "Missing expected structure under $DEPENDENCIES_PATH (need 'current/...' subdirs)."
  exit 2
fi

log "Environment summary"
echo "  LANG=${LANG}"
echo "  LC_ALL=${LC_ALL}"
echo "  INSTALL_DIR=${INSTALL_DIR}"
echo "  FOUR_C_TESTING_DEPENDENCIES_DIR=${FOUR_C_TESTING_DEPENDENCIES_DIR}"
echo "  NPROCS=${NPROCS}"
echo "  DEPENDENCIES_PATH=${DEPENDENCIES_PATH}"

# -------------------------------
# Apt prep & locale
# -------------------------------
log "Setting locale to en_US.UTF-8 and preparing apt"
export DEBIAN_FRONTEND LANG LANGUAGE LC_ALL
apt-get update
apt-get install -y --no-install-recommends locales ca-certificates tzdata
localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 || true
locale-gen en_US.UTF-8 || true
update-locale LANG="${LANG}" LC_ALL="${LC_ALL}"

# -------------------------------
# Core packages 
# -------------------------------
log "Installing base development packages"
sudo apt-get install -y --no-install-recommends \
  build-essential \
  ffmpeg \
  git \
  libglu1-mesa \
  python3 \
  sudo \
  unzip \
  vim \
  wget

log "Installing extended dependencies (dev libs, tools)"
sudo apt-get update
sudo apt-get install -y --no-install-recommends \
  doxygen \
  graphviz \
  texinfo \
  lcov \
  libblas-dev \
  libboost-all-dev \
  libcln-dev \
  libhdf5-dev \
  libhdf5-openmpi-dev \
  libnetcdf-dev \
  libfftw3-dev \
  lld \
  python3-venv \
  python-is-python3 \
  liblapack-dev \
  libopenmpi-dev \
  libparmetis-dev \
  libmetis-dev \
  libsuitesparse-dev \
  ninja-build \
  libyaml-dev \
  clang \
  clang-tidy \
  clang-tools \
  libomp-dev \
  libvtk9-dev

# keep image small-ish: clean apt cache
rm -rf /var/lib/apt/lists/*

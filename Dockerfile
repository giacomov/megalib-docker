FROM ubuntu:16.04

MAINTAINER Giacomo Vianello <giacomov@stanford.edu>

# Explicitly become root (even though likely we are root already)
USER root

# Override the default shell (sh) with bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Update repositories and install curl
RUN apt-get update && apt-get install -y curl git

# Install build-essentials (gcc and so on)
RUN apt-get install -y build-essential

# Install dependencies for ROOT
RUN apt-get install -y dpkg-dev cmake binutils libpng12-dev libjpeg-dev gfortran libssl-dev libfftw3-dev libcfitsio-dev python-dev libgsl0-dev libx11-dev libxpm-dev libxft-dev libxext-dev

# Install dependencies for Geant4
RUN apt-get install -y libxerces-c3-dev qt4-dev-tools freeglut3-dev libmotif-dev tk-dev cmake libxpm-dev libxmu-dev libxi-dev

# Create user megalib
RUN groupadd -r megalib -g 433
RUN useradd -u 431 -r -g megalib -s /bin/bash -c "Megalib user" megalib
RUN mkdir -p /home/megalib
RUN chown -R megalib:megalib /home/megalib

# Become that user
USER megalib

# Download setup and run it to install megalib (and ROOT and Geant4)
RUN cd /home/megalib && curl -O https://raw.githubusercontent.com/zoglauer/megalib/master/setup.sh
RUN cd /home/megalib && /bin/bash setup.sh --release=dev --cleanup=yes --optimization=strong

# Setup environment

ENV CMAKE_PREFIX_PATH="/home/megalib/MEGAlib/external/root_v6.06.08"
ENV DYLD_LIBRARY_PATH="/home/megalib/MEGAlib/external/root_v6.06.08/lib"
ENV G4ABLADATA="/home/megalib/MEGAlib/external/geant4_v10.02.p02/share/Geant4-10.2.2/data/G4ABLA3.0"
ENV G4ENSDFSTATEDATA="/home/megalib/MEGAlib/external/geant4_v10.02.p02/share/Geant4-10.2.2/data/G4ENSDFSTATE1.2.3"
ENV G4INCLUDE="/home/megalib/MEGAlib/external/geant4_v10.02.p02/include/Geant4"
ENV G4INSTALL="/home/megalib/MEGAlib/external/geant4_v10.02.p02/share/Geant4-10.2.2/geant4make"
ENV G4LEDATA="/home/megalib/MEGAlib/external/geant4_v10.02.p02/share/Geant4-10.2.2/data/G4EMLOW6.48"
ENV G4LEVELGAMMADATA="/home/megalib/MEGAlib/external/geant4_v10.02.p02/share/Geant4-10.2.2/data/PhotonEvaporation3.2"
ENV G4LIB="/home/megalib/MEGAlib/external/geant4_v10.02.p02/lib/Geant4-10.2.2"
ENV G4LIB_BUILD_SHARED="1"
ENV G4LIB_USE_EXPAT="1"
ENV G4LIB_USE_ZLIB="1"
ENV G4NEUTRONHPDATA="/home/megalib/MEGAlib/external/geant4_v10.02.p02/share/Geant4-10.2.2/data/G4NDL4.5"
ENV G4NEUTRONHP_USE_ONLY_PHOTONEVAPORATION="1"
ENV G4NEUTRONXSDATA="/home/megalib/MEGAlib/external/geant4_v10.02.p02/share/Geant4-10.2.2/data/G4NEUTRONXS1.4"
ENV G4PIIDATA="/home/megalib/MEGAlib/external/geant4_v10.02.p02/share/Geant4-10.2.2/data/G4PII1.3"
ENV G4RADIOACTIVEDATA="/home/megalib/MEGAlib/external/geant4_v10.02.p02/share/Geant4-10.2.2/data/RadioactiveDecay4.3.2"
ENV G4REALSURFACEDATA="/home/megalib/MEGAlib/external/geant4_v10.02.p02/share/Geant4-10.2.2/data/RealSurface1.0"
ENV G4SAIDXSDATA="/home/megalib/MEGAlib/external/geant4_v10.02.p02/share/Geant4-10.2.2/data/G4SAIDDATA1.1"
ENV G4SYSTEM="Linux-g++"
ENV G4UI_USE_TCSH="1"
ENV G4VIS_USE_OPENGLX="1"
ENV G4WORKDIR="/home/megalib/geant4_workdir"
ENV GEANT4DIR="/home/megalib/MEGAlib/external/geant4_v10.02.p02"
ENV HOME="/home/megalib"
ENV LD_LIBRARY_PATH="/home/megalib/MEGAlib/external/root_v6.06.08/lib:/home/megalib/MEGAlib/lib:/home/megalib/MEGAlib/external/geant4_v10.02.p02/lib:/home/megalib/MEGAlib/external/geant4_v10.02.p02/lib:/home/megalib/MEGAlib/lib:/home/megalib/MEGAlib/external/geant4_v10.02.p02/lib:/home/megalib/MEGAlib/external/geant4_v10.02.p02/lib:/home/megalib/MEGAlib/lib:/home/megalib/MEGAlib/external/geant4_v10.02.p02/lib:/home/megalib/MEGAlib/external/geant4_v10.02.p02/lib"
ENV LIBPATH="/home/megalib/MEGAlib/external/root_v6.06.08/lib"
ENV MANPATH="/home/megalib/MEGAlib/external/root_v6.06.08/man:/home/megalib/MEGAlib/external/root_v5.34.36:/home/megalib/MEGAlib/external/root_v5.34.36:"
ENV MEGALIB="/home/megalib/MEGAlib"
ENV MEGALIBDIR="/home/megalib/MEGAlib"
ENV PATH="/home/megalib/MEGAlib/external/root_v6.06.08/bin:/home/megalib/MEGAlib/bin:/home/megalib/geant4_workdir/bin/Linux-g++:/home/megalib/MEGAlib/external/geant4_v10.02.p02/bin:/home/megalib/MEGAlib/external/geant4_v10.02.p02/bin:/home/megalib/MEGAlib/bin:/home/megalib/geant4_workdir/bin/Linux-g++:/home/megalib/MEGAlib/external/geant4_v10.00.p04/bin:/home/megalib/MEGAlib/external/geant4_v10.00.p04/bin:/home/megalib/MEGAlib/bin:/home/megalib/geant4_workdir/bin/Linux-g++:/home/megalib/MEGAlib/external/geant4_v10.00.p04/bin:/home/megalib/MEGAlib/external/geant4_v10.00.p04/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV PS1="\${debian_chroot:+(\$debian_chroot)}\\u@\\h:\\w\\\$ "
ENV PYTHONPATH="/home/megalib/MEGAlib/external/root_v6.06.08/lib"
ENV ROOTDIR="/home/megalib/MEGAlib/external/root_v6.06.08"
ENV ROOTSYS="/home/megalib/MEGAlib/external/root_v6.06.08"
ENV SHLIB_PATH="/home/megalib/MEGAlib/external/root_v6.06.08/lib"
ENV TERM="xterm-256color"

# Create workdir
RUN mkdir /home/megalib/workdir

# Set it as workdir
WORKDIR /home/megalib/workdir

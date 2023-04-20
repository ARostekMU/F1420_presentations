FROM gitpod/workspace-full

# Install LaTeX
RUN sudo apt-get -q update && \
    sudo apt-get install -yq texlive && \
    sudo apt-get install -yq texlive-pictures && \
    sudo apt-get install -yq pandoc && \
    sudo rm -rf /var/lib/apt/lists/*
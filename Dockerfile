FROM fpco/stack-build:lts-11.17

# Install all necessary Ubuntu packages
RUN apt-get update && apt-get install -y python3-pip libgmp-dev libmagic-dev libtinfo-dev libzmq3-dev libcairo2-dev libpango1.0-dev libblas-dev liblapack-dev gcc g++ && \
    rm -rf /var/lib/apt/lists/*

# Install Jupyter notebook
RUN pip3 install -U jupyter

ENV LANG en_US.UTF-8
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Set up a working directory for IHaskell
RUN mkdir ${HOME}/ihaskell
WORKDIR ${HOME}/ihaskell

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_UID}

# Set up stack
COPY ihaskell/stack.yaml stack.yaml
RUN stack config set system-ghc --global true
RUN stack setup

# Install dependencies for IHaskell
COPY ihaskell/ihaskell.cabal ihaskell.cabal
COPY ihaskell/ipython-kernel ipython-kernel
COPY ihaskell/ghc-parser ghc-parser
COPY ihaskell/ihaskell-display ihaskell-display

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_UID}

RUN stack build --only-snapshot

# Install IHaskell itself. Don't just COPY . so that
# changes in e.g. README.md don't trigger rebuild.
COPY ihaskell/src ${HOME}/ihaskell/src
COPY ihaskell/html ${HOME}/ihaskell/html
COPY ihaskell/main ${HOME}/ihaskell/main
COPY ihaskell/LICENSE ${HOME}/ihaskell/LICENSE

COPY notebooks ${HOME}/notebooks

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_UID}

RUN stack build && stack install

# Run the notebook
ENV PATH $(stack path --local-install-root)/bin:$(stack path --snapshot-install-root)/bin:$(stack path --compiler-bin):/home/${NB_USER}/.local/bin:${PATH}
RUN ihaskell install --stack
WORKDIR ${HOME}
CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]

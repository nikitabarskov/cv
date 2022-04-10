FROM docker.io/texlive/texlive:latest@sha256:69c79bf9bc9b8e055d5f9c59aa61c4687a8f27d1dfbc4eb6f6707cb1df41661f as texlive
FROM docker.io/curlimages/curl:latest@sha256:c1c1cda72ab8c306390fc05518bf4d42148564978326d078f65d546858d139cb as curl

FROM curl as fonts

RUN mkdir -p /tmp/fonts

RUN curl -L https://github.com/FortAwesome/Font-Awesome/releases/download/6.1.1/fontawesome-free-6.1.1-web.zip \
    --output /tmp/fontawesome.zip && \
    unzip /tmp/fontawesome.zip -d /tmp/fonts && \
    curl -L https://github.com/rsms/inter/releases/download/v3.19/Inter-3.19.zip \
    --output /tmp/inter.zip && \
    unzip /tmp/inter.zip -d /tmp/fonts && \
    rm -rf /tmp/fontawesome.zip /tmp/inter.zip

FROM texlive as cv

WORKDIR /srv/src

COPY --from=fonts /tmp/fonts /srv/src/fonts
RUN mkdir -p /root/.local/share/fonts && \
    find /srv/src/fonts -name "*.ttf" -exec cp "{}" /root/.local/share/fonts \; && \
    find /srv/src/fonts -name "*.otf" -exec cp "{}" /root/.local/share/fonts \; && \
    fc-cache -f -v

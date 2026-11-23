VERSION 0.8
FROM DOCKERFILE --target=pandoc .

configure:
    ARG BADNESS_TAG=v0.29.1
    RUN apk --no-cache add curl && \
        curl -fsSL https://badness.dev/install -o /tmp/install-badness.sh && \
        BADNESS_TAG=${BADNESS_TAG} BADNESS_INSTALL_DIR=/usr/local/bin sh /tmp/install-badness.sh
    RUN tlmgr update --self && \
        tlmgr install titlesec enumitem cm-unicode

code:
    FROM +configure
    COPY . .

pdf:
    ARG --required LOCALE
    FROM +code
    RUN pandoc --pdf-engine=xelatex --include-in-header styles.tex -f gfm ${LOCALE}/barskov-nikita-cv.md -o barskov-nikita-cv-${LOCALE}.pdf
    SAVE ARTIFACT /srv/workspace/barskov-nikita-cv-${LOCALE}.pdf AS LOCAL barskov-nikita-cv-${LOCALE}.pdf

fix:
    FROM +code
    RUN badness format styles.tex
    SAVE ARTIFACT /srv/workspace/styles.tex AS LOCAL styles.tex

validate:
    FROM +code
    RUN badness format --check styles.tex

ci:
    BUILD +validate
    BUILD +pdf \
      --LOCALE en \
      --LOCALE nb \
      --LOCALE ru

VERSION 0.8
FROM DOCKERFILE --target=pandoc .

configure:
    RUN apk --no-cache add \
            miniperl \
            perl-utils \
            perl-log-dispatch \
            perl-namespace-autoclean \
            perl-specio \
            perl-unicode-linebreak \
            curl \
            wget \
            make && \
        curl -L https://cpanmin.us/ -o /usr/local/bin/cpanm && \
        chmod +x /usr/local/bin/cpanm && \
        cpanm -n App::cpanminus && \
        cpanm -n File::HomeDir && \
        cpanm -n Params::ValidationCompiler && \
        cpanm -n YAML::Tiny
    RUN tlmgr install titlesec latexindent
    COPY styles.tex styles.tex
    COPY barskov-nikita-cv.md barskov-nikita-cv.md

pdf:
    FROM +configure
    RUN pandoc --pdf-engine=xelatex --include-in-header styles.tex -f gfm barskov-nikita-cv.md -o barskov-nikita-cv.pdf
    SAVE ARTIFACT /srv/workspace/barskov-nikita-cv.pdf AS LOCAL barskov-nikita-cv.pdf

fix:
    FROM +configure
    RUN latexindent \
        -overwrite \
        -modifylinebreaks \
        styles.tex
    SAVE ARTIFACT /srv/workspace/styles.tex AS LOCAL styles.tex

validate:
    FROM +configure
    RUN latexindent -silent -checkv styles.tex

ci:
    BUILD +validate
    BUILD +pdf

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
    RUN tlmgr update --self && \
        tlmgr install titlesec latexindent

code:
    FROM +configure
    COPY . .

pdf:
    ARG --required LOCALE
    FROM +code
    RUN pandoc --pdf-engine=xelatex --include-in-header styles.tex -f gfm ${LOCALE}/barskov-nikita-cv.md -o barskov-nikita-cv_${LOCALE}.pdf
    SAVE ARTIFACT /srv/workspace/barskov-nikita-cv_${LOCALE}.pdf AS LOCAL barskov-nikita-cv_${LOCALE}.pdf

fix:
    FROM +code
    RUN latexindent \
        -overwrite \
        -modifylinebreaks \
        styles.tex
    SAVE ARTIFACT /srv/workspace/styles.tex AS LOCAL styles.tex

validate:
    FROM +code
    RUN latexindent -silent -checkv styles.tex

ci:
    BUILD +validate
    BUILD +pdf \
      --LOCALE en_US \
      --LOCALE no_NB

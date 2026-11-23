set unstable
set lists

default:
    just --list

configure:
    mise install

fix:
    mise fmt
    just --fmt
    oxfmt --write

validate:
    mise fmt --check
    just --fmt --check
    oxfmt --check

[cache(inputs=[locale + "/barskov-nikita-cv.md", "styles.tex", "mise.lock"], outputs="barskov-nikita-cv-" + locale + ".pdf")]
[script]
build-locale locale:
    pandoc \
        --pdf-engine=tectonic \
        --include-in-header styles.tex \
        --from gfm \
        --verbose \
        {{ locale }}/barskov-nikita-cv.md \
        -o barskov-nikita-cv-{{ locale }}.pdf

build: (build-locale "en")

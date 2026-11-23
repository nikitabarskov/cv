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

[cache(inputs=[locale + "/barskov-nikita_cv.md", "styles.tex", "mise.lock"], outputs="barskov-nikita_cv_" + locale + ".pdf")]
[script]
build-locale locale:
    pandoc \
        --pdf-engine=tectonic \
        --include-in-header styles.tex \
        --from gfm \
        {{ locale }}/barskov-nikita_cv.md \
        -o barskov-nikita_cv_{{ locale }}.pdf

build: (build-locale "en")

release: build
    gh release create $(date '+%Y%m%d%H%M%S') --generate-notes --latest barskov-nikita_cv_*.pdf

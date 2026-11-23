set unstable
set lists

default:
    just --list

configure:
    mise install

fix-mise:
    mise fmt

fix-just:
    just --fmt

fix-oxfmt:
    oxfmt --write

fix-latex:
    badness format styles.tex

fix-gha:
    zizmor --fix=all .github/workflows

fix: fix-mise fix-just fix-oxfmt fix-latex

validate:
    mise fmt --check
    just --fmt --check
    oxfmt --check
    badness format --check styles.tex

[cache(inputs=[locale + "/barskov-nikita-cv.md", "styles.tex", "mise.lock"], outputs="barskov-nikita-cv-" + locale + ".pdf")]
[script]
build-locale locale:
    pandoc --pdf-engine=xelatex --include-in-header styles.tex -f gfm {{ locale }}/barskov-nikita-cv.md -o barskov-nikita-cv-{{ locale }}.pdf

build: (build-locale "en") (build-locale "nb") (build-locale "ru")

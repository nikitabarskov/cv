set unstable
set lists

default:
    just --list

configure:
    mise install

gha-fix:
    zizmor --fix=all .github/workflows

fix: && gha-fix
    mise fmt
    just --fmt
    oxfmt --write

gha-validate +target=".github/workflows":
    zizmor \
        --no-progress \
        --quiet \
        --min-severity=low \
        --persona pedantic \
        --strict-collection \
        --collect=all \
        {{ target }}

validate: && gha-validate
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

build: validate (build-locale "en")

ci: build

release: build
    gh release create $(date '+%Y%m%d%H%M%S') --generate-notes --latest barskov-nikita_cv_*.pdf

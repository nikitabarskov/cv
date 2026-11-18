default:
    just --list

configure:
    mise install

fmt-mise:
    mise fmt

fmt-just:
    just --fmt

fmt-oxfmt:
    oxfmt --write

fmt-latex:
    tex-fmt --format-tables --nowrap styles.tex

fix-gha:
    zizmor --fix=all .github/workflows

fix: fmt-mise fmt-just fmt-oxfmt fmt-latex

validate:
    mise fmt --check
    just --fmt --check
    oxfmt --check
    latexindent -silent -checkv styles.tex

build-no:
    pandoc --pdf-engine=xelatex --include-in-header styles.tex -f gfm no_NB/barskov-nikita-cv.md -o barskov-nikita-cv_no_NB.pdf
build-us:
    pandoc --pdf-engine=xelatex --include-in-header styles.tex -f gfm en_US/barskov-nikita-cv.md -o barskov-nikita-cv_en_US.pdf

build: build-us build-no

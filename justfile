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

build-no:
    pandoc --pdf-engine=xelatex --include-in-header styles.tex -f gfm no_NB/barskov-nikita-cv.md -o barskov-nikita-cv_no_NB.pdf
build-us:
    pandoc --pdf-engine=xelatex --include-in-header styles.tex -f gfm en_US/barskov-nikita-cv.md -o barskov-nikita-cv_en_US.pdf

build: build-us build-no

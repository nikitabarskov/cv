build-no:
    pandoc --pdf-engine=xelatex --include-in-header styles.tex -f gfm no_NB/barskov-nikita-cv.md -o barskov-nikita-cv_no_NB.pdf
build-us:
    pandoc --pdf-engine=xelatex --include-in-header styles.tex -f gfm en_US/barskov-nikita-cv.md -o barskov-nikita-cv_en_US.pdf

build: build-us build-no

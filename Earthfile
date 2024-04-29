VERSION 0.8
FROM DOCKERFILE --target=texlive .

configure:
    COPY barskov-nikita-cv.tex barskov-nikita-cv.tex

pdf:
    FROM +configure
    RUN xelatex -halt-on-error -interaction=errorstopmode barskov-nikita-cv.tex
    SAVE ARTIFACT /srv/workspace/barskov-nikita-cv.pdf AS LOCAL barskov-nikita-cv.pdf

fix:
    FROM +configure
    RUN latexindent -silent –modifylinebreaks -overwrite barskov-nikita-cv.tex
    SAVE ARTIFACT /srv/workspace/barskov-nikita-cv.tex AS LOCAL barskov-nikita-cv.tex

validate:
    FROM +configure
    RUN latexindent -silent -checkv barskov-nikita-cv.tex

ci:
    BUILD +validate
    BUILD +pdf

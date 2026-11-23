# CV

I keep my CV as [a Markdown file](en/barskov-nikita-cv.md), every time I update
it, GitHub actions publishes a release with a publically available PDF.

Check out my latest CV:

- Markdown: [English](en/barskov-nikita-cv.md),
  [Bokmål](nb/barskov-nikita-cv.md), [Russian](ru/barskov-nikita-cv.md)
- PDF:
  [barskov-nikita-cv.pdf](https://github.com/nikitabarskov/cv/releases/latest)

It's available in English (`en`), Norwegian Bokmål (`nb`), and Russian (`ru`).

## Formatting

Install the tools with `mise install --locked`, then run:

```sh
mise exec -- just fix
mise exec -- just validate
```

[Badness](https://badness.dev/) formats the LaTeX source in `styles.tex`. Oxfmt
formats Markdown and other supported text files. CI checks formatting with
`just validate`.

## Building

```sh
mise exec -- just build
```

Build one locale with:

```sh
mise exec -- just build-locale en
mise exec -- just build-locale nb
mise exec -- just build-locale ru
```

Just caches each locale separately using its Markdown source, shared LaTeX
styles, and mise lockfile. Missing PDFs are rebuilt. This uses Just's unstable
cached recipes feature.

Just checks output existence, not output contents, and does not restore cached
PDFs. Force a rebuild after switching revisions, editing generated PDFs, or
changing TeX packages or fonts:

```sh
mise exec -- just --no-cache build
```

Formatting, setup, and validation always run.

## Links

- https://careerservices.fas.harvard.edu/resources/create-a-strong-resume/
- https://capd.mit.edu/channels/make-a-resume-cover-letter-cv/
- https://github.com/sb2nov/resume
- https://github.com/jakegut/resume

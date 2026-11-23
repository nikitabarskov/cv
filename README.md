# CV

I keep my CV as [a Markdown file](en/barskov-nikita_cv.md) and build it into a
PDF with pandoc and Tectonic.

Check out my latest CV:

- Markdown: [barskov-nikita_cv.md](en/barskov-nikita_cv.md)
- PDF: [latest release](https://github.com/nikitabarskov/cv/releases/latest)

It's available in English.

## Build

Prerequisite: [mise](https://mise.jdx.dev). It installs the pinned versions of
`just`, `pandoc`, `tectonic`, and `oxfmt` from `mise.lock`.

```sh
mise install
just build
```

`just build` writes `barskov-nikita_cv_en.pdf` to the repository root. The first
build downloads the TeX files it needs into Tectonic's cache, so it needs
network access. `just` skips the build when the CV, `styles.tex`, and
`mise.lock` have not changed since the last build.

Other tasks:

- `just fix`: format all files.
- `just validate`: check formatting without changes.

CI runs `just ci` on every pull request and on each push to `main`. Release
publishes a release when a push to `main` changes the CV or `styles.tex`. To
publish a release by hand, run the `Release` workflow from the Actions tab.

## Links

- https://careerservices.fas.harvard.edu/resources/create-a-strong-resume/
- https://capd.mit.edu/channels/make-a-resume-cover-letter-cv/

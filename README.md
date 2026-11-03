# deadfin.org

The website for Deadfin, a Jellyfin-compatible media server written in Go.
GitHub Pages serves it at <https://deadfin.org>.

The server source is at <https://github.com/deadfin-org/deadfin>. Report
problems with the site there.

## Layout

| Path | Holds |
|---|---|
| `site/` | The source files. Plain HTML and CSS with release placeholders. |
| `site/install/index.html` | Sends `/install` to the install guide on GitHub. |
| `scripts/stamp-versions.sh` | Copies `site/` to `_site/` and stamps the release versions. |
| `scripts/check-site.sh` | Required files, term scan, placeholder, `CNAME` and `security.txt` checks. |
| `.github/workflows/pages.yml` | Checks every pull request. A push to `main`, a daily run and each Deadfin release publish `_site/` to GitHub Pages. |

## Preview

```bash
GH_TOKEN=$(gh auth token) scripts/stamp-versions.sh
```

```bash
python3 -m http.server -d _site 8080
```

Open <http://localhost:8080/>.

## Content sources

The client cards, quick start and client table follow the Deadfin
`README.md` on `master` and `docs/alpha/install.md`. The quick start uses
the `:latest` image tag.

The release versions are placeholders in `site/`:

| Placeholder | Value |
|---|---|
| `{{DEADFIN_VERSION}}` | The newest Deadfin release that is not a prerelease. |
| `{{DEADFIN_WEB_VERSION}}` | The deadfin-web tag in the `Dockerfile` of that release. |

`scripts/stamp-versions.sh` reads both from GitHub at each build. The
Deadfin `release.yml` sends a `deadfin-release` dispatch after it creates
the GitHub Release, so the site follows a release in minutes. The daily run
is the fallback.

The "Next" list follows the `Unreleased` section of `CHANGELOG.md` on the
next release branch. Change it in `site/index.html` by hand. `site/deadfin.svg` is `docs/assets/deadfin.svg` from
the Deadfin repository. `site/og.png` is the GitHub social preview of
`deadfin-org/deadfin`.

`security.txt` expires on 2027-10-14. `scripts/check-site.sh` fails after
that date.

## Screenshots

The page has no screenshots. To add a section, use real captures of a
current Deadfin release, with the client's maturity in each caption. Put
images in `site/media/` as WebP or PNG, 1600 px wide, 16:10, dark theme.
Use generated or freely licensed media only, with no personal library
titles. A demo video is MP4 (H.264) and WebM, under 10 MB, no audio, with a
poster frame, in `<video controls muted playsinline preload="none" poster>`.

## License

GPL-2.0-only, the same license as Deadfin. See [LICENSE](LICENSE).

# deadfin.org

The website for Deadfin, a Jellyfin-compatible media server written in Go.
GitHub Pages serves it at <https://deadfin.org>.

The server source is at <https://github.com/deadfin-org/deadfin>. Report
problems with the site there.

## Layout

| Path | Holds |
|---|---|
| `site/` | The published files. Plain HTML and CSS, no build step. |
| `site/install/index.html` | Sends `/install` to the install guide on GitHub. |
| `scripts/check-site.sh` | Required files, term scan, `CNAME` and `security.txt` checks. |
| `.github/workflows/pages.yml` | Checks every pull request. A push to `main` publishes `site/` to GitHub Pages. |

## Preview

```bash
python3 -m http.server -d site 8080
```

Open <http://localhost:8080/>.

## Content sources

The client cards, quick start and client table follow the Deadfin
`README.md` on `master` and `docs/alpha/install.md`. The quick start uses
the `:latest` image tag and pins `v0.3.1` as the example; change both at
each release. The "Next" list follows the `Unreleased` section of
`CHANGELOG.md` on the next release branch. When those change, change
`site/index.html` too. `site/deadfin.svg` is `docs/assets/deadfin.svg` from
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

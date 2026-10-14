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

The quick start copies its commands from the Deadfin `README.md` and
`docs/alpha/install.md`. When those change, change `site/index.html` too.
`site/deadfin.svg` is `docs/assets/deadfin.svg` from the Deadfin
repository. `site/og.png` is the GitHub social preview of
`deadfin-org/deadfin`.

`security.txt` expires on 2027-10-14. `scripts/check-site.sh` fails after
that date.

## License

GPL-2.0-only, the same license as Deadfin. See [LICENSE](LICENSE).

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

## Captures

The page has no "See it" section yet. Add it back when these captures
exist. Each capture needs a real recording against a current Deadfin
release, with the client's maturity in the caption. Put images in `site/media/` as WebP or PNG,
1600 px wide, 16:10, light or dark theme to match the page default (dark).
Use generated or freely licensed media only, with no personal library
titles.

- [ ] First-run setup in deadfin-web (experimental alpha): the setup
      wizard on a fresh server, at the step that adds a library.
- [ ] Browsing in deadfin-web (experimental alpha): home with Continue
      Watching and library shelves, artwork loaded.
- [ ] Playback in deadfin-web (experimental alpha): a movie playing with
      the player controls and a subtitle track shown.
- [ ] SharkParty on Apple TV (tvOS pre-alpha): the home screen in the tvOS
      Simulator, captioned as Simulator until a device capture exists.
- [ ] Demo video, about 60 seconds, deadfin-web (experimental alpha):
      setup, browsing, then playback. MP4 (H.264) and WebM, under 10 MB,
      no audio, with a poster frame. Use `<video controls muted playsinline
      preload="none" poster>`.

## License

GPL-2.0-only, the same license as Deadfin. See [LICENSE](LICENSE).

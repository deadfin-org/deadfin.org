#!/bin/sh
# Static checks for the published files. The default directory is _site/,
# the output of scripts/stamp-versions.sh.
# Usage: scripts/check-site.sh [dir]
set -eu
cd "$(dirname "$0")/.."
dir=${1:-_site}

fail=0

for f in index.html 404.html style.css deadfin.svg favicon.svg favicon-32.png \
         apple-touch-icon.png og.png robots.txt CNAME install/index.html \
         .well-known/security.txt; do
  if [ ! -s "$dir/$f" ]; then
    echo "missing: $dir/$f"
    fail=1
  fi
done

# Terms that must not reach the public site, as one extended regular
# expression in LEAK_PATTERN (an Actions secret). The check is skipped when
# the variable is empty.
if [ -n "${LEAK_PATTERN:-}" ]; then
  if grep -rniE "$LEAK_PATTERN" "$dir"; then
    echo "a LEAK_PATTERN term was found in $dir/"
    fail=1
  fi
else
  echo "LEAK_PATTERN is not set: term scan skipped"
fi

# Every release placeholder must be stamped.
if grep -rnE '\{\{[A-Z_]+\}\}' "$dir"; then
  echo "an unstamped placeholder was found in $dir/ (run scripts/stamp-versions.sh)"
  fail=1
fi

[ "$(cat "$dir/CNAME")" = deadfin.org ] || { echo "CNAME is not deadfin.org"; fail=1; }

# security.txt needs Contact and a future Expires (RFC 9116).
grep -q '^Contact: ' "$dir/.well-known/security.txt" || { echo "security.txt: no Contact"; fail=1; }
expires=$(sed -n 's/^Expires: \([0-9-]*\)T.*/\1/p' "$dir/.well-known/security.txt")
today=$(date -u +%Y-%m-%d)
if [ -z "$expires" ] || [ "$expires" \< "$today" ] || [ "$expires" = "$today" ]; then
  echo "security.txt: Expires is missing or past ($expires)"
  fail=1
fi

exit "$fail"

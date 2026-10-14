#!/bin/sh
# Static checks for the published files in site/.
# Usage: scripts/check-site.sh
set -eu
cd "$(dirname "$0")/.."

fail=0

for f in index.html 404.html style.css deadfin.svg favicon.svg favicon-32.png \
         apple-touch-icon.png og.png robots.txt CNAME install/index.html \
         .well-known/security.txt; do
  if [ ! -s "site/$f" ]; then
    echo "missing: site/$f"
    fail=1
  fi
done

# Terms that must not reach the public site, as one extended regular
# expression in LEAK_PATTERN (an Actions secret). The check is skipped when
# the variable is empty.
if [ -n "${LEAK_PATTERN:-}" ]; then
  if grep -rniE "$LEAK_PATTERN" site; then
    echo "a LEAK_PATTERN term was found in site/"
    fail=1
  fi
else
  echo "LEAK_PATTERN is not set: term scan skipped"
fi

[ "$(cat site/CNAME)" = deadfin.org ] || { echo "CNAME is not deadfin.org"; fail=1; }

# security.txt needs Contact and a future Expires (RFC 9116).
grep -q '^Contact: ' site/.well-known/security.txt || { echo "security.txt: no Contact"; fail=1; }
expires=$(sed -n 's/^Expires: \([0-9-]*\)T.*/\1/p' site/.well-known/security.txt)
today=$(date -u +%Y-%m-%d)
if [ -z "$expires" ] || [ "$expires" \< "$today" ] || [ "$expires" = "$today" ]; then
  echo "security.txt: Expires is missing or past ($expires)"
  fail=1
fi

exit "$fail"

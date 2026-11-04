#!/bin/sh
# Copies site/ to _site/ and stamps the release placeholders.
# {{DEADFIN_VERSION}} is the newest Deadfin release (not a prerelease).
# {{DEADFIN_WEB_VERSION}} is the deadfin-web tag that the Dockerfile of that
# release bundles. DEADFIN_VERSION and DEADFIN_WEB_VERSION in the environment
# replace the lookups. The lookups need gh with a token (GH_TOKEN).
# Usage: scripts/stamp-versions.sh
set -eu
cd "$(dirname "$0")/.."

repo=deadfin-org/deadfin
version=${DEADFIN_VERSION:-$(gh release view -R "$repo" --json tagName -q .tagName)}
web_version=${DEADFIN_WEB_VERSION:-$(gh api -H 'Accept: application/vnd.github.raw' \
  "repos/$repo/contents/Dockerfile?ref=$version" |
  sed -n 's|^ARG DEADFIN_WEB_IMAGE=ghcr.io/deadfin-org/deadfin-web:\(v[^@]*\)@.*|\1|p')}

for v in "$version" "$web_version"; do
  if ! printf '%s\n' "$v" | grep -qE '^v[0-9]+\.[0-9]+\.[0-9]+$'; then
    echo "not a release tag: '$v'"
    exit 1
  fi
done

rm -rf _site
cp -R site _site
find _site -name '*.html' -exec sed -i.bak \
  -e "s/{{DEADFIN_VERSION}}/$version/g" \
  -e "s/{{DEADFIN_WEB_VERSION}}/$web_version/g" {} +
find _site -name '*.bak' -exec rm {} +
echo "stamped: deadfin $version, deadfin-web $web_version"

#!/bin/sh -l

set -e

RESUME=${1}
OUTPUT=${2}
THEME=$(jq -r .meta.theme ${RESUME})

THEME_PACKAGE=jsonresume-theme-${THEME}
echo "Installing theme: ${THEME}"

npm install ${THEME_PACKAGE}

resume export --resume ${RESUME} --theme ${THEME} --format html ${OUTPUT}.html
resume export --resume ${RESUME} --theme ${THEME} --format pdf ${OUTPUT}.pdf

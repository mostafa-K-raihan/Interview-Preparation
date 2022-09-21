#!/bin/bash

# delete existing Readme
find Readme.md && rm Readme.md

# merge all markdown

find . -name "*.md" -print0 | xargs -0 pandoc -o Readme.md


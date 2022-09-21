#!/bin/bash

# delete existing Readme
find Readme.md && rm Readme.md

# merge all markdown

find . -name "*.md" -print0 | xargs -0 pandoc -o Readme.md

# update all python code snippet so that syntax highlight works correctly

sed -i 's/{.python}/python/g' Readme.md


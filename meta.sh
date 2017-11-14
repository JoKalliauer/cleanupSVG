#!/bin/bash

export meta=1

./svg2wikisvg.sh

./InkscapeBatchConverter.sh

./scour4wiki.sh

./svg2wikisvg.sh

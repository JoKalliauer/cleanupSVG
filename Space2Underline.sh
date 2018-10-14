#!/bin/bash

#Author: Johannes Kalliauer (JoKalliauer)

for file in *; do mv "$file" `echo $file | tr ' ' '_'` ; done

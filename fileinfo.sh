#!/bin/bash

for f in *; do
  echo "`stat -c%s -c%x "$f"` $f";
done;

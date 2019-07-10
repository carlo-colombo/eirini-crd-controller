#!/usr/bin/env sh

(cd ..
  mix run ./hooks/namespace_add.exs "$@" 2> /dev/null
  )

#!/usr/bin/env sh

(cd ..
  mix run \
    --eval "LRPLifecycle.main(System.argv())" -- "$@" )

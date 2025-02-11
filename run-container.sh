#!/bin/bash

docker build -t psp-cms-buildroot .
docker run -it -v $PWD:/work -w /work psp-cms-buildroot bash
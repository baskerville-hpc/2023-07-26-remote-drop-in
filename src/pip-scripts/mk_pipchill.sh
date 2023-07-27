#!/bin/bash

module load bask-apps/live
module load Python/3.9.5-GCCcore-10.3.0-bare
module load CUDA/11.7.0

mkdir mychillenv
virtualenv mychillenv
source ./mychillenv/bin/activate
pip install pip-chill
pip install arrow
pip install nvidia-htop
echo " list version "
pip-chill
echo " list no version "
pip-chill --no-version
echo " list version and package dependencies too "

pip-chill  --no-chill -v

nvidia-htop.py -l
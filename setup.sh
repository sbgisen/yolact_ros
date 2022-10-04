#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

if [ -e "scripts/yolact/weights/yolact_plus_resnet50_54_800000.pth" ]; then
    echo "Yolact weights already downloaded"
else
    pipenv run build_dcnv2
    pipenv run download_weight
fi

#!/bin/bash

if [ -z `which pyenv` ]; then
    curl https://pyenv.run | bash
    cat >> ${HOME}/.bashrc <<EOF
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
EOF
fi

export PATH=${HOME}/.pyenv/bin:${HOME}/.local/bin:${PATH}

python -m pip install pipenv pipenv-shebang
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR
echo "y" | pipenv install --skip-lock

if [ -e "scripts/yolact/weights/yolact_plus_resnet50_54_800000.pth" ]; then
    echo "Yolact weights already downloaded"
else
    pipenv run build_dcnv2
    pipenv run download_weight
fi

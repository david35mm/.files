#!/bin/sh

/usr/bin/python -m venv --upgrade --upgrade-deps /home/david/py3.12-ml

exec /home/david/py3.12-ml/bin/python -m pip install -U isort jupyter matplotlib nbconvert numpy pandas pip plotly pylint scikit-learn seaborn setuptools tensorflow-cpu wheel yapf

# sudo dnf -y in pandoc texlive-scheme-small texlive-tcolorbox texlive-adjustbox texlive-titling

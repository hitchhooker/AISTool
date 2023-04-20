#!/bin/bash

PROJECT_DIR="$(pwd)"
VENV_NAME="venv"

# Check if the virtual environment exists; create it if it doesn't
if [ ! -d "${PROJECT_DIR}/${VENV_NAME}" ]; then
	echo "Creating virtual environment..."
	python -m venv "${VENV_NAME}"
	echo "Virtual environment created."
fi

# Activate the virtual environment
source "${VENV_NAME}/bin/activate"

# Update all packages
pip install --upgrade pip
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U

# Update requirements.txt and dev_requirements.txt
pip freeze | grep -v "^\-e" >requirements.txt
pip freeze --exclude-editable | grep -v "^\-e" >dev_requirements.txt

# Deactivate the virtual environment
deactivate

echo "Packages have been updated, and requirements files have been regenerated."

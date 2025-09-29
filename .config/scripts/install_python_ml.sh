#!/bin/bash

# Configuration
ENV_HOME="$HOME/py-envs"
VENV_DIR="$ENV_HOME/ml-py3.12"
REQUIREMENTS_FILE="$HOME/requirements.txt"

python_install() {
  echo "-------------------------------------------------"
  echo "    Installing uv (Python environment manager)"
  echo "-------------------------------------------------"

  # Clean previous installations
  rm -rf "$HOME/.cache/uv" "$HOME/.local/share/uv"
  rm -f "$HOME/.local/bin/uv" "$HOME/.local/bin/uvx"

  # Install uv
  curl -LsSf https://astral.sh/uv/install.sh | sh

  # Add to PATH for this session
  export PATH="$HOME/.local/bin:$PATH"
}

python_pkgs() {
  echo "-------------------------------------------------"
  echo "    Setting up shared Python environment"
  echo "-------------------------------------------------"

  # Update uv
  uv self update

  # Create target directory
  mkdir -p "$ENV_HOME"

  # Create Python 3.12 virtual environment
  uv venv "$VENV_DIR" -p 3.12

  # Install packages
  uv pip install --requirement "$REQUIREMENTS_FILE"

  # Setup Jupyter Kernel
  "$VENV_DIR/bin/python" -m ipykernel install \
    --user \
    --name "ml-py3.12" \
    --display-name "Python 3.12 (ML Env)"

  echo "Environment created successfully!"
  echo "Virtual environment: $VENV_DIR"
  echo "To activate: source $VENV_DIR/bin/activate"
}

main() {
  clear

  # Ensure uv is available
  if ! command -v uv &> /dev/null; then
    python_install
  fi

  # Add uv to PATH if needed
  export PATH="$HOME/.local/bin:$PATH"

  python_pkgs
}

main "$@"

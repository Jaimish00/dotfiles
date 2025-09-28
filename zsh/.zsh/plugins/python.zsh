# Python aliases and functions

# Aliases
alias pyfind='find . -name "*.py" -type f'
alias pygrep='grep -r "\.py$" --include="*.py" . -e'
alias pyuserpaths='export PYTHONPATH=$PYTHONPATH:$(python3 -c "import site; print(\":\".join(site.getsitepackages()))")'

function pyclean() {
  setopt localoptions rmstarsilent
  for dir in ${@:-.}; do
    find "$dir" -type f -name "*.py[co]" -delete
    find "$dir" -type d -name "__pycache__" -exec rm -rf {} +
  done
}

function pyserver() {
  python3 -m http.server "$@"
}

# Virtual environments
: ${PYTHON_VENV_NAME:=venv}
: ${PYTHON_VENV_NAMES:=($PYTHON_VENV_NAME venv .venv)}

function mkv() {
  local venv_name="${1:-$PYTHON_VENV_NAME}"
  python3 -m venv "$venv_name"
}

function vrun() {
  local venv_name
  for venv_name in "${PYTHON_VENV_NAMES[@]}"; do
    if [[ -f "$venv_name/bin/activate" ]]; then
      source "$venv_name/bin/activate"
      return 0
    fi
  done
  echo "No virtual environment found in: ${PYTHON_VENV_NAMES[*]}" >&2
  return 1
}

function _python_auto_vrun() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # Check if we are still in the virtual environment directory
    local venv_dir="${VIRTUAL_ENV%/bin/activate}"
    venv_dir="${venv_dir%/bin}"
    if [[ "$PWD" != "$venv_dir"/* ]]; then
      deactivate
    fi
  else
    # Check if we entered a directory with a virtual environment
    local venv_name
    for venv_name in "${PYTHON_VENV_NAMES[@]}"; do
      if [[ -f "$venv_name/bin/activate" ]]; then
        source "$venv_name/bin/activate"
        break
      fi
    done
  fi
}

if [[ "$PYTHON_AUTO_VRUN" == true ]]; then
  autoload -U add-zsh-hook
  add-zsh-hook chpwd _python_auto_vrun
  _python_auto_vrun
fi

# Set py alias if py is not installed
if ! command -v py &> /dev/null; then
  alias py='python3'
fi
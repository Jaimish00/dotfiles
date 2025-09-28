#===============================================================================
# FUNCTIONS
#===============================================================================



# Dotfiles management
dotstow() {
  local name=$1
  if [[ -z "$name" ]]; then
    name=$(gum input --placeholder "Enter the name of the directory to stow")
  fi

  local src="$HOME/.config/$name"
  local dst="$HOME/dotfiles/$name/.config/$name"

  if [[ ! -d "$src" ]]; then
    gum style --foreground 196 "No config found at $src"
    return 1
  fi

  gum confirm "Move $src into $dst and stow it?" || return 1

  mkdir -p "$dst"
  mv "$src"/* "$dst"/
  rmdir "$src" 2>/dev/null || true

  (cd ~/dotfiles && stow "$name")
  gum style --foreground 82 "✔ Successfully stowed $name"
}

dotunstow() {
  local name=$1
  if [[ -z "$name" ]]; then
    name=$(gum input --placeholder "Enter the name of the directory to unstow")
  fi

  local src="$HOME/dotfiles/$name/.config/$name"
  local dst="$HOME/.config/$name"

  if [[ ! -d "$src" ]]; then
    gum style --foreground 196 "No stowed config found at $src"
    return 1
  fi

  gum confirm "Unstow $name and move it back to $dst?" || return 1

  (cd ~/dotfiles && stow -D "$name")

  mkdir -p "$dst"
  mv "$src"/* "$dst"/
  rmdir "$src" 2>/dev/null || true

  gum style --foreground 82 "✔ Successfully unstowed $name"
}

# Docker security scanning
scanimg() {
  image_name=$(gum input --placeholder "Enter image name")
  if [ -z "$image_name" ]; then
    gum style --foreground 1 "❌ Image name is required. Aborting."
    return 1
  fi
  image_tag=$(gum input --placeholder "Enter image tag (optional, default: latest)")
  if [ -z "$image_tag" ]; then
    image_tag="latest"
  fi

  docker images | grep "$image_name" | grep "$image_tag"
  if [ $? -eq 0 ]; then
    gum style --foreground 10 "✓ Image $image_name:$image_tag exists locally"
  else
    gum style --foreground 10 "Pulling image $image_name:$image_tag"
    docker pull "$image_name:$image_tag"
    gum style --foreground 10 "✓ Image $image_name:$image_tag pulled"
  fi

  output_report_name=$(gum input --placeholder "Enter output report name (optional, default: report_$image_name.html)")
  if [ -z "$output_report_name" ]; then
    output_report_name="report_$image_name.html"
  fi
  gum style --foreground 10 "Running scan with output report $output_report_name"
  trivy scan2html image --scanners vuln,secret,misconfig,license "$image_name:$image_tag" --scan2html-flags --output "$output_report_name"
  gum style --foreground 10 "✓ Scan complete"
}

# Database management
create-authdb() {
  docker exec -it authdb psql -U opshealth_user -c "CREATE DATABASE \"$1\";"
}

create-opsdb() {
  docker exec -it postgresql-opshealth psql -U postgres -c "CREATE DATABASE \"$1\";"
}

create-fresh-dbs() {
  auth_db=$(gum input --placeholder "Enter name for auth DB" --prompt "authdb > ")
  if [ -z "$auth_db" ]; then
    gum style --foreground 1 "❌ Auth DB name is required. Aborting."
    return 1
  fi

  ops_db=$(gum input --placeholder "Enter name for ops DB" --prompt "opsdb > ")
  if [ -z "$ops_db" ]; then
    gum style --foreground 1 "❌ Ops DB name is required. Aborting."
    return 1
  fi

  gum spin --title "Creating auth DB: $auth_db" -- \
    docker exec -it authdb psql -U opshealth_user -c "CREATE DATABASE \"$auth_db\";"

  gum style --foreground 10 "✓ Created auth DB: $auth_db"

  gum spin --title "Creating ops DB: $ops_db" -- \
    docker exec -it postgresql-opshealth psql -U postgres -c "CREATE DATABASE \"$ops_db\";"

  gum style --foreground 10 "✓ Created ops DB: $ops_db"

  gum style --foreground 212 --bold --border double --padding "1 2" "🎉 Databases created successfully!"
}

# Navigation functions
cx() { cd "$@" && l; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

# Process management
pkill() {
  ps aux | fzf --height 40% --layout=reverse --prompt="Select process to kill: " | awk '{print $2}' | xargs -r sudo kill
}

# Project-specific aliases (Alloi)
alias reset-ops="make reset-migrate && make down && make up && sleep 10 && curl --location --request POST 'http://localhost:3567/recipe/dashboard/user' \
--header 'rid: dashboard' \
--header 'Content-Type: application/json' \
--data-raw '{\"email\": \"jaimish+admin@opshealth.io\",\"password\": \"local123\"}'"

alias start-servers="tmux kill-session -t servers && tmuxp load -s servers ~/.tmuxp/ops_servers.yaml"
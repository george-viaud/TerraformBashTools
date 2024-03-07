#!/bin/bash

# Script Name: Terraform Apply Recursive
# Description: Iterates over subdirectories to apply Terraform configurations selectively, with optional initialization and a force apply option.
# Author: George Viaud

# Year: 2024
# License: MIT License (see LICENSE https://opensource.org/licenses/MIT)

ROOT_DIR=$(pwd)

# Initialize flag variables
perform_init=false
force_apply=false

# Check for --init and --force arguments
for arg in "$@"; do
  case $arg in
    --init)
      perform_init=true
      ;;
    --force)
      force_apply=true
      ;;
  esac
done

# Arrays to keep track of applied and skipped directories
applied_dirs=()
skipped_dirs=()

# Iterate over each subdirectory and apply Terraform configurations
for dir in "$ROOT_DIR"/*/; do
  cd "$dir" || exit

  if [ "$perform_init" = true ]; then
    terraform init
  fi

  planOutput=$(terraform plan -out=tfplan)

  # Check if changes are needed
  if echo "$planOutput" | grep -q "No changes."; then
    echo "$(basename "$dir") - No changes detected"
    skipped_dirs+=("$(basename "$dir") (No changes)")
  else
    echo "$planOutput"
    if [ "$force_apply" = true ]; then
      echo "Force applying $(basename "$dir")"
      terraform apply -auto-approve "tfplan"
      applied_dirs+=("$(basename "$dir")")
    else
      promptMsg=$(basename "$dir")" - Apply this plan? (y/[N]): "

      read -p "$promptMsg" apply_confirm
      if [[ $apply_confirm == [yY] ]]; then
        terraform apply "tfplan"
        applied_dirs+=("$(basename "$dir")")
      else
        echo "Skipped"
        skipped_dirs+=("$(basename "$dir") (User skipped)")
      fi
    fi
  fi

  cd "$ROOT_DIR" || exit
done

echo "Completed Terraform operations."

# Report which directories were applied and which were skipped
echo "Applied directories:"
for dir in "${applied_dirs[@]}"; do
  echo "- $dir"
done

echo "Skipped directories:"
for dir in "${skipped_dirs[@]}"; do
  echo "- $dir"
done

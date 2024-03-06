#!/bin/bash

# Script Name: Terraform Apply Recursive
# Description: Iterates over subdirectories to apply Terraform configurations selectively, with optional initialization.
# Author: George Viaud

# Year: 2024
# License: MIT License (see LICENSE https://opensource.org/licenses/MIT)

ROOT_DIR=$(pwd)

# Initialize flag variable
perform_init=false

# Check for --init argument
if [[ " $* " == *" --init "* ]]; then
  perform_init=true
fi

# Arrays to keep track of applied and skipped directories
applied_dirs=()
skipped_dirs=()

# Iterate over each subdirectory and apply Terraform configurations
for dir in "$ROOT_DIR"/*/; do
  cd "$dir" || exit

  # Run terraform init if --init argument was provided
  if [ "$perform_init" = true ]; then
    terraform init
  fi

  # Attempt to create a plan and direct output to a variable
  planOutput=$(terraform plan -out=tfplan)

  # Check if changes are needed
  if echo "$planOutput" | grep -q "No changes."; then
    echo "$(basename "$dir") - No changes detected"
    skipped_dirs+=("$(basename "$dir") (No changes)")
  else
    echo "$planOutput"
    # Construct the prompt message
    promptMsg=$(basename "$dir")" - Apply this plan? (y/[N]): "

    # Ask the user if they wish to apply the plan
    read -p "$promptMsg" apply_confirm
    if [[ $apply_confirm == [yY] ]]; then
      terraform apply "tfplan"
      applied_dirs+=("$(basename "$dir")")
    else
      echo "Skipped"
      skipped_dirs+=("$(basename "$dir") (User skipped)")
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

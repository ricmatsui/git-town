#!/usr/bin/env bash


function add_undo_steps {
  prepend_to_file "$1" "$UNDO_STEPS_FILE"
}


function undo_steps_for {
  local step_with_arguments
  read -a step_with_arguments <<< "$1" # Split string into array

  local step="${step_with_arguments[0]}"
  local arguments="${step_with_arguments[*]:1}"

  local fn="undo_steps_for_$step"

  if [ "$(type "$fn" 2>&1 | grep -c 'not found')" = 0 ]; then
    eval "$fn $arguments"
  fi
}

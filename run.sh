#!/bin/bash

child=1

_handle_term() {
  echo "run.sh Caught SIGTERM, forwarding to pid $child"
  kill -TERM "$child" 2>/dev/null
}

_handle_usr2() {
  echo "run.sh Caught SIGUSR2, forwarding to pid $child"
  kill -USR2 "$child" 2>/dev/null
}

_handle_quit() {
  echo "run.sh Caught SIGQUIT, forwarding to pid $child"
  kill -QUIT "$child" 2>/dev/null
}

_handle_int() {
  exec_after_terminate=bash
  echo "run.sh Caught SIGINT, forwarding to pid $child"
  kill -INT "$child" 2>/dev/null
}

trap _handle_term SIGTERM
trap _handle_quit SIGQUIT
trap _handle_usr2 SIGUSR2
trap _handle_int SIGINT

wrap() {
  declare desc="Proxy signals to the child process. Invoke shell on SIGINT"
  echo "Starting the child process, watching for SIGINT"

  echo "\$ $@ &"
  $@ &
  child=$!

  echo "Child process started has pid $child"
  wait $child
  wait $child
  echo "Child process $child exited with status $?"

  if [ -n "$exec_after_terminate" ]
  then
    echo "Running exec_after_terminate: '$exec_after_terminate'"
    exec $exec_after_terminate
  fi
}

run-commands() {
  declare desc="Run command words"
  declare type="$1"

  cmd="$CMD_PREFIX$(eval echo $@)"
  exec $cmd 2>&1
}

main() {
  declare desc="Kick off the run.sh script"
  declare type="$@"

  if [ $# -eq 0 ]; then
    echo "run.sh: No command words specified. Exiting"
  else
    run-commands "$@"
  fi
}

main "$@"

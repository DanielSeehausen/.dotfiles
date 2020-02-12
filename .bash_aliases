shopt -s expand_aliases

# return current vol or set if arg provided
vol () {
  if [ $# -eq 0 ]; then
    osascript -e 'output volume of (get volume settings)'
    return 1
  fi
  osascript -e "set Volume output volume $1"
}

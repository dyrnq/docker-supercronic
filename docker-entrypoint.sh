#!/bin/bash
set -eo pipefail
shopt -s nullglob
CRONTAB="${CRONTAB:-/etc/crontab}"
CRONTAB_IGNORE_NOT_EXIST=${CRONTAB_IGNORE_NOT_EXIST:-true}

# check arguments for an option that would cause mysqld to stop
# return true if there is one
_mysql_want_help() {
  local arg
  for arg; do
    case "$arg" in
      -'?'|--help|--version|-help|-version)
        return 0
        ;;
    esac
  done
  return 1
}


# copy that https://github.com/docker-library/mysql/blob/master/8.0/docker-entrypoint.sh
_main() {

  if [ "${1:0:1}" = '-' ]; then
    if _mysql_want_help "$@"; then
      exec supercronic "$@"
    else
      last_param=${@: -1}
      if [ ! "${last_param:0:1}" = '-' ]; then
          if [ -f ${last_param} ]; then
            set -- supercronic "${@:1:$#-1}" ${last_param}
          else
            if [ "${CRONTAB_IGNORE_NOT_EXIST}" = "true" ]; then
              echo "${last_param} file not exists. using default environment CRONTAB=${CRONTAB}" >&2
              set -- supercronic "${@:1:$#-1}" ${CRONTAB}
            else
              echo "${last_param} file not exists" >&2;
              exit 1;
            fi
          fi
      else
        set -- supercronic "$@" ${CRONTAB}
      fi
    fi
  else
    if type -P "${1}"; then
      exec "$@"
    else
      set -- supercronic "$@"
    fi
  fi
  exec "$@"
}

_main "$@"

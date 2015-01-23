#!/bin/sh

JSON_FILES=`find . -name '*.json' -type f`
for jf in ${JSON_FILES}; do

  # application default values (see: attributes/dump_node.rb)
  DIR="/tmp/test-helper"
  NODE="node.json"

  # platform dependent values
  case "$(basename $(dirname ${jf}))" in
    redhat|centos|oracle|amazon)
      PLATFORM_SAMPLE="known"
      ;;
    *)
      PLATFORM_SAMPLE="unknown"
      ;;
  esac

  # generate json files
  echo "*** regen: ${jf}"
  {
    cat << EOF
{
  "test-helper": {
    "dir": "@@DIR@@",
    "node": "@@NODE@@"
  }
}
EOF
  } | sed \
    -e "s|@@DIR@@|${DIR}|g" \
    -e "s|@@NODE@@|${NODE}|g" \
    -e "s|@@PLATFORM_SAMPLE@@|${PLATFORM_SAMPLE}|g" \
    > ${jf}

done

# # vim: ts=2 sts=2 sw=2 ai si et ft=sh

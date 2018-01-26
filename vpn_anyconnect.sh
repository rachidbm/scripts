#!/bin/bash
connect() {
  printf "y\n2\n<USERNAME>\n<PASSWORD>\ny" | /opt/cisco/anyconnect/bin/vpn -s connect 0.0.0.0
}

disconnect() {
  /opt/cisco/anyconnect/bin/vpn -s disconnect
}

usage() {
  echo "Usage: $0 \n-c:   to connect the vpn\n-d:   to disconnect the vpn" 1>&2; exit 1;
}

while getopts "cd" o; do
    case "${o}" in
        c)
            connect
            ;;
        d)
            disconnect
            ;;
        *)
            usage
            ;;
    esac
done

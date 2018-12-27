#!/bin/bash

if [ "${CONFIGURE_ACL}" = "true" ]; then
  echo "Waiting for contracts to be generated..."
  while [ ! -f "/contracts/ready" ]; do
    sleep 2
  done
  acl_contract=$(cat /contracts/AccessConditions.*.json | jq -r .address)
  sed -i -e "/acl_contract = .*/c acl_contract = \"${acl_contract:2}\"" /etc/parity/secretstore/config.toml
else
  sed -i -e "/acl_contract = .*/c acl_contract = \"none\"" /etc/parity/secretstore/config.toml
fi

/opt/parity/parity "$@"

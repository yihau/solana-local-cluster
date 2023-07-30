#!/usr/bin/env bash

nohup solana-validator \
  --no-os-network-limits-test \
  --identity id.json \
  --vote-account vote.json \
  --entrypoint 192.168.0.101:8001 \
  --rpc-faucet-address 192.168.0.101:9900 \
  --gossip-port 8001 \
  --rpc-port 8899 \
  --ledger ledger \
  --log logs/solana-validator.log \
  --full-rpc-api \
  --allow-private-addr \
  >logs/init-validator.log 2>&1 &

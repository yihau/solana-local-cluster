#!/usr/bin/env bash

./prepare-bootstrap-validator-keys.sh

./generate-genesis.sh

./bootstrap-validator.sh

./faucet.sh

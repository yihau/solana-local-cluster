#!/usr/bin/env bash

solana-keygen new --no-bip39-passphrase --silent -o id.json
echo "id: $(solana address -k id.json)"

solana-keygen new --no-bip39-passphrase --silent -o vote.json
echo "vote: $(solana address -k vote.json)"

solana-keygen new --no-bip39-passphrase --silent -o stake.json
echo "stake: $(solana address -k stake.json)"

solana -u http://192.168.0.101:8899 airdrop 500 id.json
solana -u http://192.168.0.101:8899 create-vote-account --allow-unsafe-authorized-withdrawer vote.json id.json id.json -k id.json
solana -u http://192.168.0.101:8899 create-stake-account stake.json 1.00228288 -k id.json
solana -u http://192.168.0.101:8899 delegate-stake stake.json vote.json --force -k id.json

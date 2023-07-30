# Solana Local Cluster

A step-by-step guide for starting a local cluster.

## Get Started

### Prequest

#### setup
follow https://docs.solana.com/running-validator/validator-start#system-tuning

### Docker

#### Clone this repo

```
git clone https://github.com/yihau/solana-local-cluster.git
```

#### Create a network
```
docker network create --driver=bridge --subnet=192.168.0.0/8 solana-cluster
```

#### Create two nodes

```
docker run -it --name validator-1 --network=solana-cluster --ip=192.168.0.101 ubuntu:20.04 bash
docker run -it --name validator-2 --network=solana-cluster --ip=192.168.0.102 ubuntu:20.04 bash
```

#### Setup

##### copy workspace into containers
```
docker cp workspace validator-1:/workspace
docker cp workspace validator-2:/workspace
```

##### install dependencies for containers
```bash
apt update && apt install curl -y && sh -c "$(curl -sSfL https://release.solana.com/v1.16.5/install)" && export PATH="/root/.local/share/solana/install/active_release/bin:$PATH"
```

#### Start a bootstarp validator

switch to `validator-1` container

```bash
cd workspace && ./start-bootstrap-validator.sh
```

you can use these commands to check the cluster status

```bash
solana -ul validators
solana -ul gossip
```

(If it doesn't look correct, maybe there is some information in `/workspace/logs`)

#### Start a validator

switch to `validator-2` container

```bash
cd workspace && ./start-validator.sh
```

You can switch back to `validator-1` and check cluster status to know if `validator-2`` has cme on board

### Additional Details

#### SPL programs

If you want to start a cluster that includes the SPL programs, you can

1. fetch spl programs
```bash
cd workspace && bash <(curl -s https://raw.githubusercontent.com/solana-labs/solana/v1.16/fetch-spl.sh)
```

2. it will generate a file called `spl-genesis-args.sh`. Add it to `generate-genesis.sh` like

```diff
solana-genesis \
  --enable-warmup-epochs \
  --bootstrap-validator id.json vote.json stake.json \
  --bootstrap-validator-stake-lamports 10002282880 \
  --max-genesis-archive-unpacked-size 1073741824 \
  --faucet-pubkey faucet.json \
  --faucet-lamports 500000000000000000 \
  --hashes-per-tick auto \
  --cluster-type development \
+ $(cat spl-genesis-args.sh) \
  --ledger ledger
```

3. now you can start a cluster with SPL programs
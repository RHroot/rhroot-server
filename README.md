## Just Run this command first to set a swap file so you can rebuild easily on nixos

```bash
sudo mkdir -p /swap && sudo fallocate -l 4G /swap/swapfile && sudo chmod 600 /swap/swapfile && sudo mkswap /swap/swapfile && sudo swapon /swap/swapfile && echo '/swap/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

## And also the commands to make the keys to use with WireGuard

```bash
wg genkey | tee /etc/wireguard/server.key | wg pubkey > /etc/wireguard/server.pub && chmod 600 /etc/wireguard/server.key
```

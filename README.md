# My HomeLab Proxmox Infrastructure as Code using Terraform and Terragrunt

## Configuration

Terraform [bpg proxmox provider](https://registry.terraform.io/providers/bpg/proxmox/latest/docs) allows to use Token or SSH authentication. I'm using SSH as it allows to perform all required operations.

Credentials are stored in `.env` file and automatically loaded by [dotenv plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dotenv).

```bash
# .env example
PROXMOX_VE_ENDPOINT="https://a.b.c.d:8006"
PROXMOX_VE_USERNAME="root@pam"
PROXMOX_VE_PASSWORD="YourRootPasswordHere"
```

## Run

```bash
cd silverstone/
terragrunt run-all apply
```

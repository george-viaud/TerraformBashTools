# Terraform Bash Tools
Useful bash scripts for use with Terraform cli
***

## Disclaimer

These scripts are provided "as-is," without warranty of any kind. Use of these scripts is at your own risk. The author is not responsible for any costs, damages, or service interruptions that may occur as a result of their use. Ensure you have proper backups and fully understand the impact of operations such as refreshing Auto Scaling Groups within your environment. It is strongly recommended to test the scripts' functionality in a non-production environment before deploying them in production.

## Suggested installation
To make the scripts available from anywhere in shell, Move the project folder to `/opt/` (or similar)
```bash
sudo mv TerraformBashTools /opt/
```
dd the script's location to your `PATH` by appending it to your `~/.bashrc` or `~/.zshrc` file:
```bash
echo 'export PATH="$PATH:/opt/TerraformBashTools"' >> ~/.bashrc
```
Then, source your `.bashrc` or `.zshrc` to apply the changes:
```bash
source ~/.bashrc
```

***
### Terraform Apply Recursive

A Bash script to iteratively apply Terraform configurations in subdirectories, with optional support for initialization.

## Usage
```bash
./tf-apply-recursive.sh [--init] [--force]
```

`--init` flag runs `terraform init` prior to apply
`--force` will automatically changes apply without asking the user (no prompts)
***

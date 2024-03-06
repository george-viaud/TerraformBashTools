# Terraform Bash Tools
Useful bash scripts for use with Terraform cli
***

## Disclaimer

These scripts are provided "as-is," without warranty of any kind. Use of these scripts is at your own risk. The author is not responsible for any costs, damages, or service interruptions that may occur as a result of their use. Ensure you have proper backups and fully understand the impact of operations such as refreshing Auto Scaling Groups within your AWS environment. It is strongly recommended to test the scripts' functionality in a non-production environment before deploying them in production.

## Suggested installation
To make the scripts available from anywhere in shell, Move the project folder to `/opt/` (or similar)
```bash
sudo mv TerraformBashTools /opt/
```
Then add it to your `PATH`
```bash
echo 'export PATH="$PATH:/opt/TerraformBashTools"' >> ~/.bashrc
```
Note: Path will be applied only after shell is restarted
***
### Terraform Apply Recursive

A Bash script to iteratively apply Terraform configurations in subdirectories, with optional support for initialization.

## Usage
```bash
./tf-apply-recursive.sh [--init]
```
***

# TerraformBashTools
Useful bash scripts for use with Terraform cli
***

## Suggested installation
Move the project folder to `/opt/` (or similar)
```bash
sudo mv TerraformBashTools /opt/
```
Then add it to your `PATH`
```bash
echo 'export PATH="$PATH:/opt/TerraformBashTools"' >> ~/.bashrc
```

### Terraform Apply Recursive

A Bash script to iteratively apply Terraform configurations in subdirectories, with optional support for initialization.

## Usage
```bash
./tf-apply-recursive.sh [--init]
```
***

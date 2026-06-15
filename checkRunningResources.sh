#!/bin/bash

PARENT_DIR="${1:-.}"

for dir in "$PARENT_DIR"/*/; do
    if [ -f "${dir}/terraform.tfstate" ] || [ -d "${dir}/.terraform" ]; then
        echo "=================================================="
        echo "Checking: $dir"
        echo "=================================================="

        (
            cd "$dir" || exit

            terraform state list 2>/dev/null

            if [ $? -ne 0 ]; then
                echo "No accessible Terraform state found"
            fi
        )

        echo
    fi
done
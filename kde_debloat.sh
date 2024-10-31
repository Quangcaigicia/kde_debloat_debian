#!/bin/bash

# Define the filenames
files=('office.txt' 'internet.txt' 'system.txt' 'graphics.txt' 'network.txt' 'multimedia.txt' 'development.txt' 'education.txt' 'utilities.txt')

# Initialize an array to hold the packages
packages=()

# Read package names from each file
for file in "${files[@]}"; do
    if [[ -f "$file" ]]; then
        mapfile -t file_packages < "$file"
        packages+=("${file_packages[@]}")
    else
        echo "File $file not found."
    fi
done

# Check if there are any packages to uninstall
if [ ${#packages[@]} -eq 0 ]; then
    echo "No packages to remove."
    exit 0
fi

# Print the packages to be removed for debugging
echo "Removing the following packages: ${packages[*]}"

# Attempt to remove each package individually
for package in "${packages[@]}"; do
    echo "Trying to remove package: $package"
    yes | sudo apt remove --purge "$package"
done

# Clean up and update
yes | sudo apt autoremove
sudo apt update
yes | sudo apt upgrade

#!/bin/bash

set -e  # exit on error

# Variables
APP_DIR="/var/www/Portfolio/client"
BUILD_DIR="$APP_DIR/dist"
REPO_DIR="$WORKSPACE"   # Jenkins workspace
TARGET_DIR="/var/www/Portfolio/client"

echo "===== Starting Deployment ====="

# Go to Jenkins workspace
cd "$REPO_DIR"

echo "===== Installing Dependencies ====="
npm install

echo "===== Building Project ====="
npm run build

echo "===== Syncing Files to Target Directory ====="
# Sync only build output (recommended)
sudo rsync -av --delete "$BUILD_DIR/" "$TARGET_DIR/"

echo "===== Fixing Permissions ====="
sudo chown -R www-data:www-data "$TARGET_DIR"

echo "===== Restarting Nginx ====="
sudo systemctl restart nginx

echo "===== Deployment Completed Successfully ====="
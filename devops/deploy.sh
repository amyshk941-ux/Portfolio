#!/bin/bash
set -e

REPO_DIR="$WORKSPACE"
APP_DIR="$REPO_DIR/client"
BUILD_DIR="$APP_DIR/dist"
TARGET_DIR="/var/www/Portfolio/client"

echo "===== Starting Deployment ====="

cd "$APP_DIR"

echo "===== Installing Dependencies ====="
npm install

echo "===== Building Project ====="
npm run build

echo "===== Syncing Files ====="
sudo rsync -av --delete "$BUILD_DIR/" "$TARGET_DIR/"

echo "===== Fix Permissions ====="
sudo chown -R www-data:www-data "$TARGET_DIR"

echo "===== Restarting Nginx ====="
sudo systemctl restart nginx

echo "===== Done ====="
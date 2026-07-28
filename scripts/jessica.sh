#!/bin/bash

###############################################################################
# Project Jessica
# Version: 0.1.0
#
# Purpose:
#   Prepare the development workspace and verify that the environment
#   is ready for coding.
#
# Author:
#   Justin Stuart
###############################################################################

clear

echo "=================================================="
echo "              PROJECT JESSICA v0.1"
echo "=================================================="
echo ""

echo "👋 Hello, Justin!"
echo ""

echo "Checking development environment..."
echo ""

echo "🐧 Operating System : $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')"
echo "👤 User             : $(whoami)"
echo "🕒 Time             : $(date '+%A %b %d %I:%M %p')"
echo ""

echo "Checking Git..."

if command -v git >/dev/null; then
    echo "✅ Git Installed"
else
    echo "❌ Git Missing"
fi

echo ""

echo "Checking Docker..."

if command -v docker >/dev/null; then
    echo "✅ Docker Installed"
else
    echo "❌ Docker Missing"
fi

echo ""

echo "Current Project"

cd ~/projects/code-platoon-learning/projects/task-manager-api || exit

pwd

echo ""

git status

echo ""
echo "=================================================="
echo " Jessica is ready."
echo "=================================================="

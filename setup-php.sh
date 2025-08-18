#!/bin/bash
# Setup script for PHP development tools

echo "🐘 Setting up PHP development environment for Neovim..."

# Check if composer is installed
if ! command -v composer &> /dev/null; then
    echo "❌ Composer is not installed. Please install Composer first:"
    echo "   https://getcomposer.org/download/"
    exit 1
fi

# Check if PHP is installed
if ! command -v php &> /dev/null; then
    echo "❌ PHP is not installed. Please install PHP 8.0 or higher"
    exit 1
fi

echo "✅ PHP version: $(php -v | head -n 1)"
echo "✅ Composer version: $(composer --version)"

# Install global composer packages
echo ""
echo "📦 Installing global Composer packages..."

# Laravel installer
if ! command -v laravel &> /dev/null; then
    echo "Installing Laravel installer..."
    composer global require laravel/installer
fi

# PHP CS Fixer
if ! command -v php-cs-fixer &> /dev/null; then
    echo "Installing PHP CS Fixer..."
    composer global require friendsofphp/php-cs-fixer
fi

# PHPStan
if ! command -v phpstan &> /dev/null; then
    echo "Installing PHPStan..."
    composer global require phpstan/phpstan
fi

# Add composer bin to PATH if not already there
COMPOSER_BIN="$HOME/.composer/vendor/bin"
if [[ ":$PATH:" != *":$COMPOSER_BIN:"* ]]; then
    echo ""
    echo "⚠️  Add this to your shell configuration (.bashrc, .zshrc, etc.):"
    echo "   export PATH=\"\$PATH:$COMPOSER_BIN\""
fi

echo ""
echo "📋 Checklist for PHP development:"
echo "   ✓ Install Intelephense license (optional but recommended)"
echo "     https://intelephense.com/"
echo "   ✓ Configure Xdebug for debugging (optional)"
echo "   ✓ Install Node.js for Laravel Mix/Vite"
echo ""
echo "🚀 Next steps:"
echo "   1. Restart Neovim"
echo "   2. Run :Mason to verify PHP tools are installed"
echo "   3. Open a PHP file and wait for LSP to initialize"
echo "   4. Use <leader>p? to see PHP/Laravel keybindings"
echo ""
echo "✨ Happy PHP coding!"
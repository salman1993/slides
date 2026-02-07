# List available commands
default:
    @just --list

# Create a new slide deck from the example template
new name:
    cp -r example "{{name}}"
    cd "{{name}}" && bun install
    @echo "Created '{{name}}/' — edit {{name}}/slides.md to get started"
    @echo "Run: just dev {{name}}"

# Start the dev server for a deck
dev name:
    cd "{{name}}" && bun run dev

# Build a deck as a static SPA
build name:
    cd "{{name}}" && bun run build

# Export a deck to PDF (requires playwright: bunx playwright install)
export name:
    cd "{{name}}" && bun run export

# Install dependencies for a deck
install name:
    cd "{{name}}" && bun install

# Install dependencies for all decks
install-all:
    #!/usr/bin/env bash
    for dir in */; do
        if [ -f "$dir/package.json" ]; then
            echo "Installing $dir..."
            (cd "$dir" && bun install)
        fi
    done

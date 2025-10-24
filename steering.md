# Development Environment & Tools

## ⚠️ CRITICAL: Modern CLI Tools Required

This project uses modern CLI tools for better performance and developer experience.
Claude MUST use these tools instead of traditional Unix commands.

---

## 🔍 Search in Files: Ripgrep (rg)

**ALWAYS use `rg` instead of `grep`**

### Basic Usage
```bash
# Search for text
rg "search_term"

# Case-insensitive search
rg -i "search_term"

# Search specific file types
rg "search_term" -t js -t ts -t tsx

# Search with line numbers and context
rg -n -C 3 "search_term"
```

### Common Patterns
```bash
# Find TODO/FIXME comments
rg "TODO|FIXME|XXX|HACK"

# Find all imports of a module
rg "import.*from.*react"

# Find function definitions
rg "function\s+\w+|const\s+\w+\s*=\s*\(" -t ts -t js

# Find API routes
rg "app\.(get|post|put|delete|patch)" -t ts

# Find console statements (for cleanup)
rg "console\.(log|warn|error|debug)"

# Find environment variables usage
rg "process\.env\." -t ts -t js

# Search excluding directories
rg "search_term" --glob '!node_modules/*' --glob '!dist/*'
```

### Advanced Usage
```bash
# List only filenames containing pattern
rg -l "pattern"

# Count matches per file
rg -c "pattern"

# Show only matching parts
rg -o "pattern"

# Multi-line search
rg -U "pattern.*\n.*another_pattern"

# Search in specific directory
rg "pattern" src/components/

# Replace preview (doesn't modify files)
rg "oldText" --files-with-matches
```

### Performance Notes
- Ripgrep automatically respects .gitignore
- 10-100x faster than grep on large codebases
- Parallel search by default

---

## 📁 Find Files: fd

**ALWAYS use `fd` instead of `find`**

### Basic Usage
```bash
# Find files by name
fd "filename"

# Find files by extension
fd -e js -e ts

# Case-insensitive search
fd -i "readme"

# Include hidden files
fd -H "config"

# Search in specific directory
fd "component" src/
```

### Common Patterns
```bash
# Find all TypeScript files
fd -e ts -e tsx

# Find all test files
fd "test|spec" -e ts -e tsx -e js

# Find all config files
fd "config|rc|.json|.yaml" -t f

# Find directories only
fd -t d "components"

# Find files modified in last 24 hours
fd -e ts --changed-within 24h

# Exclude directories
fd "pattern" --exclude node_modules --exclude dist

# Execute command on results
fd -e js -x prettier --write {}
```

### Integration with Other Tools
```bash
# Open all matching files in editor
fd "Button" -e tsx -x code {}

# Delete all matching files (use carefully!)
fd -e log -e tmp -x rm {}

# List with details using eza
fd "component" -e tsx -x eza -l {}
```

---

## 👁️ View Files: bat

**ALWAYS use `bat` instead of `cat`**

### Basic Usage
```bash
# View file with syntax highlighting
bat filename.ts

# View with line numbers
bat -n filename.ts

# View multiple files
bat file1.ts file2.ts

# Show non-printable characters
bat -A filename.ts
```

### Common Patterns
```bash
# View specific lines
bat -r 10:20 filename.ts

# View without decorations (plain mode)
bat -p filename.ts

# View diff
git diff | bat -l diff

# View with paging
bat --paging=always large-file.log

# Compare files side by side (with delta)
bat file1.ts file2.ts

# View markdown with rendering
bat README.md
```

### Integration
```bash
# Use as PAGER
export PAGER="bat"

# Use with man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Pipe from other commands
rg "pattern" -A 5 | bat -l js
```

---

## 📋 List Directory: eza

**ALWAYS use `eza` instead of `ls`**

### Basic Usage
```bash
# List files
eza

# List with details
eza -l

# List all files including hidden
eza -a

# List with git status
eza -l --git

# Tree view
eza -T

# Tree with depth limit
eza -T -L 2
```

### Common Patterns
```bash
# Detailed list with icons and git status
eza -la --icons --git

# Sort by modified time
eza -l --sort=modified

# Sort by size
eza -l --sort=size

# Show only directories
eza -D

# Show file sizes in human-readable format
eza -lh

# Show extended attributes and metadata
eza -l@ --git

# Group directories first
eza -l --group-directories-first

# Show tree with git ignore
eza -T --git-ignore

# Custom time format
eza -l --time-style=long-iso
```

### Useful Aliases (for reference)
```bash
# These are just examples of common usage patterns
alias ll="eza -la --icons --git"
alias lt="eza -T -L 2 --icons"
alias lta="eza -T --icons --git-ignore"
```

---

## 💾 Disk Usage: dust

**ALWAYS use `dust` instead of `du`**

### Basic Usage
```bash
# Show disk usage
dust

# Limit depth
dust -d 1

# Show specific directory
dust src/

# Sort by size
dust -r
```

### Common Patterns
```bash
# Show only directories larger than 100MB
dust -d 2 -r | head -20

# Exclude node_modules
dust -X node_modules

# Show in different formats
dust -b  # bytes
dust -p  # percentage

# Find large directories
dust -d 1 -r | head -10

# Interactive mode with bar chart
dust -n 20
```

---

## 🎯 When to Use Which Tool

| Task | Use | Example |
|------|-----|---------|
| Search for text in code | `rg` | `rg "useState"` |
| Find files by name | `fd` | `fd "Button.tsx"` |
| View file contents | `bat` | `bat src/App.tsx` |
| List directory contents | `eza` | `eza -la --icons` |
| Check disk space | `dust` | `dust -d 2` |
| Find large files | `dust` + `fd` | `dust -r \| head -10` |
| Search and open files | `rg` + `fd` | `fd -e tsx \| rg "useState"` |

---

## 🔄 Command Replacements Reference

### Never Use → Always Use
```bash
# ❌ DON'T USE
grep -r "pattern" .
find . -name "*.js"
cat file.ts
ls -la
du -sh *

# ✅ USE INSTEAD
rg "pattern"
fd -e js
bat file.ts
eza -la --icons
dust
```

---

## 📦 Installation Verification

Before starting work, verify these tools are installed:
```bash
# Check all tools
rg --version
fd --version
bat --version
eza --version
dust --version
```

If any tool is missing, install with:
```bash
# macOS
brew install ripgrep fd bat eza dust

# Ubuntu/Debian
sudo apt install ripgrep fd-find bat
cargo install eza dust
```

---

## 🎨 Configuration Files

### ~/.ripgreprc
```
--smart-case
--hidden
--glob=!.git/*
--glob=!node_modules/*
--glob=!dist/*
```

### ~/.config/bat/config
```
--theme="Dracula"
--style="numbers,changes,header"
```

---

## 💡 Common Workflows

### Finding and Fixing Issues
```bash
# 1. Find all TODOs
rg "TODO" -t ts -t tsx

# 2. List files with TODOs
rg "TODO" -l

# 3. View a specific file
bat $(rg "TODO" -l | head -1)

# 4. Find related test files
fd "$(basename file.tsx .tsx).test.tsx"
```

### Code Cleanup
```bash
# Find unused imports
rg "^import.*from" -t ts -t tsx | rg -v "@/"

# Find console.logs
rg "console\.(log|debug)" -t ts -t tsx

# Find large files
dust -d 1 src/ | head -10
```

### Performance Analysis
```bash
# Find large components
fd -e tsx src/components/ -x wc -l {} | sort -rn | head -10

# Check bundle size contributors
dust dist/ -d 2
```

### Refactoring
```bash
# Find all usages of old function name
rg "oldFunctionName" -l

# Preview files to change
rg "oldFunctionName" -l | xargs bat

# Find component dependencies
rg "import.*Button" src/
```

---

## 🚫 Forbidden Commands

Never use these commands in this project:
- `grep` (use `rg`)
- `find` with `-name` (use `fd`)
- `cat` (use `bat`)
- `ls` (use `eza`)
- `du` (use `dust`)

---

## ⚡ Performance Tips

1. **Ripgrep**: Use file type filters (`-t`) to speed up searches
2. **fd**: Use `--max-depth` to limit recursion
3. **bat**: Use `-p` (plain) for piping to other commands
4. **eza**: Use `--git-ignore` for faster tree views in large repos
5. **dust**: Use `-d` to limit depth for faster results

---

## 🔗 Tool Combinations

### Example 1: Find and edit files with pattern
```bash
fd -e tsx | xargs rg -l "useState" | xargs code
```

### Example 2: View all components using a hook
```bash
rg -l "useAuth" src/components/ | xargs bat
```

### Example 3: Clean up large files
```bash
dust -d 2 src/ | head -5
fd -e log -e cache -x rm {}
```

### Example 4: Find recent changes
```bash
fd -e ts --changed-within 1d | xargs eza -l
```

---

## 📚 Additional Resources

- Ripgrep: https://github.com/BurntSushi/ripgrep
- fd: https://github.com/sharkdp/fd
- bat: https://github.com/sharkdp/bat
- eza: https://github.com/eza-community/eza
- dust: https://github.com/bootandy/dust

---

## 🎓 Learning Tips

Start with these commands and expand gradually:
1. `rg "pattern"` - Your new best friend for searching
2. `fd "name"` - Fast file finding
3. `bat file` - Prettier file viewing
4. `eza -la --icons --git` - Beautiful directory listing
5. `dust` - Quick disk usage check

Remember: These tools are faster, more intuitive, and provide better output than traditional Unix commands.

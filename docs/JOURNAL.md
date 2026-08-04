# 2026-08-04

## Session Milestones

- Set up Project Jessica as its own VS Code Remote SSH workspace.
- Configured the integrated terminal to open in the project root.
- Added an automatic VS Code task that launches the Jessica dashboard.
- Built a dedicated macOS launcher for Project Jessica.
- Designed the official blue-and-purple Jessica logo.
- Built the first reusable UI library.
- Learned how function parameters and default values work.
- Learned the difference between programs, scripts, files, and functions.
- Created project documentation for context, sessions, the roadmap, and the journal.

## What I Learned

- `source` loads functions into the current shell.
- A function cannot be called until the file containing it has been loaded.
- `${1:-default}` uses the first argument when provided and a default value otherwise.
- VS Code workspaces can store project-specific terminal and startup behavior.
- The Linux repository is the project source of truth.
- Mac launcher files and generated icon files are local machine-specific assets.

## What Challenged Me

- Understanding why `ui_header` worked inside Jessica but not directly in the terminal.
- Keeping the Mac files and Linux project files organized correctly.
- Understanding when an old function was clearing the new UI header.

## What Finally Clicked

- The launcher starts the program.
- The program sources scripts and libraries.
- Those files define reusable functions.
- The router calls the correct function.
- Each part should have one clear responsibility.

## Reflection

I do not want to be a vibe coder. I want to understand how the software works so I can troubleshoot it, repair it, and improve it.

Project Jessica exists because I had a vision to create a program that could help not just me, but anyone who needs her.
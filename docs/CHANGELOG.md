## v0.5.0 — Foundation & Identity

### Added

- Modular command architecture
- Reusable UI library in `lib/ui.sh`
- Parameterized `ui_header()` function
- Interactive `jessica add` command
- `jessica remember` alias
- VS Code Remote SSH workspace
- Automatic Jessica startup task
- Dedicated macOS Project Jessica launcher
- Official blue-and-purple Jessica branding
- Project documentation structure
- Developer journal
- Project context file
- Current-session file

### Improved

- Dashboard layout and spacing
- Project organization
- Function reuse
- Command routing
- Development startup workflow

### Next

- Finish v0.5 documentation
- Commit and tag v0.5.0
- Begin v0.6 session and context tools

## v0.5.5 — Secure Remote Access

### Added

- Installed and configured Tailscale on `js-server`
- Connected the MacBook, iPhone, and iPad Mini to the tailnet
- Renamed Tailscale devices using the `js-` naming convention
- Added the `js-server` SSH alias
- Updated VS Code Remote SSH to connect through Tailscale
- Updated Project Jessica.app to open the remote workspace through `js-server`

### Improved

- Project Jessica can now be reached securely without opening router ports
- The same launcher works at home or away
- Remote development no longer depends on the local `192.168.1.200` address

### Remaining Test

- Confirm the full workflow from outside the home network

### Name Chnage

- Changed from Project Jessica to Jessica OS
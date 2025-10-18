# Vanish Car Wipes

Lightweight FiveM resource that periodically removes unoccupied vehicles to keep your world clean and performant. Includes a manual admin command and configurable warning notifications.

## Requirements
- `ox_lib` (ensure this resource is started before this one)
- Optional: `cron` resource (only if using exact-time schedules)

## Installation
1. Place the `vanish_carwipes` folder in your server `resources`.
2. In `server.cfg` (order matters):
   - `ensure ox_lib`
   - `ensure vanish_carwipes`

## Usage
- Manual cleanup (admin only by default): `/delallveh`
- Automatic cleanup runs based on `shared/config.lua` settings.

## Configuration (shared/config.lua)
```lua
return {
  command = { enabled = true, restricted = { 'group.admin' } },
  periodic = {
    enabled = true,
    mode = 'interval',         -- 'interval' or 'cron'
    intervalMinutes = 60,      -- for mode 'interval'
    runAt = { '06:00','12:00','18:00','00:00' }, -- for mode 'cron'
    minPlayers = 0             -- only run if player count >= this value
  },
  timeBeforeWipe = 5,          -- minutes between first warn and wipe
  warnings = { enabled = true, stages = { 0.5, 0.25, 0.10 } }
}
```

Tips
- For quick testing, set `timeBeforeWipe` to a small value (e.g., 1) and use short `intervalMinutes`.
- If `cron` is not running, the script automatically falls back to `interval` mode.

## Permissions (ACE examples)
Grant the manual command to admins only:
```
add_ace group.admin command.delallveh allow
```
Adjust `command.restricted` in `shared/config.lua` to fit your permission groups.

## Localization
Edit `locales/en.json` to change warning/complete messages.

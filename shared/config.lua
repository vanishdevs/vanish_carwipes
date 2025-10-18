return {
  command = {
    enabled = true,
    restricted = { 'group.admin' }
  },

  -- Periodic wipe scheduler (server-side)
  -- mode = 'interval' uses intervalMinutes. mode = 'cron' uses runAt times (HH:MM, 24h).
  periodic = {
    enabled = true,
    mode = 'interval',         -- 'interval' or 'cron'
    intervalMinutes = 60,      -- when mode = 'interval'
    runAt = { '00:00', '06:00', '12:00', '18:00' }, -- when mode = 'cron'
    minPlayers = 0             -- require at least this many players to run
  },

  -- Minutes before the wipe executes (client warnings use this window)
  timeBeforeWipe = 5,

  -- Warning schedule configuration (client-side)
  warnings = {
    enabled = true,              -- set to false to disable warnings
    stages = { 0.5, 0.25, 0.10 } -- fractions of time remaining to warn
  }
}

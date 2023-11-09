# Vehicle Cleanup Script

The Vehicle Cleanup Script is a FiveM resource that automatically removes unoccupied vehicles in the game world, enhancing server performance and cleanliness. It provides both automatic cleanup at a specified time and manual cleanup triggered by a command.

## Installation

1. **Download:** Download the `AutomaticCarWipes` folder.
2. **Placement:** Place the folder into your FiveM server's resources directory.
3. **Configuration:** Add `start AutomaticCarWipes` to your `server.cfg` file to ensure the script is loaded when your server starts.

## How It Works

- **Automatic Cleanup:** Unoccupied vehicles are deleted at the specified cleanup time (configurable in `config.lua`).
- **Manual Cleanup:** Use the `/delallveh` command in the game chat to trigger cleanup manually. (Permission required for manual usage)

## Commands

- `/delallveh` - Manually triggers the vehicle cleanup process. (Permission required for manual usage)

## Configuration

Open the `config.lua` file to customize the script:

- **Manual Cleanup Command:** Change the command used for manual cleanup.
- **Admin Command:** Set to true to restrict manual cleanup to admin users only. Set to false to allow any user to trigger cleanup.
- **Automatic Cleanup Time:** Set the hour (in server time) when automatic cleanup occurs.
- **Cleanup Warning Time:** Set the duration (in minutes) before the cleanup warning is broadcasted.

## Frequently Asked Questions (FAQ)

**Q: What does this script do?**  
A: This script automatically removes unoccupied vehicles in the game world, enhancing server performance and cleanliness.

**Q: How do I manually trigger the cleanup?**  
A: Use the `/delallveh` command in the game chat. Ensure you have the necessary permissions to use this command.

**Q: Can I change the cleanup schedule?**  
A: Yes, you can modify the `cleanuptime` variable in the configuration to set a different hour for automatic cleanup.

**Q: How do I grant permission to use the manual cleanup command to specific users?**  
A: If `admincommand` is set to true, users with the appropriate permission (e.g., `command.delallveh`) can use the manual cleanup command. Configure your permissions system accordingly.

**Q: How can I modify the cleanup warning duration?**  
A: Adjust the `timebeforecleanup` variable in the configuration to change the duration (in minutes) before the cleanup starts.

**Q: What happens to occupied vehicles during cleanup?**  
A: Occupied vehicles and their occupants are not affected by the cleanup process. Only unoccupied vehicles are removed.

For further assistance, contact me or refer to the [FiveM documentation](https://docs.fivem.net/).

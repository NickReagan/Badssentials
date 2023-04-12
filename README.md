# This README is no longer updated, please refer to https://docs.badger.store/fivem-misc.-scripts/badssentials for documentation 

## What is it?
Badssentials is essentially the most essential script you need. I saw multiple scripts split up and never saw a single script like this. I figured, I might as well make one, so I did. Badssentials includes AOP, PeaceTime, postal waypointing, and configurable placeholder watermarks! The amount of possibilities is endless with this script! Make sure you take a look at `Screenshots` to see what you can make with this!
## Screenshots

![](https://i.gyazo.com/07b89a6d03ac42f4cf496265d1e55c4f.png)

![https://i.gyazo.com/557c43a66a594cfda785ffeda51c8fc3.gif](https://i.gyazo.com/557c43a66a594cfda785ffeda51c8fc3.gif)

## Commands

`/postal <code>` - Sets your waypoint to this postal code's location

`/postal` - Cancels your waypoint

`/aop <zone>` - Sets the AOP to text you put in <zone>
  
`/peacetime` - Toggles PeaceTime on and off
  
`/pt` - Toggles PeaceTime on and off
  
`/toggle-hud` - Toggles your HUD on and off
  
## Permissions

`Badssentials.Announce` - Gives permission to use the /announce command.

`Badssentials.AOP` - Gives permission to use the /aop command

`Badssentials.Revive` - Gives permission to revive others.

`Badssentials.Bypass.Revive` - Gives permission to bypass revive timer.

`Badssentials.Bypass.Respawn` - Gives permission to bypass respawn timer.

`Badssentials.PeaceTime` - Gives permission to use both /peacetime and /pt command

## Configuration

```lua
Config = {
	Prefix = '^5[^1Badssentials^5] ^3',
	ScreenAffects = {
		AnnounceCommand = "announce",
        AcePermission = "Badssentials.Announce", --The ace permission need to run the AnnounceCommand.
		AnnouncementHeader = '~b~[~p~Announcement~b~]',
		AnnouncementPlacement = 0, -- Set to 0 for top or .3 for middle of screen
		AnnounceDisplayTime = 15, -- How many seconds should announcements display for?
		DeathScreen = true, -- Enable/Disable the death screen. (Enabled by default.) (ReviveSystem.enable must also be true!)
        DeathScreenDisplaySettings = { 
            --[[
            Display used when DeathScreen = true
            Available Placeholders;
            {REVIVE_COMMAND} | Returns the Set Revive Command.
            {RESPAWN_COMMAND} | Returns the set respawn command.
            ]]
            ['Line 1'] = {
                text = "~r~You are knocked out or dead...",
                x = .5,
                y = .05,
                scale = .8,
                center = true,
            },
            ['Line 2'] = {
                text = "~b~If you were knocked out, you may use ~g~{REVIVE_COMMAND}~b~!",
                x = .5,
                y = .1,
                scale = .8,
                center = true,
            },
            ['Line 3'] = {
                text = "~b~If you are dead, you must use ~g~{RESPAWN_COMMAND}~b~!",
                x = .5,
                y = .15,
                scale = .8,
                center = true,
            },
        },
	},
    AOPSystem = {
        DefaultAOP = "Sandy Shores",
        AOPCommand = "aop",
        --Announcement sent to players when AOP is changed. Set to "", or nil to disable.
        AOP_Announcement = "The AOP has changed to '{NEW_AOP}'. Finish your current scene(s) and head to {NEW_AOP}. ^1Failure to do so could lead to punishment!^0",
        AOP_AcePermission = "Badssentials.AOP", --The ace permission need to run the AOPCommand.
        SetAOPAsMapName = true, --This will set the map name to the current aop. This affects the "map name" on the server list, etc.
    },
    ReviveSystem = {
        enable = true, --Enable/Disable Revive System
        enableBypassLocations = true,
        Revive_Delay = 120, -- Set to 0 to disable 
        Respawn_Delay = 60, -- Set to 0 to disable
        RespawnCommand = "respawn",
        RespawnMessage = "Respawned successfully!", --Message sent when player respawns.
        RespawnErrorMessage = "^1ERROR: You cannot respawn, you still have ^7{RESPAWN_TIME_LEFT} ^1remaining...", --Message sent to user when they can't respawn. Use {TIME_LEFT} to show how long they have to respawn.
        ReviveCommand = "revive",
        ReviveMessage = "Revived successfully!", --Message sent when player revives.
        ReviveOtherSuccessMessage = "You have revived player ^5{PLAYER_NAME} ^0successfully!", --Message sent to player when they successfully revived someone else.
        ReviveErrorMessage = "^1ERROR: You cannot revive, you still have ^7{REVIVE_TIME_LEFT} ^1remaining...",
        ReviveOthersAcePermission = "Badssentials.Revive", --The ace permission required to revive other players.
        ReviveOthersMessage = "You have been revived by ^5{PLAYER_NAME}^0.", --Message sent to user after being revived by someone else. Use {PLAYER_NAME} for the staff member's name.
        BypassReviveAcePermission = "Badssentials.Bypass.Revive", --The ace permission required to revive yourself with no cooldown.
        BypassRespawnAcePermission = "Badssentials.Bypass.Respawn", --The ace permission required to respawn with no cooldown.
        RespawnLocations = {
            DefaultLocation = {
                --Sandy Shores Medical Center
                x = 1827.26,
                y = 3693.58,
                z = 34.22,
            },
            ['Los Santos'] = {
                --Pillbox Hill Medical Center
                x = 298.2,
                y = -584.17,
                z = 43.26,
            },
            ['Sandy Shores'] = {
                --Paleto Bay Medical Center
                x = -248.1,
                y = 6332.6,
                z = 32.43,
            },
            ['Blaine County'] = {
                --Paleto Bay Medical Center
                x = -248.1,
                y = 6332.6,
                z = 32.43,
            },
            ['Paleto Bay'] = {
                --Paleto Bay Medical Center
                x = -248.1,
                y = 6332.6,
                z = 32.43,
            },
        },

        BypassLocations = { --Locations where players can revive/respawn without the timer, regardless of permissions.
            ['LEO Training Center'] = {
                x = -2079.86,
                y = 3057.49,
                z = 32.81,
                radius = 250,
            },
        },
    },
    Misc = {
        PostalCommand = "postal",
        ToggleHUDCommand = "togglehud",
        Peacetime = "peacetime", -- Peacetime & PT both control the peacetime system.
        PT = "pt",
        PeacetimeAcePermission = "FIRP.PeaceTime", --The ace permission required to run PT or Peacetime command.
        usingLegacyFuel = false, --Whether or not to enable the {FUEL} placeholder. (MUST HAVE LegacyFuel INSTALLED!)
    },
    Displays = {
        ['Compass Location'] = {
            x = .16,
            y = .889,
            display = "~w~| ~b~{COMPASS} ~w~|",
            textScale = 0.9,
            vehicleRestricted = false,
            enabled = true,
        },
        ['Street Location'] = {
            x = .205,
            y = .9,
            display = "~w~| ~b~{STREET_NAME} ~w~|",
            textScale = .55,
            vehicleRestricted = false,
            enabled = true,
        },
        ['Nearest Postal, Discord, & ID'] = {
            x = .16,
            y = .935,
            display = "~b~Nearest Postal:~w~ {NEAREST_POSTAL} ~w~| ~b~Discord.gg: ~w~YOURINVITECODE ~w~| ~b~ID: ~w~{ID}",
            textScale = .45,
            vehicleRestricted = false,
            enabled = true,
        },
        ['AOP & PeaceTime'] = {
            x = .16,
            y = .96,
            display = "~b~Current AOP:~w~ {CURRENT_AOP} ~w~| ~b~PeaceTime: ~w~{PEACETIME_STATUS}",
            textScale = .45,
            vehicleRestricted = false,
            enabled = true,
        },
        ['Speed & Fuel'] = {
            x = .0475,
            y = .77,
            display = "~w~{SPEED_MPH} ~b~MPH ~w~| ~b~Fuel: ~w~{FUEL}",
            textScale = .55,
            vehicleRestricted = true,
            enabled = true,
        },
    }
}
```
Essentially, you can add as many watermarks, respawn locations, and bypass location to this configuration that you want just by following the format of the previous ones. The placeholders all in this configuration can be used as well. Currently only EST time is supported, but there may be more coming in the future (pull request maybe please? lol)...

Available Placeholders for Displays;
{NEAREST_POSTAL} | Returns the nearest postal code of the player.
{NEAREST_POSTAL_DISTANCE} | Returns the distance between the player and the nearest postal code.
{STREET_NAME} | Returns the street name the player is on.
{CITY} | Returns the name of the area the player is in.
{COMPASS} | Returns the direction of travel of the player. N, E, S, W, etc.
{ID} | Returns the server ID of the player.
Note: All Times are returned as Eastern Standard Time.
{EST_TIME} | Returns the current time.
{US_DAY} | Returns the current day.
{US_MONTH} | Returns the current month.
{US_YEAR} | Reutrns the current year.

{CURRENT_AOP} | Returns the current AOP.
{PEACETIME_STATUS} | Returns the current peacetime status.

Available Exports;

`exports['Badssentials'].GetAOP()` | Returns the current AOP. (Server Side)
`exports['Badssentials'].GetPeaceTimeStatus()` | Returns the current status of peacetime.  (Server Side)
`exports['Badssentials'].IsDisplaysHidden()` | Returns true/false on whether or not Displays are hidden. (Client Side)



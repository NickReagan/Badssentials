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
        --Announcement sent to players when AOP is changed. Set to "", or nil, to disable.
        AOP_Announcement = "The AOP has changed to '{NEW_AOP}'. Finish your current scene(s) and head to {NEW_AOP}. ^1Failure to do so could lead to punishment!^0",
        AOP_AcePermission = "Badssentials.AOP", --The ace permission need to run the AOPCommand.
        SetMapNameAsAOP = true, --This will set the map name to the current aop. This affects the "map name" on the server list, etc.
    },
    ReviveSystem = {
        enable = true, --Enable/Disable Revive System
        enableBypassLocations = true,
        Revive_Delay = 120, -- Set to 0 to disable 
        Respawn_Delay = 60, -- Set to 0 to disable
        RespawnCommand = "respawn",
        EnablePEAIntergration = {true, 60, 30},
        RespawnMessage = "Respawned successfully!", --Message sent when player respawns.
        RespawnErrorMessage = "^1ERROR: You cannot respawn, you still have ^7{RESPAWN_TIME_LEFT} ^1remaining...", --Message sent to user when they can't respawn. Use {TIME_LEFT} to show how long they have to respawn.
        ReviveCommand = "revive",
        ReviveMessage = "Revived successfully!", --Message sent when player revives.
        ReviveOtherSuccessMessage = "You have revived player ^5{PLAYER_NAME} ^0successfully!", --Message sent to player when they successfully revived someone else.
        ReviveErrorMessage = "^1ERROR: You cannot revive, you still have ^7{REVIVE_TIME_LEFT} ^1remaining...",
        ReviveOthersAcePermission = "Badssentials.Revive", --The ace permission required to revive other players.
        ReviveOthersMessage = "You have been revived by ^5{PLAYER_NAME}^0.", --Message sent to user after being revived by someone else. Use {PLAYER_NAME} for the staff member's name.
        BypassReviveAcePermission = "Badssentials.Bypass.ReviveR", --The ace permission required to revive yourself with no cooldown.
        BypassRespawnAcePermission = "Badssentials.Bypass.RespawnR", --The ace permission required to respawn with no cooldown.
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
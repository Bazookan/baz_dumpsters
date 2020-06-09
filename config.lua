Config = {
	EnableWeapons = false, -- If you want the players to be able to find weapons (false by default).
	SearchTime = 10000, -- How much time it takes to find something in millisecond

	Dumpsters = { -- Props of the dumpsters wich is getting defined in the client.
		"prop_dumpster_01a",
		"prop_dumpster_02a",
		"prop_dumpster_02b"
	},

	Items = { -- Add whatever items you want here.
        "fishing_lure",
        "bandage",
        "weed_pooch",
        "bread",
        "lotteryticket"
	},
	
	Weapons = { -- Add whatever weapons you want here (don't care about this if EnableWeapons = false).
        "WEAPON_KNIFE",
        "WEAPON_PISTOL"
    }
}

Strings = { -- Translation
	["Search"] = "Press [~g~E~s~] to search",
	["Searched"] = "You've already searched this dumpster!",
	["Found"] = "You found ",
	["Searching"] = "Searching...",
	["Nothing"] = "You found nothing..."
}

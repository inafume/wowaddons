local rcgenabled = 1
local rcgaprilfools = 0

local eleframe = CreateFrame("StatusBar", "InaRCG", UIParent, BackdropTemplateMixin and "BackdropTemplate")

local messageArray = 
{
	"SPEC CHECK UR WEINER!",
	"ARE YOU TALENTED, MR RIPLEY?",
	"IF YOU'RE NOT READY, SAY NO",
	"STOP LOOKING AT PORN",
	"THE TANK IS READY TO GO",
	"WAKE UP MAGGOTS",
	"BEHOLD THE CORN OF BATTLE",
	"FOR PONY!",
	"EQUIP YOUR SHIELD",
	"FLASK UP BOYS",
	"PUT YOUR DINNER DOWN",
	"WIPING WAS MERELY A SETBACK",
	"JIFFY LUBE YOUR WEAPONS",
	"STOP. POOPING.",
	"LETS GET READY TO RUMMMMMMBBBLE! OR WIPE, WHATEVER.",
	{ "Mooroth", "SHOW OFF YOUR BEST MOG", "MOOROTH TAKE OFF THAT TRANSMOG!" },
	{ "Nor", "WATCH FOR SWAPBLASTER", "NOR MAKE SURE THAT SWAPBLASTER IS ON CD" },
	"RUNE ME UP, DADDY",
	"GET YOUR JUNDIES!",
	"SPLATTER THE BOSS AGAINST THE WALL!",
	"REMEMBER, GREEN IS A COLOR, NOT A SHAPE",
	"PAY ATTENTION YOU SPATULA",
	"IMAGINE DRAGONS",
	{ "Korlatt", "ROLL, YOU WEENIES", "FELO KICK OFF A ROLL FOR CASH MONEY" },
	"MAKE SURE THE BREAD IS DONE",
	"MAKE THE BIGGEST THICKEST CLUSTER",
	"DO YOU WANT TO BE A PASSENGER PRINCESS?",
	{ "Koggs", "WELCOME TO THE CARELESS RAID", "WELCOME TO THE CAREFUL RAID" },
	"FOR LIONSHIRE!",
	"I, GAMON, WILL SAVE US",
	"CAN I INTERRUPT THE RAID TO SHOW YOU ALL ANOTHER GAME?",
	"CHECK YOUR CHARACTER FOR MISSING GEAR SLOTS",
	"DONT FORGET TO TAKE OFF YOUR SEATBELT DURING TURBULENCE",
	"BRING BALANCE TO THE RAID, SPLIT THE ROUGES",
	"PRAISE TO THE JACKASS",
	{ "Nor", "THE INK MINES ARE BACK IN BUSINESS", "THE INK MINES ARE DRY AFTER WIPING AWAY NOR'S TEARS" },
	"FINISH SLURPING THE SOUP",
	{ "Sistersledge", "WELCOME TO THE SLOPPY RAID", "WELCOME TO THE CLEAN RAID" },
	"HENOO FRENS",
	"DID YOU EAT THE FLOOR FEESH?",
	"CRANK UP THE SPICE",
	"QUIT DIRKING AROUND",
	"NO MID-FIGHT PICKING UP POTS.",
	"DONT BE A SLEEPY SLIDEY",
	"MAKE SURE YOUR GROUP IS ON THE RIGHT COLORS - YELOW READ GWEEN BUE POIPLE RANJ",
	"THE RELEASE BUTTON IS NOT YOUR FRIEND",
	"MISS SHIT, LETS DO IT!",
	"IF YOU NEED TO DRINK A BIRB, DO IT QUICKLY",
	"REMOVE BUFFS, WE RAW DOGGIN IT",
	"BRB SWITCHING TO A MIDDLING MYTHIC GUILD"
}

local aprilfoolsArray = 
{
	"READY CHECK GO WAS CREATED IN 2024",
	"PREPARE TO FIGHT THE BOSS!",
	"ENSURE YOU HAVE YOUR BUFFS",
	"PLEASE ASK QUESTIONS ABOUT THE FIGHT",
	"THANK YOU, RAIDERS, FOR ATTENDING",
	"THE RAID LEADERS APPRECIATE YOUR PATIENCE",
	"CALL OUT IF YOU ARE IN NEED OF ENCHANTS",
	"SET UP YOUR TALENTS ACCORDINGLY",
	"WE LOOK FORWARD TO SEEING YOU AT FUTURE EVENTS",
	"SIGN UP ON DISCORD FOR UPCOMING RAIDS"
}

eleframe:SetSize(1,1)

eleframe:RegisterEvent("READY_CHECK")



local function GetData(testmode, testid, testname)

	local message = "temp"

	local af = 1

	local workingArray = messageArray

	if rcgaprilfools == 1 then
		workingArray = aprilfoolsArray
	end

	if testmode == 1 then
		workingArray = messageArray
	end

	if testmode == 2 then
		workingArray = aprilfoolsArray
	end

	local i = math.random(1, table.getn(workingArray))

	if testid ~= nil then
		i = testid
	end

	if type(workingArray[i]) == "table" then

		if testplayer == workingArray[i][1] then

			message = workingArray[i][3]
		else
			message = workingArray[i][2]

			for p=1, 30 do
				name, rank, subgroup, level, class, fileName, 
						zone, online, isDead, role, isML = GetRaidRosterInfo(p);
		
				if name == workingArray[i][1] then
					message = workingArray[i][3]
				end
			end
		end

	end

	if type(workingArray[i]) ~= "table" then

		message = workingArray[i]

	end

	return message
end

eleframe:SetScript("OnEvent", function(self, event, ...)
	if event == "READY_CHECK" and rcgenabled == 1 then

		local message = GetData(nil, nil, nil)

		SendChatMessage("Ready Check Go -> " .. message,  IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY")
	end
end);

local function ReadyCheckGoCommands(msg, editbox)
	if msg == "off" then
		rcgenabled = 0
		print("|cD08080FFReady Check Go|cFFFFFFFF: Disabled!")
	elseif msg == "on" then
		rcgenabled = 1
		print("|cD08080FFReady Check Go|cFFFFFFFF: Enabled!");
	elseif msg == "afon" then
		rcgaprilfools = 1
		print("|cD08080FFReady Check Go|cFFFFFFFF: April Fools enabled!");
	elseif msg == "afoff" then
		rcgaprilfools = 0
		print("|cD08080FFReady Check Go|cFFFFFFFF: April Fools disabled!");
	elseif string.find(msg, "^test") ~= nil then

		testsay = 0

		if string.find(msg, "^testsay") ~= nil then
			testsay = 1
		end

		index = 0
		testmode = nil
		testindex = nil
		testplayer = nil

		for token in string.gmatch(msg, "[^%s]+") do

			if index == 1 then
				testmode = token
			elseif index == 2 then
				testindex = token
			elseif index == 3 then
				testplayer = token
			end

			index = index + 1
	 	end

		testmessage = GetData(tonumber(testmode), tonumber(testindex), testplayer)

		if testmessage == nil then
			print("|cD08080FFReady Check Go|cFFFFFFFF: Test Result returned nothing")
		else
			print("|cD08080FFReady Check Go|cFFFFFFFF: Test Result: " .. testmessage)
		end

		if testsay == 1 and testmessage ~= nil then
			SendChatMessage("Ready Check Go -> [Test] " .. testmessage,  IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY")
		end 
	else
		print("|cD08080FFReady Check Go|cFFFFFFFF: Syntax: /rcg (on/off/afon/afoff)");
	end 
end



SLASH_INARCG1 = '/rcg'

SlashCmdList["INARCG"] = ReadyCheckGoCommands 
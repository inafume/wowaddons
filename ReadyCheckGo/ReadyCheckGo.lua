
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
	{ "Korlatt", "ROLL FOR WEENIES", "FELO KICK OFF A ROLL FOR WEENIES" },
	"MAKE SURE THE BREAD IS DONE",
	"MAKE THE BIGGEST THICKEST CLUSTER",
	"DO YOU WANT TO BE A PASSENGER PRINCESS?",
	{ "Koggs", "WELCOME TO THE CARELESS RAID", "WELCOME TO THE CAREFUL RAID" },
	"FOR LIONSHIRE!",
	"I, GAMON, WILL SAVE US"
}

eleframe:SetSize(1,1)

eleframe:RegisterEvent("READY_CHECK")

eleframe:SetScript("OnEvent", function(self, event, ...)
	if event == "READY_CHECK" then

		local message = "temp"

		local af = 1

		local i = math.random(1, table.getn(messageArray) + 1)

		if type(messageArray[i]) == "table" then

			message = messageArray[i][1]

	 		for p=1, 30 do
				name, rank, subgroup, level, class, fileName, 
						zone, online, isDead, role, isML = GetRaidRosterInfo(p);
		
				if name == messageArray[i][0] then
					message = messageArray[i][2]
				end
			end
		end

		if type(messageArray[i]) ~= "table" then

			message = messageArray[i]

		end

		-- if af == 1 then

		-- 	local i1 = math.random(1, 10)

		-- 	message = "READY CHECK GO WAS CREATED IN 2024"

		-- 	if i1 == 1 then
		-- 		message = "PREPARE TO FIGHT THE BOSS!"
		-- 	end
			
		-- 	if i1 == 2 then
		-- 		message = "ENSURE YOU HAVE YOUR BUFFS"
		-- 	end
			
		-- 	if i1 == 3 then
		-- 		message = "PLEASE ASK QUESTIONS ABOUT THE FIGHT"
		-- 	end

		-- 	if i1 == 4 then
		-- 		message = "THANK YOU, RAIDERS, FOR ATTENDING"
		-- 	end

		-- 	if i1 == 5 then
		-- 		message = "THE RAID LEADERS APPRECIATE YOUR PATIENCE"
		-- 	end

		-- 	if i1 == 6 then
		-- 		message = "CALL OUT IF YOU ARE IN NEED OF ENCHANTS"
		-- 	end

		-- 	if i1 == 7 then
		-- 		message = "SET UP YOUR TALENTS ACCORDINGLY"
		-- 	end

		-- 	if i1 == 8 then
		-- 		message = "WE LOOK FORWARD TO SEEING YOU AT FUTURE EVENTS"
		-- 	end

		-- 	if i1 == 9 then
		-- 		message = "SIGN UP ON DISCORD FOR UPCOMING RAIDS"
		-- 	end

		-- end



		SendChatMessage("Ready Check Go -> " .. message,  IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY")
	end
end);
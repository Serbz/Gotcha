local x = "b"
local z = 0;
local w = 0;
local t = 0;
local s = 1;
local zr = 12;
local m = 0;
local zrdm = 0;
local sc = 0;
-- local td = 200; -- I use this as an Administrator on Zhyper WoW :)


--------------------------------------------------
---------------- GOTCHA UPDATE -------------------
----------- How often Gotcha Updates -------------
--------------------------------------------------
local Gotcha_UpdateInterval = 0.5
function Gotcha_OnUpdate(self, elapsed)
  self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed; 	

  if (self.TimeSinceLastUpdate > Gotcha_UpdateInterval) then
    Gotcha_OnEvent()
	
    self.TimeSinceLastUpdate = 0;
  end
end

--------------------------------------------------
------------------- GOTCHA MSG -------------------
-------------- Sends Gotcha_Msg's ----------------
--------------------------------------------------
function Gotcha_Msg(msg)
    if( DEFAULT_CHAT_FRAME ) then
        DEFAULT_CHAT_FRAME:AddMessage(msg);
    end
end


--------------------------------------------------
------------------- GOTCHA ONLOAD ----------------
------------ much like if(first()){ --------------
--------------------------------------------------
function Gotcha_OnLoad(self)
	Gotcha_Frame:Hide()
	--Stealth:Disable();
	Gotcha_Msg("|cffffff00[|cff00ffffGotcha|cffffff00]:|cffbbbbbb V 1.63")
	_G[self:GetName()]:RegisterEvent("PLAYER_PVP_KILLS_CHANGED");
	_G[self:GetName()]:RegisterEvent("PLAYER_DEAD");
	_G[self:GetName()]:RegisterEvent("CHAT_MSG_SYSTEM");
	_G[self:GetName()]:RegisterEvent("ADDON_LOADED");
	_G[self:GetName()]:RegisterEvent("PLAYER_LOGOUT");
	_G[self:GetName()]:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	_G[self:GetName()]:RegisterEvent("UPDATE_STEALTH");
	SLASH_GotchaCMD1 = "/gotcha";
	SlashCmdList["GotchaCMD"] = Gotcha_Command;
end


--------------------------------------------------
------------------ GOTCHA COMMANDS ---------------
---------- Runs Gotcha Chat Commands -------------
--------------------------------------------------
function Gotcha_Command(param1)
	local start, finish, command, value = string.find(param1, "(%w+) (%w+)");
	if (string.lower(param1) == "options") then 
		if s == 1 then
			GotchaFrameShow();
		else
			GotchaFrameHide();
		end
	elseif (string.lower(param1) == "debug on") then 
		Gotcha_Settings.Gotcha_Debug = true;
		setting = Gotcha_Settings.Gotcha_Debug
		s1 = "|cffff00ffDebug Notifications |cffffffffare"
		DEChat();
		Gotcha_SetChecked();
	elseif (string.lower(param1) == "debug off") then 
		Gotcha_Settings.Gotcha_Debug = false;
		setting = Gotcha_Settings.Gotcha_Debug
		s1 = "|cffff00ffDebug Notifications |cffffffffare"
		DEChat();
		Gotcha_SetChecked();
	elseif (string.lower(param1) == "serb") then 
		devDebug();
	else
		Gotcha_Usage()
	end
end

--------------------------------------------------
------------------- GOTCHA USAGE -----------------
------------ Displays all available --------------
------------ Gotcha chat functions ---------------
--------------------------------------------------
	function Gotcha_Usage() 
    Gotcha_Msg("|cff00ffff Gotcha Usage:");
	Gotcha_Msg("|cffff00ff   /Gotcha Options");
	Gotcha_Msg("|cffff00ff   /Gotcha debug on");
	Gotcha_Msg("|cffff00ff   /Gotcha debug off");
	end


--------------------------------------------------
---------------- OnEvent FUNCTIONS ---------------
---------- Called when an event in the -----------
--- function Gotcha_OnLoad(self) is activated ----
--------------------------------------------------
function Gotcha_OnEvent(self, event, ...)
--if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
--		local type = select(2,...)
--		if type=="PARTY_KILL" and sourceGUID == UnitGUID("player") then
--			Gotcha_Msg("GOT A KILL");
--		end
--end
		-------------
		if (event == "ADDON_LOADED") then
			--if (arg1 == "Gotcha") then -- Removed due to it not working 3.3.5+
            Gotcha_LoadVariables();
			--end
		end
		-------------
		if (event == "PLAYER_PVP_KILLS_CHANGED") and ( Gotcha_Settings.Gotcha_Status == true ) and (x == "b") then
			x = "a"
			w = w + 1;
			z = z + 1;
			if z >= 5 then
				z = 1;
			end
			if (Gotcha_Settings.Gotcha_Debug == true) then
				Gotcha_Msg("|cffffff00[|cff00ffffGotcha|cffffff00]:|cFF008000 Debug: W, X, Z: "..w.." "..x.." "..z.." ");
			end
						hooksecurefunc("ActionButton_OnUpdate", sound)
		end
		------------
		if (event == "PLAYER_DEAD") and ( Gotcha_Settings.Gotcha_Status == true ) and (x == "b") then
						x = "c"
						w = 0;
						ec = 0;
						hooksecurefunc("ActionButton_OnUpdate", sound)
		end
		------------
		if (event == "CHAT_MSG_SYSTEM") and ( Gotcha_Settings.Gotcha_Status == true ) then
		local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = ...;
			t = 1;
			if (string.find(string.lower(arg1), "duel starting: 3") ~= nil) then
				PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\prepare.mp3")
				t = 2;
			elseif (string.find(string.lower(arg1), "duel starting: 1") ~= nil) then
				PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\play.mp3")
				t = 3;
			end
			if (Gotcha_Settings.Gotcha_Debug == true) then
				Gotcha_Msg("|cffffff00[|cff00ffffGotcha|cffffff00]:|cFF008000 Debug: T "..t.." ")
			end
		end
		-----------
		-----------
		if (event == "UPDATE_STEALTH") then
			StealthSound();
		end
end

--------------------------------------------------
----------------- SOUND FUNCTION -----------------
---------- Used so that we do not play -----------
---------- the same sound multiple times ---------
--------------------------------------------------
function StealthSound()
		---- Begin of stealth sounds ----
	if (Gotcha_Settings.Gotcha_Stealth == true) then
		if (IsStealthed() == 1) and (sc == 0) then
			local rvst = math.random(1,5);
			if rvst == 1 then
				PlayMusic("Interface\\AddOns\\Gotcha\\sound\\007.mp3")
			end
			if rvst == 2 then
				PlayMusic("Interface\\AddOns\\Gotcha\\sound\\tf2rby.mp3")
			end
			if rvst == 3 then
				PlayMusic("Interface\\AddOns\\Gotcha\\sound\\60ssm.mp3")
			end
			if rvst == 4 then
				PlayMusic("Interface\\AddOns\\Gotcha\\sound\\gsm.mp3")
			end
			if rvst == 5 then
				PlayMusic("Interface\\AddOns\\Gotcha\\sound\\mitm.mp3")
			end
			--Gotcha_Msg("|cffffff00[|cff00ffffGotcha|cffffff00]:|cFF008000 Debug: Stealthed sound here")
			sc = 1;
		end
		if (IsStealthed() == nil) and (sc == 1) then
			StopMusic();
			sc = 0;
			--Gotcha_Msg("|cffffff00[|cff00ffffGotcha|cffffff00]:|cFF008000 Debug: Not Stealthed stop sound")
		end
	end
		---- end of stealth sounds ----
end
function sound()
	if MyAddon_Zreset == nil then
		MyAddon_Zreset = GetTime()
	end
	if (MyAddon_LastTime == nil) then
		MyAddon_LastTime = GetTime()
	else
	---- begin of consecutive kill if statments ----
		if w == 10 then
			local v = math.random(1,2);
			
			if Gotcha_Settings.Gotcha_Quake == true then
				if v == 1 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\dominating.mp3")
				end
				if v == 2 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\rampage.mp3")
				end
			end
			if Gotcha_Settings.Gotcha_Halo == true then
				if v == 1 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\KillingSpree.ogg")
				end
				if v == 2 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\Rampage.ogg")
				end
			end
			
			w = 11;
			x = "b"
		end
		if w == 16 then
			local v = math.random(1,2);
			if Gotcha_Settings.Gotcha_Quake == true then
				if v == 1 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\monsterkill.mp3")
				end
				if v == 2 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\killingspree.mp3")
				end
			end
			if Gotcha_Settings.Gotcha_Halo == true then
				if v == 1 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\Killimanjaro.ogg")
				end
				if v == 2 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\KillingFrenzy.ogg")
				end
			end
			w = 17;
			x = "b"
		end
		if w == 22 then
			if Gotcha_Settings.Gotcha_Quake == true then
				local v = math.random(1,3);
				if v == 1 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\wickedsick.mp3")
				end
				if v == 2 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\unstoppable.mp3")
				end
				if v == 3 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\ludicrouskill.mp3")
				end
			end
			if Gotcha_Settings.Gotcha_Halo == true then
				local v = math.random(1,2);
				if v == 1 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\Killjoy.ogg")
				end
				if v == 2 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\Killionaire.ogg")
				end
			end
			w = 23;
			x = "b"
		end
		if w == 28 then
			local v = math.random(1,2);
			if Gotcha_Settings.Gotcha_Quake == true then
				if v == 1 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\godlike.mp3")
				end
				if v == 2 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\holyshit.mp3")
				end
			end
			if Gotcha_Settings.Gotcha_Halo == true then
				if v == 1 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\Untouchable.ogg")
				end
				if v == 2 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\Killpocalypse.ogg")
				end
			end
			w = 0;
			x = "b"
		end
		---- end of consecutive kill if statements ----
		if Gotcha_Settings.Gotcha_Multikills == false and (z > 1) then
			z = 1;
		end
		---- Begin of standard kill sounds ----
		if  (GetTime() >= MyAddon_LastTime + 0.5) and (x == "a") and z == 1 then
			x = "b"
			if Gotcha_Settings.Gotcha_Standard == true then
				if Gotcha_Settings.Gotcha_Quake == true then
					local u = math.random(1,6);
					if (u == 1) or (u == 6) then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\gotchaknife.mp3")
					elseif u == 2 then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\perfect.mp3")
					elseif u == 3 then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\impressive.mp3")
					elseif u == 4 then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\ultrakill.mp3")
					elseif u == 5 then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\megakill.mp3")
					end
				end
				if Gotcha_Settings.Gotcha_Halo == true then
					local u = math.random(1,5);
					if (u == 1) then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\slayer.ogg")
					elseif u == 2 then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\Perfection.ogg")
					elseif u == 3 then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\Extermination.ogg")
					elseif u == 4 then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\Overkill.ogg")
					elseif u == 5 then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\killtacular.ogg")
					end
				end
			end
                MyAddon_LastTime = GetTime()
		end
		---- End of standard kill sounds ----
		---- The if statement below resets Z (the counter for kills) after 10/15 seconds ----
		if GetBattlefieldInstanceRunTime() > 0 then
			zr = 10;
			if Gotcha_Settings.Gotcha_Debug == true and zrdm == 0 then
				Gotcha_Msg("|cffffff00[|cff00ffffGotcha|cffffff00]:|cFF008000 Debug: In a battleground, Zr == "..zr..".");
				zrdm = 1;
			end
		else
			zr = 15;
			if Gotcha_Settings.Gotcha_Debug == true and zrdm == 1 then
				Gotcha_Msg("|cffffff00[|cff00ffffGotcha|cffffff00]:|cFF008000 Debug: Not in a battleground, Zr == "..zr..".");
				zrdm = 0;
			end
		end
		if z == 1 and m == 0 then
			m = 1;
		end
		if m == 1 or z >= 5 then
			m = 2;
			MyAddon_Zreset = GetTime()
		end
		if z == 2 and m ~= 3 then
			m = 3;
				if Gotcha_Settings.Gotcha_Debug == true then
					Gotcha_Msg("|cffffff00[|cff00ffffGotcha|cffffff00]:|cFF008000 Debug: M: "..m.." ");
				end
		end
		if (GetTime() <= MyAddon_Zreset + 30) and m == 3 and z == 1 then
			m = 4;
				if Gotcha_Settings.Gotcha_Debug == true then
					Gotcha_Msg("|cffffff00[|cff00ffffGotcha|cffffff00]:|cFF008000 Debug: ZRTZ1A: "..math.floor(MyAddon_Zreset).." ");
				end
			MyAddon_Zreset = GetTime()
		end
		if  (GetTime() >= MyAddon_Zreset + zr) then
				m = 0;
				z = 0;
				x = "b"
				if Gotcha_Settings.Gotcha_Debug == true then
					Gotcha_Msg("|cffffff00[|cff00ffffGotcha|cffffff00]:|cFF008000 Debug: ZRT: "..math.floor(MyAddon_Zreset).." ");
				end
				MyAddon_Zreset = GetTime()
		end
		---- begin of multikill sounds ----
			if  (x == "a") and z == 2 then
				if Gotcha_Settings.Gotcha_Multikills == true then
					if Gotcha_Settings.Gotcha_Quake == true then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\doublekill.mp3")
					end
					if Gotcha_Settings.Gotcha_Halo == true then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\doublekill.ogg")
					end
				end
				x = "b"
			end
			if  (x == "a") and z == 3 then
				if Gotcha_Settings.Gotcha_Multikills == true then
					if Gotcha_Settings.Gotcha_Quake == true then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\triplekill.mp3")
					end
					if Gotcha_Settings.Gotcha_Halo == true then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\triplekill.ogg")
					end
				end
				x = "b"
			end
			if  (x == "a") and z == 4 then
				if Gotcha_Settings.Gotcha_Multikills == true then
					if Gotcha_Settings.Gotcha_Quake == true then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\multikill.mp3")
					end
					if Gotcha_Settings.Gotcha_Halo == true then
						PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\runningriot.ogg")
					end
				end
				z = 0;
				x = "b"
			end
		---- End of multikill sounds ----
		---- Begin of death sounds ----
		if  (GetTime() >= MyAddon_LastTime + 1) and (x == "c") then
			x = "b"
			if Gotcha_Settings.Gotcha_Quake == true then
				local y = math.random(1, 2);
				if y == 1 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\humiliation.mp3")
				elseif y == 2 then
					PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\female\\humiliation.mp3")
				end
			end
			if Gotcha_Settings.Gotcha_Halo == true then
				PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\gameover.ogg")
			end
                MyAddon_LastTime = GetTime()
		end
		---- End of death sounds ----
	end -- <-- end of if (MyAddon_LastTime == nil) then
end

--------------------------------------------------
--------------- MINIMAP REPOSITION ---------------
-------- Called after Variables are loaded -------
--------------------------------------------------
function Gotcha_MinimapButton_Reposition()
		Gotcha_MinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(Gotcha_Settings.MinimapPos)),(80*sin(Gotcha_Settings.MinimapPos))-52)
end

--------------------------------------------------
---------------- MINIMAP DRAGGING ----------------
--------- Called every frame while active --------
--------------------------------------------------
function Gotcha_MinimapButton_DraggingFrame_OnUpdate()

	local xpos,ypos = GetCursorPosition();
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom();

	xpos = xmin-xpos/UIParent:GetScale()+70; -- get coordinates as differences from the center of the minimap
	ypos = ypos/UIParent:GetScale()-ymin-70;

	Gotcha_Settings.MinimapPos = math.deg(math.atan2(ypos,xpos)); -- save the degrees we are relative to the minimap center
	Gotcha_MinimapButton_Reposition(); -- move the button
end

--------------------------------------------------
------------ MINIMAP BUTTON CLICKING -------------
--------------------------------------------------
function Gotcha_MinimapButton_OnClick()
	if s == 0 then
		GotchaFrameHide();
	elseif s == 1 then
		GotchaFrameShow();
	end
end

--------------------------------------------------
------------ MINIMAP BUTTON CLICKING -------------
--------- Called within the XML whenever ---------
-------------- an option is clicked --------------
--------------------------------------------------
function GotchaFrameOption1_OnClick()
	if Gotcha_Settings.Gotcha_Status == true then
		Gotcha_Settings.Gotcha_Status = false;
	else
		Gotcha_Settings.Gotcha_Status = true;
	end
	setting = Gotcha_Settings.Gotcha_Status
	s1 = "|cffff00ffGotcha |cffffffffis"
	DEChat();
	Gotcha_SetChecked();
end
function GotchaFrameOption2_OnClick()
	if Gotcha_Settings.Gotcha_Debug == true then
		Gotcha_Settings.Gotcha_Debug = false;
	else
		Gotcha_Settings.Gotcha_Debug = true;
	end
	setting = Gotcha_Settings.Gotcha_Debug
	s1 = "|cffff00ffDebug Notifications |cffffffffare"
	DEChat();
	Gotcha_SetChecked();
end
function GotchaFrameOption3_OnClick()
	if Gotcha_Settings.Gotcha_Standard == true then
		Gotcha_Settings.Gotcha_Standard = false;
	else
		Gotcha_Settings.Gotcha_Standard = true;
	end
	setting = Gotcha_Settings.Gotcha_Standard
	s1 = "|cffff00ffMultikill Voices |cffffffffare"
	DEChat();
	Gotcha_SetChecked();
end
function GotchaFrameOption4_OnClick()
	if Gotcha_Settings.Gotcha_Multikills == true then
		Gotcha_Settings.Gotcha_Multikills = false;
	else
		Gotcha_Settings.Gotcha_Multikills = true;
	end
	setting = Gotcha_Settings.Gotcha_Multikills
	s1 = "|cffff00ffMultikill Voices |cffffffffare"
	DEChat();
	Gotcha_SetChecked();
end
function GotchaFrameOption6_OnClick()
	if Gotcha_Settings.Gotcha_Halo == false then
		Gotcha_Settings.Gotcha_Halo = true;
		Gotcha_Settings.Gotcha_Quake = false;
	end
	setting = Gotcha_Settings.Gotcha_Halo
	s1 = "|cffff00ffHalo Voices |cffffffffare"
	DEChat();
	Gotcha_SetChecked();
end
function GotchaFrameOption5_OnClick()
	if Gotcha_Settings.Gotcha_Quake == false then
		Gotcha_Settings.Gotcha_Quake = true;
		Gotcha_Settings.Gotcha_Halo = false;
	end
	setting = Gotcha_Settings.Gotcha_Quake
	s1 = "|cffff00ffQuake Voices |cffffffffare"
	DEChat();
	Gotcha_SetChecked();
end
function GotchaFrameOption7_OnClick()
	if Gotcha_Settings.Gotcha_Stealth == false then
		Gotcha_Settings.Gotcha_Stealth = true;
	else
		Gotcha_Settings.Gotcha_Stealth = false;
	end
	setting = Gotcha_Settings.Gotcha_Stealth
	s1 = "|cffff00ffStealth Music |cffffffffis"
	DEChat();
	Gotcha_SetChecked();
end
function DEChat()
	if setting == true then
		s2 = "|cff00ff00Enabled"
	else
		s2 = "|cffff6060Disabled"
	end
	Gotcha_Msg("|cffffff00[|cff00ffffGotcha|cffffff00]: "..s1.."|cffffffff now "..s2.." ");
end


--------------------------------------------------
---------------- SAVED VARIABLES -----------------
-------- Called when the script loads ------------
--------------------------------------------------
function Gotcha_LoadVariables()
	if Gotcha_Settings == nil then
		Gotcha_Settings = {
			Gotcha_Stealth = false,
			Gotcha_Status = true,
			MinimapPos = 45,
			Gotcha_Debug = false,
			Gotcha_Standard = true,
			Gotcha_Multikills = true,
			Gotcha_Quake = true,
			Gotcha_Halo = false,
		}
	end
	if Gotcha_Settings.MinimapPos == nil then
		Gotcha_Settings.MinimapPos = 45;
	end
	if Gotcha_Settings.Gotcha_Status == nil or (Gotcha_Settings.Gotcha_Status ~= false and Gotcha_Settings.Gotcha_Status ~= true) then
		Gotcha_Settings.Gotcha_Status = true;
	end
	if Gotcha_Settings.Gotcha_Debug == nil or (Gotcha_Settings.Gotcha_Debug ~= false and Gotcha_Settings.Gotcha_Debug ~= true) then
		Gotcha_Settings.Gotcha_Debug = false;
	end
	if Gotcha_Settings.Gotcha_Standard == nil or (Gotcha_Settings.Gotcha_Standard ~= false and Gotcha_Settings.Gotcha_Standard ~= true) then
		Gotcha_Settings.Gotcha_Standard = true;
	end
	if Gotcha_Settings.Gotcha_Multikills == nil or (Gotcha_Settings.Gotcha_Multikills ~= false and Gotcha_Settings.Gotcha_Multikills ~= true) then
		Gotcha_Settings.Gotcha_Multikills = true;
	end
	if Gotcha_Settings.Gotcha_Quake == nil or (Gotcha_Settings.Gotcha_Quake ~= false and Gotcha_Settings.Gotcha_Quake ~= true) then
		Gotcha_Settings.Gotcha_Quake = true;
	end
	if Gotcha_Settings.Gotcha_Halo == nil or (Gotcha_Settings.Gotcha_Halo ~= false and Gotcha_Settings.Gotcha_Halo ~= true) then
		Gotcha_Settings.Gotcha_Halo = false;
	end
	if Gotcha_Settings.Gotcha_Stealth == nil or (Gotcha_Settings.Gotcha_Stealth ~= false and Gotcha_Settings.Gotcha_Stealth ~= true) then
		Gotcha_Settings.Gotcha_Stealth = false;
	end
	Gotcha_MinimapButton_Reposition()

end

--------------------------------------------------
----------- OPTION FRAME FUNCTIONS ---------------
------- DISPLAYS/HIDES THE OPTIONS FRAME ---------
--------------------------------------------------
function GotchaFrameShow()
		Gotcha_Frame:Show();
		s = 0;
		Gotcha_SetChecked();
	end
function GotchaFrameHide()
		s = 1;
		Gotcha_Frame:Hide();
	end
function Gotcha_SetChecked()
		--- Set checked ---
		if Gotcha_Settings.Gotcha_Status == false then
			Status:SetChecked(false);
		else
			Status:SetChecked(true);
		end
		----
		if Gotcha_Settings.Gotcha_Debug == false then
			Debug:SetChecked(false);
		else
			Debug:SetChecked(true);
		end
		----
		if Gotcha_Settings.Gotcha_Standard == false then
			Standard:SetChecked(false);
		else
			Standard:SetChecked(true);
		end
		----
		if Gotcha_Settings.Gotcha_Multikills == false then
			Multi:SetChecked(false);
		else
			Multi:SetChecked(true);
		end
		----
		if Gotcha_Settings.Gotcha_Quake == true then
			Quake:SetChecked(true);
			Halo:SetChecked(false);
		else
			Quake:SetChecked(false);
		end
		----
		if Gotcha_Settings.Gotcha_Halo == true then
			Halo:SetChecked(true);
			Quake:SetChecked(false);
		else
			Halo:SetChecked(false);
		end
		----
		if Gotcha_Settings.Gotcha_Stealth == true then
			Stealth:SetChecked(true);
		else
			Stealth:SetChecked(false);
		end
		----
end

function devDebug()
--PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\quake\\multikill.mp3")
   --Gotcha_Msg("BG Time: "..GetBattlefieldInstanceRunTime().." ");
	--Gotcha_Msg(" "..GetBattlegroundInfo(2).." ");
	--PlaySoundFile("Interface\\AddOns\\Gotcha\\sound\\halo\\runningriot.ogg")
	 --if 1==1 then
		--td=td+1;
		--SendChatMessage(".ticket del "..td.." ","SAY") 
		--Gotcha_Msg("|cffffff00[|cff00ffffGotcha|cffffff00]:|cFF008000 Debug: T "..td.." ")
	--end
if (IsStealthed() == 1) then
	SendChatMessage("Stealthed!","SAY")
end
end
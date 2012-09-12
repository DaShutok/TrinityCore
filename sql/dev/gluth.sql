UPDATE creature_template SET faction_A = '1965', faction_H = '1965' WHERE entry IN (15932, 29417);
UPDATE creature_template SET faction_A = '1693', faction_H = '1693' WHERE entry IN (16360, 30303);
UPDATE creature_template SET ScriptName = '', AIName = "SmartAI" WHERE entry = 16360;

-- Zombie Chow
SET @ENTRY := 16360;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,8,0,100,0,28374,0,0,0,111,5,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Zombie Chow - SpellHit Decimate - SetHealth 25200"),
(@ENTRY,@SOURCETYPE,1,0,8,0,100,0,54426,0,0,0,111,5,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Zombie Chow - SpellHit Decimate - SetHealth 50400");

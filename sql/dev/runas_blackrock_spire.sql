UPDATE `gameobject_template` SET `ScriptName` = 'go_door_room' WHERE `entry` IN (175197, 175199, 175195, 175200, 175198, 175196, 175194);
UPDATE `gameobject_template` SET `faction` = '35' WHERE `entry` IN (175197, 175199, 175195, 175200, 175198, 175196, 175194);

-- Blackrock Altar
SET @ENTRY := 175706;
SET @SOURCETYPE := 1;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE gameobject_template SET AIName="SmartGameObjectAI" WHERE entry=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,64,0,100,0,0,0,0,0,45,0,1,0,0,0,0,9,10316,0,100,0.0,0.0,0.0,0.0,"Blackrock Altar - GossipHello - Set Data");

-- Blackhand Incarcerator
SET @ENTRY := 10316;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,1,0,100,3,1000,1000,1000,1000,11,15281,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Blackhand Incarcerator - OOC -  Cast Encage Emberseer"),
(@ENTRY,@SOURCETYPE,1,2,38,0,100,2,0,1,0,0,92,0,15281,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Blackhand Incarcerator - On data set -  Stop Casting Encage Emberseer"),
(@ENTRY,@SOURCETYPE,2,4,61,0,100,0,0,0,0,0,19,768,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Blackhand Incarcerator - On data set -  Remove unit flags"),
(@ENTRY,@SOURCETYPE,3,4,4,0,100,2,0,0,0,0,9,0,0,0,0,0,0,15,175244,100,0,0.0,0.0,0.0,0.0,"Blackhand Incarcerator - On aggro -  close emberseer in door"),
(@ENTRY,@SOURCETYPE,4,0,61,0,100,0,0,0,0,0,9,0,0,0,0,0,0,15,175705,100,0,0.0,0.0,0.0,0.0,"Blackhand Incarcerator - On aggro -  close doors"),
(@ENTRY,@SOURCETYPE,5,0,0,0,100,2,7800,15800,13800,22900,11,12039,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Blackhand Incarcerator - Combat - Cast Strike"),
(@ENTRY,@SOURCETYPE,6,0,0,0,100,2,10000,20000,6000,12000,11,8362,0,0,0,0,0,5,0,0,0,0.0,0.0,0.0,0.0,"Blackhand Incarcerator - Combat - Cast Encage"),
(@ENTRY,@SOURCETYPE,7,0,2,0,100,3,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Blackhand Incarcerator - HP@15% - Flee for help"),
(@ENTRY,@SOURCETYPE,8,0,6,0,100,0,0,0,0,0,41,10000,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Blackhand Incarcerator - On death - Despawn after 10 sec"),
(@ENTRY,@SOURCETYPE,9,0,6,0,100,0,0,0,0,0,28,0,0,0,0,0,0,9,9816,0,100,0.0,0.0,0.0,0.0,"Blackhand Incarcerator - OnDead - Remove Emberseer"),
(@ENTRY,@SOURCETYPE,10,0,6,0,100,0,0,0,0,0,19,33554688,0,0,0,0,0,9,9816,0,100,0.0,0.0,0.0,0.0,"Blackhand Incarcerator - OnDead - Remove Emberseer");

-- UPDATE `gameobject_template` SET `flags` = 32 WHERE `entry` = 192951;

DELETE FROM gameobject WHERE id = 193772;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
('500331','193772','571','1','1','5923.82','570.418','661.087','6.06237','0','0','0','1','180','255','1'),
('61496','193772','571','1','1','5686.8','773.175','647.752','1.83259','0','0','0','1','180','255','1');

-- Lake Wintergrasp Portal
SET @ENTRY := 193772;
SET @SOURCETYPE := 1;
SET @GUID := '-500331';
SET @GUID1 := '-61496';

DELETE FROM `smart_scripts` WHERE `entryorguid`=@GUID AND `source_type`=@SOURCETYPE;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GUID1 AND `source_type`=@SOURCETYPE;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE gameobject_template SET AIName="SmartGameObjectAI" WHERE entry=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@GUID1,@SOURCETYPE,0,0,64,0,100,0,0,0,0,0,62,571,0,0,0,0,0,0,0,0,0,5099.98,2184.89,365.608,0.0,"Wintergrasp Portal - GossipHello - Teleport to base camp (A)"),
(@GUID,@SOURCETYPE,0,0,64,0,100,0,0,0,0,0,62,571,0,0,0,0,0,0,0,0,0,5026.56,3681.99,362.804,0.0,"Wintergrasp Portal - GossipHello - Teleport to base camp (H)");
-- Humans
UPDATE `creature_template` SET `npcflag` = 0 WHERE `entry` = 49871;
UPDATE `creature_template` SET `npcflag` = 0 WHERE `entry` = 49874;
UPDATE `locales_creature` SET `name_loc6`='Espia Roca Negra' WHERE `entry`='49874'; 
DELETE FROM `spell_linked_spell` WHERE (`spell_trigger`=92857 AND `spell_effect` =80676);
INSERT INTO `spell_linked_spell`(`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES ( '92857','80676','2','GPLP_ Blackrock Spy_ Spyglass'); 
UPDATE `creature_template` SET `npcflag` = 2, `AIName` = 'SmartAI' WHERE `entry` = 49874;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=49874 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(49874, 0, 1, 0, 4, 0, 100, 1, 0, 0, 0, 0, 1, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'GPLP_Espia rocanegra_ Hablar al entrar en combate');

-- FALTAN TRADUCCIONES esES
DELETE FROM `creature_text` WHERE `entry`='49874' AND `groupid`='0'; 
INSERT INTO `creature_text`(`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES ( '49874','0','0','Beg for life!','12','0','25','0','0','0','Blackrock Spy'); 
INSERT INTO `creature_text`(`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES ( '49874','0','1','Blackrock take forest!','12','0','25','0','0','0','Blackrock Spy');
INSERT INTO `creature_text`(`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES ( '49874','0','2','Eat you!','12','0','25','0','0','0','Blackrock Spy');  
INSERT INTO `creature_text`(`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES ( '49874','0','4','The grapes were VERY TASTY!','12','0','25','0','0','0','Blackrock Spy'); 

UPDATE `creature_template` SET `npcflag` = 0 WHERE `entry` = 49874;
UPDATE `creature_template` SET `npcflag` = 0 WHERE `entry` = 50047;
UPDATE `creature_template` SET `npcflag` = 0 WHERE `entry` = 50039;

-- No funciona
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 49871;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=49869 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(49869, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 9, 49869, 0, 20, 0, 0, 0, 0, 'GPLP_ Huargo rocanegra_ Atacar a la infanteria');




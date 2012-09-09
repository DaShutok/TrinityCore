UPDATE `creature_template` SET `flags_extra` = 130 WHERE `entry` = 53488;
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 50604;
UPDATE `creature_template` SET `minlevel` = 21, `maxlevel` = 21, `exp` = 3, `faction_A` = 14, `faction_H` = 14, `rank` = 3, `unit_class` = 2, `mingold` = 12683, `maxgold` = 12683, `flags_extra` = 0, `ScriptName` = 'boss_baron_ashbury' 
,`Health_mod` = 11600, `Mana_mod` = 5100 ,`mindmg` = 180, `maxdmg` = 200, `attackpower` = 100, `baseattacktime` = 2000, `unit_flags2` = 2048 WHERE `entry` = 46962;
DELETE FROM smart_scripts WHERE entryorguid IN (46962, 3887, 4278, 46964, 46963) AND source_type = 0;
DELETE FROM creature_ai_scripts WHERE creature_id IN (46962, 3887, 4278, 46964, 46963);
DELETE FROM creature_text WHERE entry IN (46962, 3887, 4278, 46964, 46963);
UPDATE creature_template SET AIName = "" WHERE entry IN (46962, 3887, 4278, 46964, 46963);
DELETE FROM `creature_text` WHERE `entry`=46962;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES (46962,0,0,'Tally ho! The hunt begins!',14,0,100,0,0,0,'Baron Ashbury - SAY_AGGRO');
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES (46962,1,0,'Killed by lowly commoners. How droll...',14,0,100,0,0,0,'Baron Ashbury - SAY_DEATH');
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES (46962,2,0,'There was no sport in that kill.',14,0,100,0,0,0,'Baron Ashbury - SAY_KILL');
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES (46962,3,0,'Pathetic.',14,0,100,0,0,0,'Baron Ashbury - SAY_KILL_1');
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES (46962,4,0,'This is just too easy...',14,0,100,0,0,0,'Baron Ashbury - SAY_ASPHYXIATE');
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES (46962,5,0,'HA! Let''s at least keep it interesting.',14,0,100,0,0,0,'Baron Ashbury - SAY_STAY_OF_EXECUTION');
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES (46962,6,0,'I grow tired of this hunt... Time to die!',14,0,100,0,0,0,'Baron Ashbury - SAY_ARCHANGEL');
UPDATE creature_template SET ScriptName = 'boss_baron_silverlaine' WHERE entry = 3887;
DELETE FROM `creature_text` WHERE `entry`=3887;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES (3887,0,0,'Leave this accursed place at once!',14,0,100,0,0,0,'Baron Silverlaine - SAY_AGGRO');
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES (3887,1,0,'This death is only a temporary respite from my curse.',14,0,100,0,0,0,'Baron Silverlaine - SAY_DEATH');
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES (3887,2,0,'I hope your spirit finds solace.',14,0,100,0,0,0,'Baron Silverlaine - SAY_KILL');
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES (3887,3,0,'May you rest in peace.',14,0,100,0,0,0,'Baron Silverlaine - SAY_KILL_1');


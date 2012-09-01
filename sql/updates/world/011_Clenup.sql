-- Winddle Chispabrillo
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 29261;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=29261 AND `source_type`=0);
DELETE FROM `creature` WHERE `id`=29261;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(102700, 29261, 571, 1, 1, 26078, 0, 5744.94, 681.546, 644.136, 5.65487, 300, 0, 0, 8508, 7981, 0, 0, 0, 0);
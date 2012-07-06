SET NAMES `latin1`;

/* 
* sql\updates\world\algalon.sql 
*/ 
UPDATE `creature_template` SET `equipment_id` = 28053, `RegenHealth` = 0  WHERE `entry` = 32871; 
DELETE FROM `creature_equip_template` WHERE (`entry`= 28053);
INSERT INTO `creature_equip_template` (`entry`, `itemEntry1`, `itemEntry2`, `itemEntry3`) VALUES (28053, 45985, 45985, 0);

UPDATE `creature_template` SET `ScriptName` = 'mob_algalon_asteroid_trigger' WHERE `entry` = 33104;
UPDATE `creature_template` SET `ScriptName` = 'mob_living_constellation' WHERE `entry` = 33052;
UPDATE `creature_template` SET `ScriptName` = 'mob_collapsing_star' WHERE `entry` = 32955;
UPDATE `creature_template` SET `ScriptName` = 'mob_black_hole' WHERE `entry` = 32953;
UPDATE `creature_template` SET `ScriptName` = 'mob_dark_matter_algalon' WHERE `entry` = 33089;

UPDATE `creature_template` SET `equipment_id` = 1857, `ScriptName` = 'mob_brann_algalon' WHERE `entry` = 34064;

UPDATE `gameobject_template` SET `ScriptName` = 'go_celestial_console' WHERE `entry` = 194628;
UPDATE `gameobject_template` SET `flags` = 34 WHERE `entry` = 194628;

DELETE FROM `creature` WHERE `id`=32871; 
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(1000376, 32871, 603, 1, 1, 0, 28053, 1632.11, -303.365, 432.321, 1.57079, 300, 0, 0, 8367000, 0, 0, 0, 0, 0);

DELETE FROM `gameobject` WHERE `id`=194628; 
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(500323, 194628, 603, 1, 1, 1646.28, -175.381, 427.257, 1.57079, 0, 0, 0.723219, 0.690619, 300, 0, 1);

/*DELETE FROM `conditions` WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN (62304,64996,64597,62168);
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES 
( '13','0','62304','0','18','1','33104','0','0','','Algalon Cosmic Smash Missle'), -- 10 man
( '13','0','64597','0','18','1','33104','0','0','','Algalon Cosmic Smash Missle'), -- 25 man
( '13','0','64996','0','18','1','34246','0','0','','Algalon Reorigination'), -- visual
( '13','0','62168','0','18','1','0','0','0','','Black Hole Shift'); -- Players Only*/


DELETE FROM `spell_script_names` WHERE `spell_id` IN(64412,62293,62295,62311,64596,64443,64584,62168,62301,64598,64487,65312, 65121, 63018, 63024, 64234);
INSERT INTO `spell_script_names`(`spell_id`,`ScriptName`) VALUES 
( '64412','spell_algalon_phase_punch'),
( '62295','spell_algalon_summon_asteroid_stalkers'),
( '62293','spell_algalon_summon_asteroid_stalkers'),
( '62311','spell_algalon_cosmic_smash_damage'),
( '64596','spell_algalon_cosmic_smash_damage'),
( '64443','spell_algalon_big_bang'),
( '64584','spell_algalon_big_bang'),
( '62168','spell_algalon_black_hole'),
( '62301','spell_algalon_cosmic_smash_initial'), 
( '64598','spell_algalon_cosmic_smash_initial'),
( '65121','spell_xt002_searing_light_spawn_life_spark'), 
( '63018','spell_xt002_searing_light_spawn_life_spark'),
( '63024','spell_xt002_gravity_bomb_aura'), 
( '64234','spell_xt002_gravity_bomb_aura'),
( '64487','spell_algalon_ascend_to_the_heavens');


DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN(62168);
INSERT INTO `spell_linked_spell`(`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES ( '62168','62169','2','Algalon - Black Hole Damage');

DELETE FROM `creature_text` WHERE `entry` IN(32871,34064);

insert into `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) values
('32871','0','0','Your actions are illogical. All possible results for this encounter have been calculated. The Pantheon will receive the Observer''s message regardless of outcome.','14','0','100','1','0','15386','Algalon Aggro'),
('32871','1','0','Loss of life, unavoidable.','14','0','100','0','0','15837','Algalon JustKilled1'),
('32871','1','1','I do what I must.','14','0','100','0','0','15838','Algalon JustKilled2'),
('32871','2','0','See your world through my eyes: A universe so vast as to be immeasurable - incomprehensible even to your greatest minds.','14','0','100','1','0','15390','Algalon FirstEngaged'),
('32871','3','0','The stars come to my aid.','14','0','100','0','0','15392','Algalon SummonCollapsingStars'),
('32871','4','0','I have seen worlds bathed in the Makers'' flames. Their denizens fading without so much as a whimper. Entire planetary systems born and raised in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart, devoid of emotion... of empathy. I... have... felt... NOTHING! A million, million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?','12','0','100','0','0','15393','Algalon Death1'),
('32871','6','0','Perhaps it is your imperfection that which grants you free will. That allows you to persevere against all cosmically calculated odds. You prevailed where the Titans'' own perfect creations have failed.','12','0','100','1','0','15401','Algalon Death2'),
('32871','7','0','I''ve rearranged the reply code. Your planet will be spared. I cannot be certain of my own calculations anymore.','12','0','100','1','0','15402','Algalon Death3'),
('32871','8','0','I lack the strength to transmit the signal. You must hurry. Find a place of power close to the skies.','12','0','100','1','0','15403','Algalon Death4'),
('32871','9','0','Do not worry about my fate Bronzen. If the signal is not transmitted in time re-origination will proceed regardless. Save. Your. World.','12','0','100','1','0','15404','Algalon Death5'),
('32871','10','0','You are... out of time.','14','0','100','0','0','15394','Algalon Berserk'),
('32871','11','0','Witness the fury of the cosmos!','14','0','100','0','0','15396','Algalon BigBang'),
('32871','12','0','Behold the tools of creation!','14','0','100','0','0','15397','Algalon Phaseswitch'),
('32871','13','0','Trans-location complete. Commencing planetary analysis of Azeroth.','12','0','100','0','0','15405','Algalon Summon1'),
('32871','14','0','Stand back, mortals. I am not here to fight you.','12','0','100','0','0','15406','Algalon Summon2'),
('32871','15','0','It is in the universe''s best interest to re-originate this planet should my analysis find systemic corruption. Do not interfere.','12','0','100','0','0','15407','Algalon Summon3'),
('32871','16','0','Analysis complete. There is partial corruption in the planet''s life-support systems as well as complete corruption in most of the planet''s defense mechanisms.','14','0','100','1','0','15398','Algalon Timeout'),
('32871','17','0','Begin uplink: Reply Code: ''Omega''. Planetary re-origination requested..','14','0','100','1','0','15399','Algalon Timeout2'),
('32871','18','0','Farewell, mortals. Your bravery is admirable, for such flawed creatures.','14','0','100','1','0','15400','Algalon Timeout3'),
('32871','19','0','Algalon the Observer begins to Summon Collapsing Stars!','41','0','100','0','0','0','Algalon Summon Stars'),
('32871','20','0','Algalon the Observer begins to cast Cosmic Smash','41','0','100','0','0','0','Algalon Cosmic Smash'),
('32871','21','0','Algalon the Observer begins to cast Big Bang!','41','0','100','0','0','0','Algalon Big Bang'),
('34064','0','0','We did it, lads! We got here before Algalon''s arrival. Maybe we can rig the systems to interfere with his analysis--','14','0','100','0','0','15824','Brann AlgalonSummoned01'),
('34064','1','0','I''ll head back to the archivum and see if I can jam his signal. I might be able to buy us some time while you take care of him.','14','0','100','0','0','15825','Brann AlgalonSummoned02'),
('34064','2','0','I know just the place. Will you be all right?','12','0','100','0','0','15823','Brann AlgalonDefeated');

DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 10678;
INSERT INTO `achievement_criteria_data` VALUES
(10678,11,0,0,'achievement_herald_of_the_titans'); 
 
/* 
* sql\updates\world\asamblea_wip.sql 
*/ 
DELETE FROM spell_script_names WHERE spell_id IN (61911, 63495);
INSERT INTO spell_script_names VALUES
(61911, 'spell_steelbreaker_static_disruption'),
(63495, 'spell_steelbreaker_static_disruption');

DELETE FROM spell_script_names WHERE spell_id = 61900;
INSERT INTO spell_script_names VALUES
(61900, 'spell_steelbreaker_electrical_charge');

DELETE FROM disables WHERE entry IN (10087,10086, 10085, 10084, 10083, 10082) AND sourcetype = 4;
delete from `achievement_criteria_data` where criteria_id in (10087,10086, 10085, 10084, 10083, 10082);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
('10087','11','0','0','achievement_i_choose_you'),
('10086','11','0','0','achievement_i_choose_you'),
('10085','11','0','0','achievement_i_choose_you'),
('10084','11','0','0','achievement_i_choose_you'),
('10083','11','0','0','achievement_i_choose_you'),
('10082','11','0','0','achievement_i_choose_you');

DELETE FROM disables WHERE entry IN (10419,10418, 10088, 10089, 10420, 10421) AND sourcetype = 4; 
delete from `achievement_criteria_data` where criteria_id in (10419,10418, 10088, 10089, 10420, 10421);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
('10419','11','0','0','achievement_but_i_am_on_your_side'),
('10418','11','0','0','achievement_but_i_am_on_your_side'),
('10088','11','0','0','achievement_but_i_am_on_your_side'),
('10089','11','0','0','achievement_but_i_am_on_your_side'),
('10420','11','0','0','achievement_but_i_am_on_your_side'),
('10421','11','0','0','achievement_but_i_am_on_your_side');
 
 
/* 
* sql\updates\world\assembly.sql 
*/ 
DELETE FROM `achievement_criteria_data` WHERE `ScriptName`='achievement_cant_do_that_while_stunned';
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(10090,11,0,0,'achievement_cant_do_that_while_stunned'),
(10422,11,0,0,'achievement_cant_do_that_while_stunned'),
(10423,11,0,0,'achievement_cant_do_that_while_stunned'),
(10091,11,0,0,'achievement_cant_do_that_while_stunned'),
(10424,11,0,0,'achievement_cant_do_that_while_stunned'),
(10425,11,0,0,'achievement_cant_do_that_while_stunned');

DELETE FROM `disables` WHERE `sourceType`=4 AND `entry` IN (10090,10422,10423,10091,10424,10425); 
 
/* 
* sql\updates\world\brain_of_yoggsaron.sql 
*/ 
UPDATE `creature_template` SET `difficulty_entry_1`=33954 WHERE `entry`=33890; 
 
/* 
* sql\updates\world\ignis.sql 
*/ 
DELETE FROM achievement_criteria_data WHERE criteria_id IN (10073, 10072);
INSERT INTO achievement_criteria_data VALUES
('10073','11','0','0','achievement_ignis_stokin_furnace'),
('10072','11','0','0','achievement_ignis_stokin_furnace');

DELETE FROM disables WHERE entry IN (10073,10072) AND sourcetype = 4;  
 
/* 
* sql\updates\world\mimiron.sql 
*/ 
-- ##########################################################
-- Mimiron
-- ##########################################################
-- Mimiron Tram
UPDATE `gameobject_template` SET `flags` = 32, `data2` = 3000, `ScriptName` = 'go_call_tram' WHERE `entry` IN (194914, 194912, 194437);
DELETE FROM gameobject WHERE id = '194437';
INSERT INTO `gameobject` (`guid`,`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
('500324', '194437','603','1','1','2306.87','274.237','424.288','1.52255','0','0','0.689847','0.723956','300','0','1');
DELETE FROM gameobject_template WHERE entry = '194438';
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
('194438','1','8504','Activate Tram','','','','0','32','1','0','0','0','0','0','0','0','0','3000','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','go_call_tram','11159');
DELETE FROM gameobject WHERE id = '194438';
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(500325,194438, 603, 1,1,2306.99, 2589.35, 424.382, 4.71676, 0, 0, 0.705559, -0.708651, 300, 0, 1);

-- Mimiron
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_mimiron' WHERE `entry` = 33350;
-- Leviathan MKII
UPDATE `creature_template` SET `vehicleid` = 370, `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_leviathan_mk' WHERE `entry` = 33432;
UPDATE `creature_template` SET `minlevel` = 83, `maxlevel` = 83, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` = 34106;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `ScriptName` = 'boss_leviathan_mk_turret' WHERE `entry` = 34071;
DELETE FROM vehicle_template_accessory WHERE entry = 33432;
INSERT INTO vehicle_template_accessory VALUE (33432, 34071, 3, 1, 'Leviathan Mk II turret', 8, 0);
UPDATE creature_template SET ScriptName = 'npc_proximity_mine' WHERE entry = 34362;
DELETE FROM `creature_model_info` WHERE `modelid`=28831;
INSERT INTO `creature_model_info` (`modelid`, `bounding_radius`, `combat_reach`, `gender`, `modelid_other_gender`) VALUES
(28831, 0.5, 7, 2, 0);
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (33432,33651);
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`cast_flags`,`user_type`) VALUES
(33432,46598,1,0), -- Leviatan MKII - Ride Vehicle Hardcoded
(33651,46598,1,0); -- VX 001 - Ride Vehicle Hardcoded

-- VX-001
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1, `vehicleid` = 371, `ScriptName` = 'boss_vx_001' WHERE `entry` = 33651;
UPDATE `creature_template` SET `minlevel` = 83, `maxlevel` = 83, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` = 34108;
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35 WHERE `entry` = 34050;
UPDATE `creature_template` SET `unit_flags` = 33686020, `flags_extra` = 2 WHERE `entry` = 34211;
UPDATE `creature_template` SET `ScriptName` = 'npc_rocket_strike' WHERE `entry` = 34047;

-- Aerial Command Unit
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235, `flags_extra` = 1, `ScriptName` = 'boss_aerial_unit', `vehicleid` = 372 WHERE `entry` = 33670;
UPDATE `creature_template` SET `minlevel` = 83, `maxlevel` = 83, `mechanic_immune_mask` = 650854235, `flags_extra` = 1 WHERE `entry` = 34109;
UPDATE `creature_template` SET `ScriptName` = 'npc_magnetic_core' WHERE `entry` = 34068;
UPDATE `creature_template` SET `ScriptName` = 'npc_assault_bot' WHERE `entry` = 34057;
UPDATE `creature_template` SET `difficulty_entry_1` = 34148, `ScriptName` = 'npc_emergency_bot' WHERE `entry` = 34147;

-- HardMode
UPDATE `gameobject_template` SET `flags` = 32, `ScriptName` = 'go_not_push_button' WHERE `entry` = 194739;
UPDATE `creature_template` SET `difficulty_entry_1` = 34361, `ScriptName` = 'npc_frost_bomb' WHERE `entry` = 34149;
UPDATE `creature_template` SET `speed_walk` = 0.15, `speed_run` = 0.15, `ScriptName` = 'npc_mimiron_flame_trigger' WHERE `entry` = 34363;
UPDATE `creature_template` SET `ScriptName` = 'npc_mimiron_flame_spread' WHERE `entry` = 34121;
UPDATE `creature_template` SET `ScriptName` = 'npc_mimiron_bomb_bot' WHERE `entry` = 33836;

-- CleanUp
DELETE FROM creature WHERE id IN (34071, 33856);
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` = 34143;

-- Leviathan Hitpoints
UPDATE `creature_template` SET `exp`=0 WHERE `entry` IN (33432,34071,34106);

/*DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=63414;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,63414,18,1,33651);*/

DELETE FROM `spell_script_names` WHERE `spell_id`=63382;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(63382, 'spell_rapid_burst');

/*DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (64570,65192,64626,65333,64619);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,64570,18,1,34121),
(13,64570,18,1,34363),
(13,65192,18,1,34121),
(13,65192,18,1,34363),
(13,64626,18,1,34121),
(13,64626,18,1,34363),
(13,65333,18,1,34121),
(13,65333,18,1,34363),
(13,64619,18,1,34121),
(13,64619,18,1,34363);*/

UPDATE `creature_template` SET `faction_A`=14, `faction_H`=14 WHERE `entry` IN (34149,34361);

-- Junk Bot
UPDATE `creature_template` SET `difficulty_entry_1`=34114 WHERE `entry`=33855;
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16, `dmg_multiplier`=15 WHERE `entry`=34114;

-- not-so-friendly fire + rocket strike targets
/*DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (63041,65040,65346);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,63041,18,1,33836),
(13,63041,18,1,34362),
(13,63041,18,1,33855),
(13,63041,18,1,34057),
(13,63041,18,1,34147),
(13,63041,18,1,0),
-- only players
(13,65040,18,1,0),
(13,65346,18,1,0);*/

-- not-so-friendly fire
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10405,10406) AND `type`=18;

-- firefighter
DELETE FROM `disables` WHERE `sourceType`=4 AND `entry` IN (10450,10463);
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10450,10463) AND `type`=11;
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`)
VALUES
(10450,11,0,0, 'achievement_firefighter'),
(10463,11,0,0, 'achievement_firefighter');
DELETE FROM `creature_addon` WHERE `guid` = 137619;
DELETE FROM `creature_addon` WHERE `guid` between 137621 and 137629; 
 
/* 
* sql\updates\world\thorim.sql 
*/ 
-- ##########################################################
-- Thorim
-- ##########################################################
-- Thorim
UPDATE `creature_template` SET `speed_walk` = 1.66667, `mechanic_immune_mask` = 650854239, `flags_extra` = 1, `ScriptName` = 'boss_thorim' WHERE `entry` = 32865;
UPDATE `creature_template` SET `speed_walk` = 1.66667, `baseattacktime` = 1500, `equipment_id` = 1844, `mechanic_immune_mask` = 650854239 WHERE `entry` = 33147;
DELETE FROM `creature` WHERE `id`=32865;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES
(1000377, 32865, 603, 3, 1, 28977, 0, 2134.967, -298.962, 438.331, 1.57, 604800, 0, 0, 4183500, 425800, 0);
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=62042;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
('62042','62470','1','Thorim: Deafening Thunder');
UPDATE `gameobject_template` SET `flags` = 0 WHERE `entry` IN (194312, 194313, 194314, 194315);

/*-- Charge Orb
DELETE FROM conditions WHERE SourceEntry = 62016;
INSERT INTO `conditions` VALUES
('13','0','62016','0','0','29','0','33378','1','0','0','0','',NULL);*/
UPDATE `creature_template` SET `unit_flags` = 33685508 WHERE `entry` = 33378;

-- Gate
DELETE FROM `gameobject_scripts` WHERE `id`=55194;
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES 
(55194, 0, 11, 34155, 15, '0', 0, 0, 0, 0);
DELETE FROM `gameobject_template` WHERE `entry`=194265;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
('194265','1','295','Lever','','','','35','48','3','0','0','0','0','0','0','0','0','6000','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0');
UPDATE `gameobject` SET `id` = 194265, `rotation2` = 1, `rotation3` = 0, `spawntimesecs` = 7200, `animprogress` = 100 WHERE `guid` = 55194;

-- Cleanup
DELETE FROM `creature` WHERE `id` IN (32885, 32883, 32908, 32907, 32882, 33110, 32886, 32879, 32892, 33140, 33141, 33378, 32874, 32875);

-- Pre adds
UPDATE `creature_template` SET `equipment_id` = 1849, `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32885;
UPDATE `creature_template` SET `equipment_id` = 1849 WHERE `entry` = 33153;
UPDATE `creature_template` SET `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32883;
UPDATE `creature_template` SET `equipment_id` = 1847 WHERE `entry` = 33152;
UPDATE `creature_template` SET `equipment_id` = 1850, `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32908;
UPDATE `creature_template` SET `equipment_id` = 1850 WHERE `entry` = 33151;
UPDATE `creature_template` SET `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32907;
UPDATE `creature_template` SET `equipment_id` = 1852 WHERE `entry` = 33150;
UPDATE `creature_template` SET `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32882;
UPDATE `creature_template` SET `ScriptName` = 'npc_thorim_pre_phase' WHERE `entry` = 32886;
UPDATE `creature_template` SET `modelid1` = 16925, `modelid2` = 0 WHERE `entry`IN (33378, 32892);

-- Thorim Mini bosses
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239, `flags_extra` = 1, `ScriptName` = 'npc_runic_colossus' WHERE `entry` = 32872;
UPDATE `creature_template` SET `ScriptName`='npc_runic_smash' WHERE `entry`=33140;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239, `flags_extra` = 1, `ScriptName` = 'npc_ancient_rune_giant' WHERE `entry` = 32873;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239, `flags_extra` = 1, `ScriptName` = 'npc_sif' WHERE `entry` = 33196;
UPDATE `creature_template` SET `ScriptName` = 'npc_thorim_arena_phase' WHERE `entry` IN (32876, 32904, 32878, 32877, 32874, 32875, 33110);
DELETE FROM `creature_addon` WHERE `guid`IN (136059, 136816);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
('136059','0','0','0','1','0','40775 0'),
('136816','0','0','0','1','0','40775 0');

/*DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (62942,62466,62976,64098);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13, 62942, 18, 1, 33110),
(13, 62942, 18, 1, 32874),
(13, 62942, 18, 1, 32872),
(13, 62942, 18, 1, 32875),
(13, 62466, 18, 1, 32780),
(13, 64098, 18, 1, 32865),
(13, 62976, 18, 1, 34055);*/

UPDATE `creature_template` SET `faction_A`=35, `faction_H`=35 WHERE `entry`=34055;

-- thorim - lightning orb (temporary)
UPDATE `creature_template` SET `speed_run`=9.6, `dmg_multiplier`=200, `baseattacktime`=1000, `Health_mod`=100 WHERE `entry`=33138;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (62042, 62016, 62505); 
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(62042, 'spell_stormhammer_targeting'),
(62016, 'spell_charge_orb'),
(62505, 'spell_razorscale_harpoon');

UPDATE `creature_template` SET `dmg_multiplier`=20 WHERE `entry`=32865;
UPDATE `creature_template` SET `dmg_multiplier`=40 WHERE `entry`=33147;
UPDATE `creature` SET `position_z`=440.331 WHERE `id`=32865;
UPDATE `creature_addon` SET `auras`='40775' WHERE `guid`=136816;
UPDATE `creature_addon` SET `auras`='40775' WHERE `guid`=136059;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10304,10313) AND `type` IN (11,18);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`)
VALUES
(10304,11,0,0, 'achievement_who_needs_bloodlust'),
(10313,11,0,0, 'achievement_who_needs_bloodlust'); 
 
/* 
* sql\updates\world\tren_ulduar.sql 
*/ 
DELETE FROM `gameobject_template` WHERE `entry` IN (194437, 194914, 194912, 194438, 194675);

INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`) VALUES('194437','1','8504','Activate Tram','','','','0','32','1','0','0','0','0','0','0','0','0','3000','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','go_call_tram','12340');
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`) VALUES('194914','1','8504','Call Tram','','','','0','32','2.17','0','0','0','0','0','0','0','0','3000','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','go_call_tram','12340');
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`) VALUES('194912','1','8504','Call Tram','','','','0','32','2.17','0','0','0','0','0','0','0','0','3000','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','go_call_tram','12340');
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`) VALUES('194438','1','8504','Activate Tram','','','','0','32','1','0','0','0','0','0','0','0','0','3000','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','go_call_tram','11159');
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`) VALUES('194675','11','8587','Tram','','','','0','40','1','0','0','0','0','0','0','66000','0','0','21393','21394','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340');

DELETE FROM `gameobject` WHERE (`guid`=500326);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (500326, 194437, 603, 3, 1, 2306.87, 274.237, 424.288, 1.52255, 0, 0, 0.689847, 0.723956, 300, 0, 1);

DELETE FROM `gameobject` WHERE (`guid`=500327);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (500327, 194438, 603, 3, 1, 2306.99, 2589.35, 424.382, 4.71676, 0, 0, 0.705559, -0.708651, 300, 0, 1);
 
 
/* 
* sql\updates\world\ulduar_gauntlet.sql 
*/ 
-- Delorah texts

DELETE FROM `creature_text` WHERE `entry` = 33701;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(33701, 0, 0, 'I heard a story or two of a Lore Keeper in Uldaman that fit your description. Do you serve a similar purpose?', 12, 0, 0, 0, 0, 0, 'Dellorah SAY_EVENT_1'),
(33701, 1, 0, 'Frontal defense systems? Is there something I should let Brann know before he has anyone attempt to enter the complex?', 12, 0, 0, 0, 0, 0, 'Dellorah SAY_EVENT_2'),
(33701, 2, 0, 'Can you detail the nature of these defense systems?', 12, 0, 0, 0, 0, 0, 'Dellorah SAY_EVENT_3'),
(33701, 3, 0, 'Got it. At least we don\'t have to deal with those orbital emplacements.', 12, 0, 0, 0, 0, 0, 'Dellorah SAY_EVENT_4'),
(33701, 4, 0, 'Rhydian, make sure you let Brann and Archmage Pentarus know about those defenses immediately.', 12, 0, 0, 0, 0, 0, 'Dellorah SAY_EVENT_5'),
(33701, 5, 0, 'And you mentioned an imprisoned entity? What is the nature of this entity and what is its status?', 12, 0, 0, 0, 0, 0, 'Dellorah SAY_EVENT_7'),
(33701, 7, 0, 'Yogg-Saron is here? It sounds like we really will have our hands full then.', 12, 0, 0, 0, 0, 0, 'Dellorah SAY_EVENT_8'),
(33701, 8, 0, 'What... What did you just do, $n?! Brann! Braaaaannn! ', 14, 0, 0, 0, 0, 0, 'Dellorah SAY_BRANN'),
(33701, 9, 0, 'Brann! $n just activated the orbital defense system! If we dont get out here soon, we re going to be toast!', 14, 0, 0, 0, 0, 0, 'Dellorah SAY_BRANN2');

-- Norgannon texts
DELETE FROM `creature_text` WHERE `entry` = 33686;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(33686, 0, 0, ' I was constructed to serve as a repository for essential information regarding this complex. My primary functions include communicating the status of the frontal defense systems and assessing the status of the entity that this complex was built to imprison.', 12, 0, 0, 0, 0, 0, 'Norgannon SAY_EVENT_1'),
(33686, 1, 0, 'Access to the interior of the complex is currently restricted. Primary defensive emplacements are active. Secondary systems are currently non-active.', 12, 0, 0, 0, 0, 0, 'Norgannon SAY_EVENT_2'),
(33686, 2, 0, 'Compromise of complex detected, security override enabled - query permitted.', 12, 0, 0, 0, 0, 0, 'Norgannon SAY_EVENT_3'),
(33686, 3, 0, 'Primary defensive emplacements consist of iron constructs and Storm Beacons, which will generate additional constructs as necessary. Secondary systems consist of orbital defense emplacements.', 12, 0, 0, 0, 0, 0, 'Norgannon SAY_EVENT_4'),
(33686, 7, 0, 'Entity designate: Yogg-Saron. Security has been compromised. Prison operational status unknown. Unable to contact Watchers for notification purposes.', 12, 0, 0, 0, 0, 0, 'Norgannon SAY_EVENT_8'),
(33686, 10, 0, 'Deactivate', 12, 0, 0, 0, 0, 0, 'Norgannon SAY_DEACTIVATE');

-- Rhydian emotes
DELETE FROM `creature_text` WHERE `entry` = 33696;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(33696, 6, 0, '%s nods.', 16, 0, 0, 0, 0, 0, 'Rhydian SAY_EVENT_6'),
(33696, 11, 0, '%s whispers something to Brann', 16, 0, 0, 0, 0, 0, 'Rhydian SAY_WHISPER');
 
 
/* 
* sql\updates\world\ulduar_intro.sql 
*/ 
-- Delorah texts
DELETE FROM `creature_text` WHERE `entry` = 33701;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(33701, 0, 0, 'I heard a story or two of a Lore Keeper in Uldaman that fit your description. Do you serve a similar purpose?', 12, 0, 0, 0, 0, 0, 'Dellorah SAY_EVENT_1'),
(33701, 1, 0, 'Frontal defense systems? Is there something I should let Brann know before he has anyone attempt to enter the complex?', 12, 0, 0, 0, 0, 0, 'Dellorah SAY_EVENT_2'),
(33701, 2, 0, 'Can you detail the nature of these defense systems?', 12, 0, 0, 0, 0, 0, 'Dellorah SAY_EVENT_3'),
(33701, 3, 0, 'Got it. At least we don\'t have to deal with those orbital emplacements.', 12, 0, 0, 0, 0, 0, 'Dellorah SAY_EVENT_4'),
(33701, 4, 0, 'Rhydian, make sure you let Brann and Archmage Pentarus know about those defenses immediately.', 12, 0, 0, 0, 0, 0, 'Dellorah SAY_EVENT_5'),
(33701, 5, 0, 'And you mentioned an imprisoned entity? What is the nature of this entity and what is its status?', 12, 0, 0, 0, 0, 0, 'Dellorah SAY_EVENT_7'),
(33701, 7, 0, 'Yogg-Saron is here? It sounds like we really will have our hands full then.', 12, 0, 0, 0, 0, 0, 'Dellorah SAY_EVENT_8'),
(33701, 8, 0, 'What... What did you just do, $n?! Brann! Braaaaannn! ', 14, 0, 0, 0, 0, 0, 'Dellorah SAY_BRANN'),
(33701, 9, 0, 'Brann! $n just activated the orbital defense system! If we dont get out here soon, we re going to be toast!', 14, 0, 0, 0, 0, 0, 'Dellorah SAY_BRANN2');

-- Norgannon texts
DELETE FROM `creature_text` WHERE `entry` = 33686;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(33686, 0, 0, ' I was constructed to serve as a repository for essential information regarding this complex. My primary functions include communicating the status of the frontal defense systems and assessing the status of the entity that this complex was built to imprison.', 12, 0, 0, 0, 0, 0, 'Norgannon SAY_EVENT_1'),
(33686, 1, 0, 'Access to the interior of the complex is currently restricted. Primary defensive emplacements are active. Secondary systems are currently non-active.', 12, 0, 0, 0, 0, 0, 'Norgannon SAY_EVENT_2'),
(33686, 2, 0, 'Compromise of complex detected, security override enabled - query permitted.', 12, 0, 0, 0, 0, 0, 'Norgannon SAY_EVENT_3'),
(33686, 3, 0, 'Primary defensive emplacements consist of iron constructs and Storm Beacons, which will generate additional constructs as necessary. Secondary systems consist of orbital defense emplacements.', 12, 0, 0, 0, 0, 0, 'Norgannon SAY_EVENT_4'),
(33686, 7, 0, 'Entity designate: Yogg-Saron. Security has been compromised. Prison operational status unknown. Unable to contact Watchers for notification purposes.', 12, 0, 0, 0, 0, 0, 'Norgannon SAY_EVENT_8'),
(33686, 10, 0, 'Deactivate', 12, 0, 0, 0, 0, 0, 'Norgannon SAY_DEACTIVATE');

-- Rhydian emotes
DELETE FROM `creature_text` WHERE `entry` = 33696;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(33696, 6, 0, '%s nods.', 16, 0, 0, 0, 0, 0, 'Rhydian SAY_EVENT_6'),
(33696, 11, 0, '%s whispers something to Brann', 16, 0, 0, 0, 0, 0, 'Rhydian SAY_WHISPER');

-- Gountlet
UPDATE `creature_template` SET `ScriptName` = 'npc_gauntlet_generator' WHERE `entry` = 34159;
UPDATE `creature_template` SET `ScriptName`= 'npc_ulduar_lorekeeper' WHERE `entry`= 33686;
UPDATE `creature_template` SET `ScriptName` = 'npc_ulduar_warmage' WHERE entry = 33662;
UPDATE `creature_template` SET `ScriptName` = 'npc_bronzebeard_radio' WHERE entry = 34054;
UPDATE `creature_template` SET `ScriptName` = 'npc_ulduar_engineer' WHERE entry = 33626;

-- Spawns 10/25 NORMAL
DELETE FROM `creature` WHERE `guid` IN (1000378,1000379,1000380,1000381,1000382,1000383,1000384,1000385);
INSERT INTO `creature` VALUES 
('1000378', '27306', '603', '3', '1', '0', '0', '-665.945', '-5.68514', '518.75', '0.538015', '300', '0', '0', '42', '0', '0', '0', '0', '0'),
('1000379', '27306', '603', '3', '1', '0', '0', '-642', '-101.168', '518.75', '6.16147', '300', '0', '0', '42', '0', '0', '0', '0', '0'),
('1000380', '34054', '603', '3', '1', '0', '0', '-79.2613', '112.818', '433.792', '1.6148', '300', '0', '0', '75600', '0', '0', '0', '0', '0'),
('1000381', '34054', '603', '3', '1', '0', '0', '-225.065', '-274.866', '369.466', '1.59124', '300', '0', '0', '75600', '0', '0', '0', '0', '0'),
('1000382', '34054', '603', '3', '1', '0', '0', '83.5056', '-371', '410.819', '1.6423', '300', '0', '0', '75600', '0', '0', '0', '0', '0'),
('1000383', '34054', '603', '3', '1', '0', '0', '317.382', '318.532', '409.802', '3.01675', '300', '0', '0', '75600', '0', '0', '0', '0', '0'),
('1000384', '34054', '603', '3', '1', '0', '0', '138.118', '56.1308', '410.969', '5.81588', '300', '0', '0', '75600', '0', '0', '0', '0', '0'),
('1000385', '34054', '603', '3', '1', '0', '0', '130.321', '-127.606', '410.968', '5.25824', '300', '0', '0', '75600', '0', '0', '0', '0', '0');
 
 
/* 
* sql\updates\world\ulduar_wip.sql 
*/ 

UPDATE creature_template SET ScriptName = 'npc_flame_leviathan_seat' WHERE entry = 33114;
UPDATE creature_template SET ScriptName = 'npc_flame_leviathan_defense_turret' WHERE entry = 33142;
UPDATE creature_template SET ScriptName = 'npc_flame_leviathan_defense_cannon' WHERE entry = 33139;
UPDATE creature_template SET ScriptName = 'npc_flame_leviathan_overload_device' WHERE entry = 33143;
UPDATE creature_template SET ScriptName = 'npc_liquid_pyrite' WHERE entry = 33189;
UPDATE creature_template SET ScriptName = 'npc_freyas_ward_summon' WHERE entry IN (33387, 34275);
UPDATE creature_template SET ScriptName = 'npc_leviathan_player_vehicle' WHERE entry IN (33060, 33062, 33109);
UPDATE creature_template SET ScriptName = 'mob_saronit_vapor' WHERE entry = 33488;
UPDATE creature_template SET ScriptName = 'mob_saronit_animus' WHERE entry = 33524;
UPDATE creature_template SET AIName = "" WHERE entry IN (34362, 34047, 34068, 34057, 34147, 33836, 34363, 34121, 34149);
UPDATE creature_template SET ScriptName = 'boss_mimiron' WHERE entry = 33350;
UPDATE creature_template SET ScriptName = 'boss_leviathan_mk' WHERE entry = 33432;
UPDATE creature_template SET ScriptName = 'boss_leviathan_mk_turret' WHERE entry = 34071;
UPDATE creature_template SET ScriptName = 'npc_proximity_mine' WHERE entry = 34362;
UPDATE creature_template SET ScriptName = 'boss_vx_001' WHERE entry = 33651;
UPDATE creature_template SET ScriptName = 'npc_rocket_strike' WHERE entry = 34047;
UPDATE creature_template SET ScriptName = 'boss_aerial_unit' WHERE entry = 33670;
UPDATE creature_template SET ScriptName = 'npc_magnetic_core' WHERE entry = 34068;
UPDATE creature_template SET ScriptName = 'npc_assault_bot' WHERE entry = 34057;
UPDATE creature_template SET ScriptName = 'npc_emergency_bot' WHERE entry = 34147;
UPDATE creature_template SET ScriptName = 'npc_mimiron_bomb_bot' WHERE entry = 33836;
UPDATE creature_template SET ScriptName = 'npc_mimiron_flame_trigger' WHERE entry = 34363;
UPDATE creature_template SET ScriptName = 'npc_mimiron_flame_spread' WHERE entry = 34121;
UPDATE creature_template SET ScriptName = 'npc_frost_bomb' WHERE entry = 34149;
UPDATE creature_template SET ScriptName = 'boss_algalon' WHERE entry = 32871;
UPDATE creature_template SET ScriptName = 'mob_algalon_asteroid_trigger' WHERE entry = 33104;
UPDATE creature_template SET ScriptName = 'mob_collapsing_star' WHERE entry = 32955;
UPDATE creature_template SET ScriptName = 'mob_living_constellation' WHERE entry = 33052;
UPDATE creature_template SET ScriptName = 'mob_black_hole' WHERE entry = 32953;
UPDATE creature_template SET ScriptName = 'mob_dark_matter_algalon' WHERE entry = 33089;
UPDATE creature_template SET ScriptName = 'mob_brann_algalon' WHERE entry = 34064;

UPDATE gameobject_template SET ScriptName = 'go_not_push_button' WHERE entry = 194739;
UPDATE gameobject_template SET ScriptName = 'go_celestial_console' WHERE entry = 194628;

DELETE FROM areatrigger_scripts WHERE entry IN (5369, 5423);
INSERT INTO areatrigger_scripts VALUES 
(5369, 'at_RX_214_repair_o_matic_station'),
(5423, 'at_RX_214_repair_o_matic_station');

DELETE FROM achievement_criteria_data WHERE criteria_id IN (10451, 10462, 10450, 10463, 10678);
INSERT INTO achievement_criteria_data VALUES
('10451','11','0','0','achievement_i_love_the_smell_of_saronite_in_the_morning'),
('10462','11','0','0','achievement_i_love_the_smell_of_saronite_in_the_morning'),
('10450','11','0','0','achievement_firefighter'),
('10463','11','0','0','achievement_firefighter'),
('10678','11','0','0','achievement_herald_of_the_titans');

DELETE FROM spell_script_names WHERE spell_id IN (62359, 64979, 62374, 65044, 65045, 62324, 62907, 63847, 64677, 63018, 65121, 63024, 64234, 62692, 63276, 63278, 61911, 63495, 61900, 63382, 62293, 62295, 62168, 62301, 64598);
INSERT INTO spell_script_names VALUES
(62359, 'spell_anti_air_rocket'),
(64979, 'spell_anti_air_rocket'),
(62374, 'spell_pursued'),
(65044, 'spell_flame_leviathan_flames'),
(65045, 'spell_flame_leviathan_flames'),
(62324, 'spell_throw_passenger'),
(62907, 'spell_freyas_ward_summon'),
(63847, 'spell_flame_leviathan_flame_vents'),
(64677, 'spell_shield_generator'),
(63018, 'spell_xt002_searing_light'),
(65121, 'spell_xt002_searing_light'),
(63024, 'spell_xt002_gravity_bomb'),
(64234, 'spell_xt002_gravity_bomb'),
(62692, 'spell_general_vezax_aura_of_despair_aura'),
(63276, 'spell_general_vezax_mark_of_the_faceless_aura'),
(63278, 'spell_general_vezax_mark_of_the_faceless_drain'),
(61911, 'spell_steelbreaker_static_disruption'),
(63495, 'spell_steelbreaker_static_disruption'),
(61900, 'spell_steelbreaker_electrical_charge'),
(63382, 'spell_rapid_burst'),
(62293, 'spell_algalon_summon_asteroid_stalkers'),
(62295, 'spell_algalon_summon_asteroid_stalkers'),
(62168, 'spell_algalon_black_hole'),
(62301, 'spell_algalon_cosmic_smash_initial'),
(64598, 'spell_algalon_cosmic_smash_initial');
 
 
/* 
* sql\updates\world\yoggsaron.sql 
*/ 

UPDATE creature_template SET scriptname = 'boss_sara' WHERE entry = 33134;
UPDATE script_texts SET npc_entry = 33134 WHERE npc_entry = 33288 AND entry IN (-1603330,-1603331,-1603332,-1603333);
UPDATE script_texts SET content_default = "Help me! Please get them off me!" WHERE npc_entry = 33134 AND entry = -1603310;
UPDATE script_texts SET content_default = "What do you want from me? Leave me alone!" WHERE npc_entry = 33134 AND entry = -1603311;
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry` = 33134;
UPDATE creature_template SET scriptname = 'npc_ominous_cloud' WHERE entry = 33292;
UPDATE creature_template SET scriptname = 'npc_guardian_of_yogg_saron' WHERE entry = 33136;
UPDATE creature_template SET scriptname = 'npc_yogg_saron_tentacle' WHERE entry in (33966,33985,33983);
UPDATE creature_template SET scriptname = 'npc_descend_into_madness' WHERE entry = 34072;
UPDATE creature_template SET scriptname = 'npc_brain_of_yogg_saron' WHERE entry = 33890;
UPDATE creature_template SET scriptname = 'boss_yogg_saron' WHERE entry = 33288;
UPDATE creature_template SET scriptname = 'npc_influence_tentacle' WHERE entry in (33716,33720,33719,33717,33433,33567);
UPDATE creature_template SET scriptname = 'npc_immortal_guardian' WHERE entry = 33988;
UPDATE creature_template SET scriptname = 'npc_support_keeper' WHERE entry in (33410,33411,33412,33413);
UPDATE creature_template SET scriptname = 'npc_sanity_well' WHERE entry = 33991;
UPDATE creature_template SET modelid1 = 11686, modelid2 = 11686 WHERE entry = 33991;
UPDATE creature_template SET scriptname = 'npc_death_orb' WHERE entry = 33882;
UPDATE creature_template SET modelid1 = 16946, modelid2 = 16946 WHERE entry = 33882;
UPDATE creature_template SET scriptname = 'npc_death_ray' WHERE entry = 33881;
UPDATE creature_template SET modelid1 = 17612, modelid2 = 17612 WHERE entry = 33881;
UPDATE creature_template SET minlevel = 80, maxlevel = 80, scriptname = 'npc_laughting_skull' WHERE entry = 33990;
UPDATE creature_template SET modelid1 = 15880, modelid2 = 15880 WHERE entry = 33990;
UPDATE creature_template SET scriptname = 'npc_keeper_help' WHERE entry IN(33241,33244,33242,33213);
UPDATE `creature_template` SET `minlevel`=80  , `maxlevel`=80 WHERE `entry` = 33943;

UPDATE gameobject_template SET scriptname = 'go_flee_to_surface' WHERE entry = 194625;
UPDATE item_template SET scriptname = 'item_unbound_fragments_of_valanyr' WHERE entry = 45896;

UPDATE creature_template SET RegenHealth = 0 WHERE entry IN (33134,34332,33890,33954);

-- Secound Damage Effekt of ShadowNova only on other Guardians or Sara
/*DELETE FROM conditions WHERE SourceEntry = 65209;
INSERT INTO conditions
(SourceTypeOrReferenceId,SourceGroup,SourceEntry,ElseGroup,
 ConditionTypeOrReference,ConditionValue1,ConditionValue2,ConditionValue3,
 ErrorTextId,ScriptName,COMMENT)
VALUES
(13,1,65209,0,18,1,33136,0,0,'','Effekt only for Guardian of YoggSaron'),
(13,1,65209,0,18,1,33134,0,0,'','Effekt only for Sara');*/

DELETE FROM gameobject WHERE id = 194625;
INSERT INTO gameobject
(guid, id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state)
VALUES
(500328, 194625, 603, 3, 1, 2001.40, -59.66, 245.07, 0, 0, 0, 0, 0, 60, 100, 1),
(500329, 194625, 603, 3, 1, 1941.61, -25.88, 244.98, 0, 0, 0, 0, 0, 60, 100, 1),
(500330, 194625, 603, 3, 1, 2001.18,  9.409, 245.24, 0, 0, 0, 0, 0, 60, 100, 1);

-- Auren shouldnt hit other friendly NPCs
DELETE FROM spell_script_names WHERE spell_id IN (62670,62671,62702,62650);
INSERT INTO spell_script_names (spell_id,Scriptname)
VALUES
(62670,'spell_keeper_support_aura_targeting'),
(62671,'spell_keeper_support_aura_targeting'),
(62702,'spell_keeper_support_aura_targeting'),
(62650,'spell_keeper_support_aura_targeting');

-- Script for Target Faces Caster
DELETE FROM spell_script_names WHERE spell_id IN (64164,64168);
INSERT INTO spell_script_names (spell_id,Scriptname)
VALUES
(64164,'spell_lunatic_gaze_targeting'),
(64168,'spell_lunatic_gaze_targeting');

-- Trigger Effekt on Near Player with Brain Link
DELETE FROM spell_script_names WHERE spell_id IN (63802);
INSERT INTO spell_script_names (spell_id,Scriptname)
VALUES
(63802,'spell_brain_link_periodic_dummy');

-- Needed for Titanic Storm
-- Script for Target have Weakened Aura
DELETE FROM spell_script_names WHERE spell_id IN (64172);
INSERT INTO spell_script_names (spell_id,Scriptname)
VALUES
(64172,'spell_titanic_storm_targeting');

-- Condition because NPCs need this else no hit
/*DELETE FROM conditions WHERE SourceEntry in (64172,64465);
INSERT INTO conditions
(SourceTypeOrReferenceId,SourceGroup,SourceEntry,ElseGroup,
 ConditionTypeOrReference,ConditionValue1,ConditionValue2,ConditionValue3,
 ErrorTextId,ScriptName,COMMENT)
VALUES
(13,1,64172,0,18,1,33988,0,0,'','Effekt only for Immortal Guardians'),
(13,1,64465,0,18,1,33988,0,0,'','Effekt only for Immortal Guardians');*/

-- Hodir Secound Aura Script
DELETE FROM spell_script_names WHERE spell_id IN (64174);
INSERT INTO spell_script_names (spell_id,Scriptname)
VALUES
(64174,'spell_hodir_protective_gaze');

-- Insane Death trigger on Remove
DELETE FROM spell_script_names WHERE spell_id IN (63120);
INSERT INTO spell_script_names (spell_id,Scriptname)
VALUES
(63120,'spell_insane_death_effekt');

-- Deathray Effekt on Death Orb
/*DELETE FROM conditions WHERE SourceEntry IN (63882,63886);
INSERT INTO conditions
(SourceTypeOrReferenceId,SourceGroup,SourceEntry,ElseGroup,
 ConditionTypeOrReference,ConditionValue1,ConditionValue2,ConditionValue3,
 ErrorTextId,ScriptName,COMMENT)
VALUES
(13,1,63882,0,18,1,33882,0,0,'','Effekt on Death Orb'),
(13,1,63886,0,18,1,33882,0,0,'','Effekt on Death Orb');*/

-- Correct Summon Position of Tentacle
DELETE FROM spell_script_names WHERE spell_id IN (64139,64143,64133);
INSERT INTO spell_script_names (spell_id,Scriptname)
VALUES
(64139,'spell_summon_tentacle_position'),
(64143,'spell_summon_tentacle_position'),
(64133,'spell_summon_tentacle_position');

-- Heal Trigger for Empowering Shadows
DELETE FROM spell_script_names WHERE spell_id IN (64466);
INSERT INTO spell_script_names (spell_id,Scriptname)
VALUES
(64466,'spell_empowering_shadows');

-- Create Val'anyr on Yogg-Saron
/*DELETE FROM conditions WHERE SourceEntry IN (64184);
INSERT INTO conditions
(SourceTypeOrReferenceId,SourceGroup,SourceEntry,ElseGroup,
 ConditionTypeOrReference,ConditionValue1,ConditionValue2,ConditionValue3,
 ErrorTextId,ScriptName,COMMENT)
VALUES
(13,1,64184,0,18,1,33288,0,0,'','Effekt on YoggSaron');*/

delete FROM script_texts WHERE npc_entry = 33134;
insert into `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) values
('33134','-1603333','Cower before my true form.',NULL,NULL,NULL,NULL,NULL,'¡Temed mi verdadera forma!',NULL,NULL,'0','1','0','0','YoggSaron SAY_PHASE2_4'),
('33134','-1603332','The fiend of a thousand faces.',NULL,NULL,NULL,NULL,NULL,'El demonio de mil caras.',NULL,NULL,'0','1','0','0','YoggSaron SAY_PHASE2_3'),
('33134','-1603331','The monster in your nightmares.',NULL,NULL,NULL,NULL,NULL,'El monstruo de tus pesadillas.',NULL,NULL,'0','1','0','0','YoggSaron SAY_PHASE2_2'),
('33134','-1603330','I am the lucid dream.',NULL,NULL,NULL,NULL,NULL,'Soy un sueño lúcido.',NULL,NULL,'15754','1','0','0','YoggSaron SAY_PHASE2_1'),
('33134','-1603319','Tremble, mortals, before the coming of the end!',NULL,NULL,NULL,NULL,NULL,'¡Temblad, mortales, ante la llegada del fin!',NULL,NULL,'15777','1','0','0','Sara SAY_PHASE2_2'),
('33134','-1603318','Suffocate upon your own hate!',NULL,NULL,NULL,NULL,NULL,'¡Asfixiaos con vuestro odio!',NULL,NULL,'15776','1','0','0','Sara SAY_PHASE2_1'),
('33134','-1603317','Weak-minded fools!',NULL,NULL,NULL,NULL,NULL,'¡Loco descerebrado!',NULL,NULL,'15780','5','0','0','Sara WHISP_INSANITY'),
('33134','-1603316','Could they have been saved?',NULL,NULL,NULL,NULL,NULL,'¿Se podrían haber salvado?',NULL,NULL,'15779','1','0','0','Sara SAY_SLAY_2'),
('33134','-1603315','Powerless to act...',NULL,NULL,NULL,NULL,NULL,'No puedes actuar...',NULL,NULL,'15778','1','0','0','Sara SAY_SLAY_1'),
('33134','-1603314','Let hatred and rage guide your blows!',NULL,NULL,NULL,NULL,NULL,'¡Dejad que el odio y la ira guien vuestros golpes!',NULL,NULL,'15774','1','0','0','Sara SAY_AGGRO_3'),
('33134','-1603313','Yes! YES! Show them no mercy! Give no pause to your attacks!',NULL,NULL,NULL,NULL,NULL,'¡Si! ¡SI! ¡No mostréis piedad! ¡No ceséis vuestros ataques!',NULL,NULL,'15773','1','0','0','Sara SAY_AGGRO_2'),
('33134','-1603312','The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!',NULL,NULL,NULL,NULL,NULL,'¡Pronto llegará la hora de golpear la cabeza del monstruo! ¡Centrad vuestra ira y odio en sus esbirros!',NULL,NULL,'15775','1','0','0','Sara SAY_AGGRO_1'),
('33134','-1603311','What do you want from me? Leave me alone!',NULL,NULL,NULL,NULL,NULL,'¿Qué quereis de mi? ¡Dejarme sola!',NULL,NULL,'15772','1','0','0','Sara SAY_PREFIGHT_2'),
('33134','-1603310','Help me! Please get them off me!',NULL,NULL,NULL,NULL,NULL,'¡Ayudarme! ¡Porfavor sacarmelo!',NULL,NULL,'15771','1','0','0','Sara SAY_PREFIGHT_1');


-- Missing Says Vision
DELETE FROM script_texts WHERE entry BETWEEN -1603360 AND -1603342;
INSERT INTO script_texts (`npc_entry`,`entry`,`content_default`,`sound`,`type`,`language`,`emote`,`comment`)
VALUES
(33436,-1603342,'Bad news sire.',15538,0,0,0,'Garona KingLlaneVision_Say1'),
(33436,-1603343,'The clans are united under Blackhand in this assault. They will stand together until Stormwind has fallen.',15539,0,0,0,'Garona KingLlaneVision_Say2'),
(33436,-1603344,'Gul\'dan is bringing up his warlocks by nightfall. Until then, the Blackrock clan will be trying to take the Eastern Wall.',15540,0,0,0,'Garona KingLlaneVision_Say3'),
(33288,-1603345,'A thousand deaths... or one murder.',15762,0,0,0,'YoggSaron KingLlaneVision_Say1'),
(33288,-1603346,'',15763,0,0,0,'YoggSaron KingLlianeVision_Say2'),
(33437,-1603347,'We will hold until the reinforcements come. As long as men with stout hearts are manning the walls and throne Stormwind will hold.',15585,0,0,0,'KingLlane KingLlaneVision_Say'),
(33436,-1603348,'The orc leaders agree with your assessment.',15541,0,0,0,'Garona KingLlaneVision_Say4'),
(33288,-1603349,'Your petty quarrels only make me stronger!',15764,0,0,0,'YoggSaron KingLlaneVision_Say3'),

(33441,-1603350,'Your resilience is admirable.',15598,0,0,0,'TheLichKing LichKingVision_Say1'),
(33442,-1603351,'Arrrrrrgh!',15470,1,0,0,'ImmolatedChampion LichKingVision_Say1'),
(33442,-1603352,'I\'m not afraid of you!',15471,0,0,0,'ImmolatedChampion LichKingVision_Say2'),
(33441,-1603353,'I will break you as I broke him.',15599,0,0,0,'TheLichKing LichKingVision_Say2'),
(33288,-1603354,'Yrr n\'lyeth... shuul anagg!',15766,0,0,0,'YoggSaron LichKingVision_Say1'),
(33288,-1603355,'He will learn... no king rules forever, only death is eternal!',15767,0,0,0,'YoggSaron LichKingVision_Say2'),

(33523,-1603356,'It is done... All have been given that which must be given. I now seal the Dragon Soul forever...',15631,0,0,0,'Neltharion DragonSoulVision_Say1'),
(33495,-1603357,'That terrible glow... should that be?',15702,0,0,0,'Ysera DragonSoulVision_Say'),
(33523,-1603358,'For it to be as it must, yes.',15632,0,0,0,'Neltharion DragonSoulVision_Say2'),
(33535,-1603359,'It is a weapon like no other. It must be like no other.',15610,0,0,0,'Malygos DragonSoulVision_Say'),
(33288,-1603360,'His brood learned their lesson before too long, you shall soon learn yours!',15765,0,0,0,'YoggSaron DragonSoulVision_Say1'); 
 
/* 
* sql\updates\world\yogg_keepers.sql 
*/ 
-- Add missing keeper spawn
delete from `creature` where id in (33213,33241,33242,33244);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1000386, 33213, 603, 1, 1, 0, 0, 1939.1, -90.6097, 411.357, 1.00923, 300, 0, 0, 14433075, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1000387, 33241, 603, 1, 1, 0, 0, 2058.13, -24.3408, 421.532, 3.13766, 300, 0, 0, 14433075, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1000388, 33242, 603, 1, 1, 0, 0, 2036.31, -73.9809, 411.355, 2.26823, 300, 0, 0, 14433075, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (1000389, 33244, 603, 1, 1, 0, 0, 2036.92, 25.5315, 411.358, 3.91757, 300, 0, 0, 14433075, 0, 0, 0, 0, 0);

-- Template updates
UPDATE `creature_template` SET `npcflag`=1 WHERE `entry` IN (33213,33241,33242,33244); 
 

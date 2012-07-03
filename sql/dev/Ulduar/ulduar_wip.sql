
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

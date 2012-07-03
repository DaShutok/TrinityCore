DELETE FROM spell_script_names WHERE spell_id IN (61911, 63495);
INSERT INTO spell_script_names VALUES
(61911, 'spell_steelbreaker_static_disruption'),
(63495, 'spell_steelbreaker_static_disruption');

DELETE FROM spell_script_names WHERE spell_id = 61900;
INSERT INTO spell_script_names VALUES
(61900, 'spell_steelbreaker_electrical_charge');

DELETE FROM disables WHERE entry IN (10087,10086, 10085, 10084, 10083, 10082) AND sourcetype = 4; 
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
('10087','11','0','0','achievement_i_choose_you'),
('10086','11','0','0','achievement_i_choose_you'),
('10085','11','0','0','achievement_i_choose_you'),
('10084','11','0','0','achievement_i_choose_you'),
('10083','11','0','0','achievement_i_choose_you'),
('10082','11','0','0','achievement_i_choose_you');

DELETE FROM disables WHERE entry IN (10419,10418, 10088, 10089, 10420, 10421) AND sourcetype = 4; 
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
('10419','11','0','0','achievement_but_i_am_on_your_side'),
('10418','11','0','0','achievement_but_i_am_on_your_side'),
('10088','11','0','0','achievement_but_i_am_on_your_side'),
('10089','11','0','0','achievement_but_i_am_on_your_side'),
('10420','11','0','0','achievement_but_i_am_on_your_side'),
('10421','11','0','0','achievement_but_i_am_on_your_side');

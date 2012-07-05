DELETE FROM achievement_criteria_data WHERE criteria_id IN (10073, 10072);
INSERT INTO achievement_criteria_data VALUES
('10073','11','0','0','achievement_ignis_stokin_furnace'),
('10072','11','0','0','achievement_ignis_stokin_furnace');

DELETE FROM disables WHERE entry IN (10073,10072) AND sourcetype = 4; 
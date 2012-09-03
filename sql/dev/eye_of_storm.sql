SET NAMES `latin1`;

DELETE FROM trinity_string WHERE entry IN (688, 689);
INSERT INTO `trinity_string`(`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`) VALUES 
( '688','La Alianza tiene 1400 puntos y se encuentra cerca de la victoria.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
( '689','La Horda tiene 1400 puntos y se encuentra cerca de la victoria.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

UPDATE `gameobject_template` SET `faction` = 1375 WHERE `entry` = 184081;

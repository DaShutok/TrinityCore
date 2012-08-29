DELETE FROM outdoorpvp_template WHERE TypeID = 7;
INSERT INTO `outdoorpvp_template` (`TypeId`, `ScriptName`, `comment`) values('7','outdoorpvp_gh','Grizzy Hills');

DELETE FROM creature WHERE id IN (27748, 27708, 29253, 27730, 29251, 27758, 27759, 29252, 27760, 29250);
DELETE FROM creature WHERE guid IN (107711, 107712, 107713, 107714, 108972, 108973, 108974, 108975);

DELETE FROM trinity_string WHERE entry IN (12001, 12002, 12003, 12004);
INSERT INTO `trinity_string`(`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`) VALUES ( '12001','La Horda ha capturado Bahía Ventura',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string`(`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`) VALUES ( '12002','La Alianza ha capturado Bahía Ventura',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string`(`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`) VALUES ( '12003','La Horda a perdido Bahía Ventura',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string`(`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`) VALUES ( '12004','La Alianza ha perdido Bahía Ventura',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

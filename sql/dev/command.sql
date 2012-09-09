DELETE FROM trinity_string WHERE entry IN (20000, 20001, 20002);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('20000','|cffFFFF00[Server Notice]|r |cff00FF00%s: %s|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('20001','|cffFFFFFF %s kick %s, reason (%s)|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('20002','|cffFF0000 You will be kick in 5 seg. by: %s , reason(%s)|r',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

DELETE FROM `command` WHERE `name` IN ('kick', 'oldkick', 'gobject delete fromdb', 'gobject spawn', 'mailbox', 'npc delete fromdb', 'npc spawn', 'serverannounce');

UPDATE command SET `security` = 3 WHERE `name` IN ('npc add temp', "gobject add temp", "npc delete", "gobject delete");
UPDATE `command` SET `security`='2' WHERE `name`='announce';
UPDATE `command` SET `help` = 'Sintaxis: .npc delete [#guid]\r\nDelete the npc with guid or selected, delete temporary.' WHERE `name`='npc delete';
UPDATE `command` SET `help` = 'Sintaxis: .gobject delete #goguid\r\nDelete a gobject temporary.' WHERE `name`='gobject delete';

INSERT INTO `command` (`name`, `security`, `help`) VALUES
('gobject delete fromdb','2','Sintaxis: .gobject delete [#guid].\r\nDelete the gobject from db'),
('gobject spawn','2','Sintaxis: .gobject spawn id. Spawn a temporary gobject, duration: One day'),
('kick','2','Sintaxis: [%Player] [%Reason].\r\nKick the player with name and reason. If no reason, reason will be \"no reason\"'),
('mailbox','2','Sintaxis: .mailbox\r\nShow player mailbox'),
('npc delete fromdb','2','Sintaxis: .npc del fromdb [#guid]\r\nDelete the npc with guid or selected from db'),
('npc spawn','2','Sintaxis: .npc spawn id, Spawn a temporary npc, despawn after 1 minute after dead'),
('serverannounce','1','Sintaxis: .serverannounce\r\nShow a text from [SERVER] on the world'),
('oldkick','2','Sintaxis: .kick [$Player]\r\nKick the player give in the command');

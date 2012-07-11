-- Lake Wintergrasp Portal
SET @ENTRY := 193772;
SET @SOURCETYPE := 1;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE gameobject_template SET AIName="SmartGameObjectAI" WHERE entry=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,64,0,100,0,0,0,0,0,62,571,0,0,0,0,0,0,0,0,0,5099.98,2184.89,365.608,0.0,"Wintergrasp Portal - GossipHello - Teleport to base camp (A)"),
(@ENTRY,@SOURCETYPE,1,0,64,0,100,0,0,0,0,0,62,571,0,0,0,0,0,0,0,0,0,5026.56,3681.99,362.804,0.0,"Wintergrasp Portal - GossipHello - Teleport to base camp (H)");

INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES ( '22','1','193772','0','0','6','0','469','0','0','0','0','','Condition for wintergrasp teleporter(A)');
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES ( '22','2','193772','0','0','6','0','67','0','0','0','0','','Condition for wintergrasp teleporte(H)');

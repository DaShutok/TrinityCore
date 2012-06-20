/*
* Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
*
* This program is free software; you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by the
* Free Software Foundation; either version 2 of the License, or (at your
* option) any later version.
*
* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
* more details.
*
* You should have received a copy of the GNU General Public License along
* with this program. If not, see <http://www.gnu.org/licenses/>.
*/

/* ScriptData
SDName: Example_Creature
SD%Complete: 100
SDComment: Short custom scripting example
SDCategory: Script Examples
EndScriptData */

#include "ScriptPCH.h"
#include <cstring>
enum eEnums
{
};
#define  GOSSIP_ITEM_1          "¿Hola deseas ser transformado?"
#define  GOSSIP_ITEM_2          "Adios"
#define  GOSSIP_ITEM_3          "¿Que tal un combate?"
#define  GOSSIP_ITEM_4          "Me aburro"

class npc_testasd : public CreatureScript
{
    public:

        npc_testasd()
            : CreatureScript("npc_testasd")
        {
        }

		struct npc_testasdAI : public ScriptedAI
        {
            npc_testasdAI(Creature* creature) : ScriptedAI(creature) {}

			void ReceiveEmote(Player* player, uint32 emote)
            {
                switch (emote)
                {
                    case TEXT_EMOTE_DANCE:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_DANCE);
                        break;
                    case TEXT_EMOTE_SALUTE:
						me->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                        break;
				}
		    }

		};

	      CreatureAI* GetAI(Creature* creature) const
         {
            return new npc_testasdAI(creature);
         }

          bool OnGossipHello(Player* player, Creature* creature)
          {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
			player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
            return true;
		  }
		  
        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
        {
            player->PlayerTalkClass->ClearMenus();
            if (action == GOSSIP_ACTION_INFO_DEF+2)
            {
				creature->MonsterSay("Adios", LANG_UNIVERSAL, NULL);
				player->Say("Adios", LANG_UNIVERSAL);
                player->CLOSE_GOSSIP_MENU();
            }

			if (action == GOSSIP_ACTION_INFO_DEF+1)
			{
				player->SetDisplayId(15686);
				player->CLOSE_GOSSIP_MENU();
			}

			if (action == GOSSIP_ACTION_INFO_DEF+3)
			{
				player->Say("Estoy listo, invoca el enemigo", LANG_UNIVERSAL);
				creature->SummonCreature(RAND(1490, 20557), creature->GetPositionX()+10.0f, creature->GetPositionY(), creature->GetPositionZ(), 0.0f, TEMPSUMMON_DEAD_DESPAWN, 0);
				player->CLOSE_GOSSIP_MENU();
				//WorldDatabase.PExecute("INSERT INTO `notes` (note) VALUES ('%n Me ha activado')");
				//sLog->outString("Nota grabada");
			}		
			
			if (action == GOSSIP_ACTION_INFO_DEF+4)
			{
				creature->MonsterWhisper("Todavia no implementado", player->GetGUID());
				player->CLOSE_GOSSIP_MENU();
			} 

			return true;
        }			
};

void AddSC_npc_testasd()
{
    new npc_testasd();
}
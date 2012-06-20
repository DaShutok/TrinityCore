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
SD%Complete: 10
SDComment: Short custom scripting example
SDCategory: Script Examples
EndScriptData */

#include "ScriptPCH.h"

class monje_pandaren : public CreatureScript
{
    public:

        monje_pandaren()
            : CreatureScript("monje_pandaren")
        {
        }

		struct monje_pandarenAI : public ScriptedAI
        {
            monje_pandarenAI(Creature* creature) : ScriptedAI(creature) {}

			void ReceiveEmote(Player* player, uint32 emote)
            {
                switch (emote)
                {
                    case TEXT_EMOTE_DRINK:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_EAT);
                        break;
                    case TEXT_EMOTE_BOW:
						me->HandleEmoteCommand(EMOTE_ONESHOT_BOW);
                        break;
				}
		    }

		};

	      CreatureAI* GetAI(Creature* creature) const
         {
            return new monje_pandarenAI(creature);
         }
};

void AddSC_monje_pandaren()
{
    new monje_pandaren();
}

class tyrael_pet : public CreatureScript
{
    public:

        tyrael_pet()
            : CreatureScript("tyrael_pet")
        {
        }

		struct tyrael_petAI : public ScriptedAI
        {
            tyrael_petAI(Creature* creature) : ScriptedAI(creature) {}

			void ReceiveEmote(Player* player, uint32 emote)
            {
                switch (emote)
                {
                    case TEXT_EMOTE_DANCE:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_DANCE);
                        break;
				}
		    }

		};

	      CreatureAI* GetAI(Creature* creature) const
         {
            return new tyrael_petAI(creature);
         }
};

void AddSC_tyrael_pet()
{
    new tyrael_pet();
}
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
SDName: Boss_Viscidus
SD%Complete: 50
SDComment: Fase y babosas?
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "ScriptPCH.h"
enum Spells
{
SPELL_POISON_SHOCK      =    25993,
SPELL_POISONBOLT_VOLLEY   =  25991,
SPELL_TOXIN_CLOUD      =     25989,
};

class boss_viscidus : public CreatureScript
{
    public:
		boss_viscidus() : CreatureScript("boss_viscidus"){}
		
		CreatureAI* GetAI(Creature* pCreature) const
		{
			return new boss_viscidusAI(pCreature);
		}

		struct boss_viscidusAI : public ScriptedAI
		{
			boss_viscidusAI(Creature *c) : ScriptedAI(c) {}
				uint32 POISON_SHOCK_Timer;
		        uint32 POISONBOLT_VOLLEY_Timer;
		        uint32 TOXIN_CLOUD_Timer;
			
			void Reset()
			{
				POISON_SHOCK_Timer = (urand(12000, 10000));
				POISONBOLT_VOLLEY_Timer = (urand(7000, 5000));
				TOXIN_CLOUD_Timer = (urand(12000, 14000));

			}

			void UpdateAI(const uint32 uiDiff)
			{
				if (!me->getVictim())
				{					
				}
				
				if (!UpdateVictim())
					return;

				if(POISON_SHOCK_Timer <= uiDiff)
					{
						DoCast(me->getVictim(), SPELL_POISON_SHOCK);
						POISON_SHOCK_Timer = 30000;
					}
					else
						POISON_SHOCK_Timer -= uiDiff;

					if(POISONBOLT_VOLLEY_Timer <= uiDiff)
					{
						if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
						DoCast(pTarget, SPELL_POISONBOLT_VOLLEY);
						POISONBOLT_VOLLEY_Timer = 10000;
					}
					else
						POISONBOLT_VOLLEY_Timer -= uiDiff;

					if(TOXIN_CLOUD_Timer <= uiDiff)
					{
						DoCast(me->getVictim(), TOXIN_CLOUD_Timer);
						TOXIN_CLOUD_Timer = 12000;
					}
					else
						TOXIN_CLOUD_Timer -= uiDiff;

			DoMeleeAttackIfReady();
			}
		};
};

void AddSC_boss_viscidus()
{
    new boss_viscidus();
}
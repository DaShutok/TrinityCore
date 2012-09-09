/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
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
SDName: Baron_Silverlaine
SD%Complete: 0
SDComment: Place Holder
SDCategory: Shadowfang Keep
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "shadowfang_keep.h"

enum SiverlaineSpell
{
	SPELL_VEIL_OF_SHADOW          = 23224, 
	SPELL_CURSED_VEIL             = 93956, 
    SPELL_SUMMON_WORGEN_SPIRIT    = 93857, //cast when his hp is 70% or 30%


}; 

enum Event
{
		EVENT_VEIL_OF_SHADOW = 1,
		EVENT_CURSED_VEIL,
		EVENT_SUMMON_WORGEN_SPIRIT,
        
};

class boss_baron_siverlaine : public CreatureScript
{
public:
    boss_baron_siverlaine() : CreatureScript("boss_baron_siverlaine") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_baron_siverlaineAI (creature);
    }

    struct boss_baron_siverlaineAI : public ScriptedAI
    {
        boss_baron_siverlaineAI(Creature* creature) : ScriptedAI(creature) 
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(EVENT_VEIL_OF_SHADOW, 1000);

        }
        void JustDied(Unit* /*killer*/)
        {
            if (instance)
                if (IsHeroic())
                    instance->SetData(BOSS_BARON_SIVERLAINE, DONE);
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
					case EVENT_VEIL_OF_SHADOW
						if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
							DoCast(target, target, DUNGEON_MODE(SPELL_VEIL_OF_SHADOW , SPELL_CURSED_VEIL));
                            events.ScheduleEvent(EVENT_VEIL_OF_SHADOW, urand(15000, 25000));
                            break;
                    }
                }

                DoMeleeAttackIfReady();
        }
    private:
        EventMap events;
    };
};

void AddSC_boss_baron_silverlaine()
{
    new boss_baron_silverlaine();
}
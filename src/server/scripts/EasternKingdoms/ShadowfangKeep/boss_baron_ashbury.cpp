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
SDName: Baron_Ashbury
SD%Complete: 10 //Implement heroic mode //Finish normal
SDComment: Place Holder
SDCategory: Shadowfang Keep
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "shadowfang_keep.h"

enum AshburySpells
{
    SPELL_ASPHYXIATE              = 93423, //25 sec
    SPELL_STAY_OF_EXECUTION       = 93468, //31 sec
    SPELL_PAIN_AND_SUFFERING      = 93581, //First 5 sec, then repeat 15/25?
    SPELL_PAIN_AND_SUFFERING_H    = 93712, //Same as normal
    SPELL_MEAND_ROTTING_FLESH     = 93713, //Heal himself 10%
};

enum AshburyTexts
{
	SAY_AGGRO              = 0,
	SAY_DEATH              = 1,
	SAY_KILL               = 2,
	SAY_KILL_1             = 3,
	SAY_ASPHYXIATE         = 4,
	SAY_STAY_OF_EXECUTION  = 5,
	SAY_ARCHANGEL          = 6,
};

enum AshburyEvents
{
    EVENT_ASPHYXIATE = 1,
    EVENT_STAY_OF_EXECUTION,
    EVENT_PAIN_AND_SUFFERING,
};

class boss_baron_ashbury : public CreatureScript
{
public:
    boss_baron_ashbury() : CreatureScript("boss_baron_ashbury") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_baron_ashburyAI (creature);
    }

    struct boss_baron_ashburyAI : public ScriptedAI
    {
        boss_baron_ashburyAI(Creature* creature) : ScriptedAI(creature) 
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(EVENT_ASPHYXIATE, 25000);
            events.ScheduleEvent(EVENT_PAIN_AND_SUFFERING, 5000);
            if (IsHeroic())
                Talk(SAY_AGGRO);
        }

        void JustDied(Unit* /*killer*/)
        {
            if (instance)
                if (IsHeroic())
                {
                    instance->SetData(BOSS_BARON_ASHBURY, DONE);
                    Talk(SAY_DEATH);
                }
        }

        void KilledUnit(Unit* /*victim*/)
        {
            if (IsHeroic())
                Talk(RAND(SAY_KILL, SAY_KILL_1));
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
                        case EVENT_ASPHYXIATE:
                            DoCastToAllHostilePlayers(SPELL_ASPHYXIATE);
                            if (IsHeroic())
                                Talk(SAY_ASPHYXIATE);
                            events.ScheduleEvent(EVENT_STAY_OF_EXECUTION, 6000);
                            break;
                        case EVENT_STAY_OF_EXECUTION:
                            DoCastToAllHostilePlayers(SPELL_STAY_OF_EXECUTION);
                            if (IsHeroic())
                                Talk(SAY_STAY_OF_EXECUTION);
                            events.ScheduleEvent(EVENT_ASPHYXIATE, 28000);
                            break;
                        case EVENT_PAIN_AND_SUFFERING:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                                DoCast(target, DUNGEON_MODE(SPELL_PAIN_AND_SUFFERING, SPELL_PAIN_AND_SUFFERING_H));
                            events.ScheduleEvent(EVENT_PAIN_AND_SUFFERING, urand(15000, 25000));
                            break;
                    }
                }

                DoMeleeAttackIfReady();
        }
    private:
        EventMap events;
    };
};

void AddSC_boss_baron_ashbury()
{
    new boss_baron_ashbury();
}
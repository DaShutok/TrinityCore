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
SD%Complete: 80%
SDComment: ToDo: SpellScript for summon.
SDCategory: Shadowfang Keep
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "shadowfang_keep.h"

enum SilverlaineSpell
{
    SPELL_VEIL_OF_SHADOW          = 23224, 
    SPELL_CURSED_VEIL             = 93956, //20 seg
    SPELL_SUMMON_WORGEN_SPIRIT    = 93857, //cast when his hp is 70% or 35% in normal, 90% 60% 30% in hero
}; 

enum SilverlaineTexts
{
    SAY_AGGRO      = 0,
    SAY_DEATH      = 1,
    SAY_KILL       = 2,
    SAY_KILL_1     = 3,
};

enum SilverlaineEvents
{
    EVENT_VEIL_OF_SHADOW = 1,
    EVENT_CURSED_VEIL, 
};

class boss_baron_silverlaine : public CreatureScript
{
public:
    boss_baron_silverlaine() : CreatureScript("boss_baron_silverlaine") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_baron_silverlaineAI (creature);
    }

    struct boss_baron_silverlaineAI : public ScriptedAI
    {
        boss_baron_silverlaineAI(Creature* creature) : ScriptedAI(creature) 
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;

        bool firstsummon; //70% or 90%
        bool secondsummon; //35% or 60%
        bool thirdsummon; //30% heroic

        void Reset()
        {
            firstsummon = false;
            secondsummon = false;
            thirdsummon = false;
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(EVENT_VEIL_OF_SHADOW, 1000);
            if (IsHeroic())
            {
                events.ScheduleEvent(EVENT_CURSED_VEIL, 5000);
                Talk(SAY_AGGRO);
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            if (instance)
                if (IsHeroic())
                {
                    instance->SetData(BOSS_BARON_SILVERLAINE, DONE);
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

                if (!IsHeroic())
                {
                    if (me->GetHealth() <= 70 || !firstsummon)
                    {
                        DoCast(me, SPELL_SUMMON_WORGEN_SPIRIT);
                        firstsummon = true;
                    }
                    if (me->GetHealth() <= 35 || !secondsummon)
                    {
                        DoCast(me, SPELL_SUMMON_WORGEN_SPIRIT);
                        secondsummon = true;
                    }
                } else
                {
                    if (me->GetHealth() <= 90 || !firstsummon)
                    {
                        DoCast(me, SPELL_SUMMON_WORGEN_SPIRIT);
                        firstsummon = true;
                    }
                    if (me->GetHealth() <= 60 || !secondsummon)
                    {
                        DoCast(me, SPELL_SUMMON_WORGEN_SPIRIT);
                        secondsummon = true;
                    }
                    if (me->GetHealth() <= 30 || !thirdsummon)
                    {
                        DoCast(me, SPELL_SUMMON_WORGEN_SPIRIT);
                        thirdsummon = true;
                    }
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_VEIL_OF_SHADOW:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                DoCast(target, SPELL_VEIL_OF_SHADOW);
                            events.ScheduleEvent(EVENT_VEIL_OF_SHADOW, urand(15000, 25000));
                            break;
                        case EVENT_CURSED_VEIL:
                            DoCastToAllHostilePlayers(SPELL_CURSED_VEIL);
                            events.ScheduleEvent(EVENT_CURSED_VEIL, 20000);
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
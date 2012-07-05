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

#include "ScriptPCH.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "ulduar.h"
#include "Vehicle.h"

enum Yells
{
    SAY_AGGRO = -1603220,
    SAY_SLAY_1 = -1603221,
    SAY_SLAY_2 = -1603222,
    SAY_DEATH = -1603223,
    SAY_SUMMON = -1603224,
    SAY_SLAG_POT = -1603225,
    SAY_SCORCH_1 = -1603226,
    SAY_SCORCH_2 = -1603227,
    SAY_BERSERK = -1603228,
    EMOTE_JETS = -1603229,
};

enum Spells
{
    SPELL_FLAME_JETS_10PJ = 62680,
    SPELL_FLAME_JETS_25PJ = 63472,
    SPELL_SCORCH_10PJ = 62546,
    SPELL_SCORCH_25PJ = 63473,
    SPELL_SLAG_POT_10PJ = 62717,
    SPELL_SLAG_POT_25PJ = 63477,
    SPELL_ACTIVATE_CONSTRUCT = 62488,
    SPELL_STRENGHT = 64473,
    SPELL_GRAB = 62707,
    SPELL_BERSERK = 47008,
    SPELL_SLAG_IMBUED = 62836,
};

enum Events
{
    EVENT_NONE,
    EVENT_JET,
    EVENT_SCORCH,
    EVENT_SLAG_POT,
    EVENT_GRAB_POT,
    EVENT_CHANGE_POT,
    EVENT_END_POT,
    EVENT_CONSTRUCT,
    EVENT_BERSERK,
    ACTION_REMOVE_BUFF = 20
};

enum eCreatures
{
    NPC_IRON_CONSTRUCT = 33121,
    NPC_GROUND_SCORCH = 33221
};

enum ConstructSpells
{
    SPELL_HEAT = 65667,
    SPELL_MOLTEN = 62373,
    SPELL_BRITTLE = 62382,
    SPELL_SHATTER = 62383,
    SPELL_SCORCH_GROUND_10PJ = 62548,
    SPELL_SCORCH_GROUND_25PJ = 63476,
    SPELL_FREEZE_ANIM = 63354,
};

enum eAchievementData
{
    ACHIEVEMENT_STOKIN_THE_FURNACE_10 = 2930,
    ACHIEVEMENT_STOKIN_THE_FURNACE_25 = 2929,
    ACHIEVEMENT_CRITERIA_HOT_POCKET_10 = 10430,
    ACHIEVEMENT_CRITERIA_HOT_POCKET_25 = 10431,
    DATA_SHATTERED = 29252926,
    DATA_STOKIN_FURNACE = 29302929,
    ACHIEVEMENT_IGNIS_START_EVENT = 20951,
};

#define MAX_ENCOUNTER_TIME 4 * 60 * 1000

const Position Pos[20] =
{
    {630.366f,216.772f,360.891f,3.001970f},
    {630.594f,231.846f,360.891f,3.124140f},
    {630.435f,337.246f,360.886f,3.211410f},
    {630.493f,313.349f,360.886f,3.054330f},
    {630.444f,321.406f,360.886f,3.124140f},
    {630.366f,247.307f,360.888f,3.211410f},
    {630.698f,305.311f,360.886f,3.001970f},
    {630.500f,224.559f,360.891f,3.054330f},
    {630.668f,239.840f,360.890f,3.159050f},
    {630.384f,329.585f,360.886f,3.159050f},
    {543.220f,313.451f,360.886f,0.104720f},
    {543.356f,329.408f,360.886f,6.248280f},
    {543.076f,247.458f,360.888f,6.213370f},
    {543.117f,232.082f,360.891f,0.069813f},
    {543.161f,305.956f,360.886f,0.157080f},
    {543.277f,321.482f,360.886f,0.052360f},
    {543.316f,337.468f,360.886f,6.195920f},
    {543.280f,239.674f,360.890f,6.265730f},
    {543.265f,217.147f,360.891f,0.174533f},
    {543.256f,224.831f,360.891f,0.122173f}
};

class boss_ignis: public CreatureScript
{
public:
    boss_ignis(): CreatureScript("boss_ignis") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_ignis_AI (pCreature);
    }

    struct boss_ignis_AI: public BossAI
    {
        boss_ignis_AI(Creature *pCreature): BossAI(pCreature, BOSS_IGNIS), vehicle(me->GetVehicleKit())
        {
            ASSERT(vehicle);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, 49560, true); // Death Grip jump effect
        }

        Vehicle* vehicle;


        std::vector<Creature *> construct_list;

        bool Shattered;
        uint64 SlagPotGUID;
        uint32 EncounterTime;
        uint32 ConstructTimer;

        void Reset()
        {
            _Reset();
            if (vehicle)
                vehicle->RemoveAllPassengers();

            for (uint8 n = 0; n < 20; n++)
            {
                if (Creature* Construct = me->SummonCreature(NPC_IRON_CONSTRUCT, Pos[n], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 3000))
                    construct_list.push_back(Construct);
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            DoScriptText(SAY_AGGRO, me);
            events.ScheduleEvent(EVENT_JET, 30000);
            events.ScheduleEvent(EVENT_SCORCH, 25000);
            events.ScheduleEvent(EVENT_SLAG_POT, 35000);
            events.ScheduleEvent(EVENT_CONSTRUCT, 15000);
            events.ScheduleEvent(EVENT_END_POT, 40000);
            events.ScheduleEvent(EVENT_BERSERK, 480000);
            SlagPotGUID = 0;
            EncounterTime = 0;
            ConstructTimer = 0;
            Shattered = false;
        }

        void JustDied(Unit* /*victim*/)
        {
            _JustDied();
            DoScriptText(SAY_DEATH, me);
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            EncounterTime += diff;
            ConstructTimer += diff;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;



            while(uint32 eventId = events.ExecuteEvent())
            {
                switch(eventId)
                {
                case EVENT_JET:
                    me->MonsterTextEmote(EMOTE_JETS, 0, true);
                    DoCastAOE(RAID_MODE(SPELL_FLAME_JETS_10PJ,SPELL_FLAME_JETS_25PJ));
                    events.RescheduleEvent(EVENT_JET,urand(35000,40000));
                    break;
                case EVENT_SLAG_POT:
                    if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    {
                        if (!pTarget || pTarget->isTotem() || pTarget->isPet() || pTarget->isGuardian())
                        {
                            events.ScheduleEvent(EVENT_SLAG_POT, 500);
                            break;
                        }
                        DoScriptText(SAY_SLAG_POT, me);
                        SlagPotGUID = pTarget->GetGUID();
                        DoCast(pTarget, SPELL_GRAB);
                        events.DelayEvents(3000);
                        events.ScheduleEvent(EVENT_GRAB_POT, 500);
                    }
                    events.RescheduleEvent(EVENT_SLAG_POT,RAID_MODE(30000, 15000));
                    break;
                case EVENT_GRAB_POT:
                    if (Unit* SlagPotTarget = Unit::GetUnit(*me, SlagPotGUID))
                    {
                        SlagPotTarget->EnterVehicle(me, 0);
                        events.CancelEvent(EVENT_GRAB_POT);
                        events.ScheduleEvent(EVENT_CHANGE_POT, 1000);
                    }
                    break;
                case EVENT_CHANGE_POT:
                    if (Unit* SlagPotTarget = Unit::GetUnit(*me, SlagPotGUID))
                    {
                        SlagPotTarget->AddAura(RAID_MODE(SPELL_SLAG_POT_10PJ,SPELL_SLAG_POT_25PJ), SlagPotTarget);
                        SlagPotTarget->EnterVehicle(me, 1);
                        events.CancelEvent(EVENT_CHANGE_POT);
                        events.ScheduleEvent(EVENT_END_POT, 10000);
                    }
                    break;
                case EVENT_END_POT:
                    if(Unit*SlagPotTarget=Unit::GetUnit(*me,SlagPotGUID))
                    {
                        if(SlagPotTarget->isAlive())
                        {
                            uint32 achiev_id=RAID_MODE(ACHIEVEMENT_CRITERIA_HOT_POCKET_10,ACHIEVEMENT_CRITERIA_HOT_POCKET_25);
                            SlagPotTarget->ExitVehicle();
                            if(Player* player_SlagPotTarget = SlagPotTarget->ToPlayer())
                            {
                                if(AchievementEntry const* pAE = sAchievementStore.LookupEntry(achiev_id))
                                    player_SlagPotTarget->CompletedAchievement(pAE);
                            }
                        }
                        SlagPotTarget=NULL;
                        SlagPotGUID=NULL;
                        events.CancelEvent(EVENT_END_POT);
                    }
                    break;
                case EVENT_SCORCH:
                    DoScriptText(RAND(SAY_SCORCH_1, SAY_SCORCH_2), me);
                    if (Unit *pTarget = me->getVictim())
                        me->SummonCreature(NPC_GROUND_SCORCH, pTarget->GetPositionX(), pTarget->GetPositionY(), pTarget->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 45000);
                    DoCast(RAID_MODE(SPELL_SCORCH_10PJ,SPELL_SCORCH_25PJ));
                    events.RescheduleEvent(EVENT_SCORCH,25000);
                    break;
                case EVENT_CONSTRUCT:
                    if (!construct_list.empty())
                    {
                        std::vector<Creature*>::iterator itr = (construct_list.begin()+rand()%construct_list.size());
                        Creature* pTarget = *itr;
                        if (pTarget && pTarget->IsInWorld() && pTarget->isAlive())
                        {
                            DoScriptText(SAY_SUMMON, me);
                            DoCast(me, SPELL_STRENGHT, true);
                            DoCast(SPELL_ACTIVATE_CONSTRUCT);
                            pTarget->setFaction(16);
                            pTarget->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED | UNIT_FLAG_STUNNED | UNIT_FLAG_DISABLE_MOVE);
                            construct_list.erase(itr);
                        }
                    }
                    events.ScheduleEvent(EVENT_CONSTRUCT, RAID_MODE(40000, 30000));
                    break;
                case EVENT_BERSERK:
                    DoCast(me, SPELL_BERSERK, true);
                    DoScriptText(SAY_BERSERK, me);
                    break;
                }
            }
            DoMeleeAttackIfReady();
        }

        uint32 GetData(uint32 type)
        {
            switch(type)
            {
            case DATA_SHATTERED:
                return Shattered ? 1 : 0;
            case DATA_STOKIN_FURNACE:
                return EncounterTime <= MAX_ENCOUNTER_TIME ? 1 : 0;
            default: return 0;
            }
        }

        void KilledUnit(Unit* /*victim*/)
        {
            if (!(rand()%5))
                DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2), me);
        }


        void DoAction(const int32 action)
        {
            switch(action)
            {
            case ACTION_REMOVE_BUFF:
                me->RemoveAuraFromStack(SPELL_STRENGHT);
                // Shattered Achievement
                if (ConstructTimer >= 5000)
                    ConstructTimer = 0;
                else
                    Shattered = true;
                break;
            }
        }
    };
};

class npc_iron_construct: public CreatureScript
{
public:
    npc_iron_construct(): CreatureScript("npc_iron_construct") { }

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_iron_constructAI(creature);
    }

    struct npc_iron_constructAI: public ScriptedAI
    {
        npc_iron_constructAI(Creature* pCreature): ScriptedAI(pCreature)
        {
            instance = pCreature->GetInstanceScript();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED | UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->SetReactState(REACT_PASSIVE);
            me->AddAura(SPELL_FREEZE_ANIM, me);
            me->setFaction(35);
        }

        InstanceScript* instance;
        bool Brittled;

        void Reset()
        {
            Brittled = false;
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage)
        {
            if (me->HasAura(SPELL_BRITTLE) && damage >= 5000)
            {
                DoCast(SPELL_SHATTER);
                if (Creature *pIgnis = me->GetCreature(*me, instance->GetData64(BOSS_IGNIS)))
                    if (pIgnis->AI())
                        pIgnis->AI()->DoAction(ACTION_REMOVE_BUFF);

                me->DespawnOrUnsummon(1000);
            }
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_ACTIVATE_CONSTRUCT && me->HasReactState(REACT_PASSIVE))
            {
                me->SetReactState(REACT_AGGRESSIVE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED | UNIT_FLAG_DISABLE_MOVE);
                me->RemoveAurasDueToSpell(SPELL_FREEZE_ANIM);
                me->AI()->AttackStart(caster->getVictim());
                me->AI()->DoZoneInCombat();
            }
        }

        void UpdateAI(const uint32 /*uiDiff*/)
        {
            if (me->HasAura(SPELL_MOLTEN) && me->HasAura(SPELL_HEAT))
                me->RemoveAura(SPELL_HEAT);

            if (Aura * aur = me->GetAura(SPELL_HEAT))
            {
                if (aur->GetStackAmount() >= 10)
                {
                    me->RemoveAura(SPELL_HEAT);
                    DoCast(me, SPELL_MOLTEN, true);
                    Brittled = false;
                }
            }
            // Water pools
            if (me->IsInWater() && !Brittled && me->HasAura(SPELL_MOLTEN))
            {
                me->AddAura(SPELL_BRITTLE, me);
                me->RemoveAura(SPELL_MOLTEN);
                Brittled = true;
            }
            DoMeleeAttackIfReady();
        }
    };
};

class npc_scorch_ground: public CreatureScript
{
public:
    npc_scorch_ground(): CreatureScript("npc_scorch_ground") { }

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_scorch_groundAI(creature);
    }

    struct npc_scorch_groundAI: public Scripted_NoMovementAI
    {
        npc_scorch_groundAI(Creature* pCreature): Scripted_NoMovementAI(pCreature)
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE |UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
            pCreature->SetDisplayId(16925); //model 2 in db cannot overwrite wdb fields
        }

        void Reset()
        {
            DoCast(me, RAID_MODE(SPELL_SCORCH_GROUND_10PJ,SPELL_SCORCH_GROUND_25PJ));
        }
    };
};

class spell_ignis_slag_pot: public SpellScriptLoader
{
public:
    spell_ignis_slag_pot(): SpellScriptLoader("spell_ignis_slag_pot") { }

    class spell_ignis_slag_pot_AuraScript: public AuraScript
    {
        PrepareAuraScript(spell_ignis_slag_pot_AuraScript);

        void HandleEffectPeriodic(AuraEffect const * aurEff)
        {
            Unit * target = GetTarget();

            uint32 SpellID = 0;

            if (target->GetInstanceScript() && target->GetInstanceScript()->instance->GetDifficulty() == RAID_DIFFICULTY_10MAN_NORMAL)
                SpellID = 65722;
            else
                SpellID = 65723;

            target->CastSpell(target, SpellID, true);

            if (target->isAlive() && !GetDuration())
                target->CastSpell(target, SPELL_SLAG_IMBUED, true);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_ignis_slag_pot_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_ignis_slag_pot_AuraScript();
    }
};


class achievement_ignis_shattered: public AchievementCriteriaScript
{
public:
    achievement_ignis_shattered(): AchievementCriteriaScript("achievement_ignis_shattered") { }

    bool OnCheck(Player* /*source*/, Unit* target)
    {
        if (target && target->IsAIEnabled)
            return target->GetAI()->GetData(DATA_SHATTERED);

        return false;
    }
};

class achievement_ignis_stokin_furnace: public AchievementCriteriaScript
{
public:
    achievement_ignis_stokin_furnace(): AchievementCriteriaScript("achievement_ignis_stokin_furnace") { }

    bool OnCheck(Player* /*source*/, Unit* target)
    {
        if (target && target->IsAIEnabled)
            return target->GetAI()->GetData(DATA_STOKIN_FURNACE);

        return false;
    }
};

void AddSC_boss_ignis()
{
    new boss_ignis();
    new npc_iron_construct();
    new npc_scorch_ground();
    new spell_ignis_slag_pot();
    new achievement_ignis_shattered();
    new achievement_ignis_stokin_furnace();
}
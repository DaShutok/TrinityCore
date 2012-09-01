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
SDName: Shadowfang_Keep
SD%Complete: 0
SDComment: 
SDCategory: Shadowfang Keep
EndScriptData */

/* ContentData
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "ScriptedEscortAI.h"
#include "shadowfang_keep.h"

class spell_shadowfang_keep_haunting_spirits : public SpellScriptLoader
{
    public:
        spell_shadowfang_keep_haunting_spirits() : SpellScriptLoader("spell_shadowfang_keep_haunting_spirits") { }

        class spell_shadowfang_keep_haunting_spirits_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_shadowfang_keep_haunting_spirits_AuraScript);

            void CalcPeriodic(AuraEffect const* /*aurEff*/, bool& isPeriodic, int32& amplitude)
            {
                isPeriodic = true;
                amplitude = (irand(0, 60) + 30) * IN_MILLISECONDS;
            }

            void HandleDummyTick(AuraEffect const* aurEff)
            {
                GetTarget()->CastSpell((Unit*)NULL, aurEff->GetAmount(), true);
            }

            void HandleUpdatePeriodic(AuraEffect* aurEff)
            {
                aurEff->CalculatePeriodic(GetCaster());
            }

            void Register()
            {
                DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_shadowfang_keep_haunting_spirits_AuraScript::CalcPeriodic, EFFECT_0, SPELL_AURA_DUMMY);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_shadowfang_keep_haunting_spirits_AuraScript::HandleDummyTick, EFFECT_0, SPELL_AURA_DUMMY);
                OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_shadowfang_keep_haunting_spirits_AuraScript::HandleUpdatePeriodic, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_shadowfang_keep_haunting_spirits_AuraScript();
        }
};

void AddSC_shadowfang_keep()
{
    new spell_shadowfang_keep_haunting_spirits();
}

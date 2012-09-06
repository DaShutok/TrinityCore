/*
 * Copyright (C) 2012 CVMagic <http://www.trinitycore.org/f/topic/6551-vas-autobalance/>
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * Copyright (C) 1985-2010 {VAS} KalCorp  <http://vasserver.dyndns.org/>
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

/*
 * Script Name: AutoBalance
 * Original Authors: KalCorp and Vaughner
 * Maintainer(s): CVMagic
 * Original Script Name: VAS.AutoBalance
 * Description: This script is intended to scale based on number of players, instance mobs & world bosses' health, mana, and damage.
 */


#include "ScriptPCH.h"
#include "Configuration/Config.h"
#include "MapManager.h"
#include "Map.h"
#include <unordered_map>
#include <vector>

#define BOOL_TO_STRING(b) ((b)? "true":"false")
#define VAS_SCRIPT_HOOK_VERSION_NEEDED 1.01f

enum VAS_ConfigFloatValues
{
    CONFIG_XPLAYER = 0,
    MIN_D_MOD,
    MIN_HP_MOD,
    VAS_DAMAGE_MODIFIER,
    VAS_GROUP_MODIFIER,
    VAS_VERSION
};

enum VAS_ConfigIntegerValues
{
    AUTOINSTANCE = 0,
    CREATURE_UPDATE_TIMER,
    PLAYER_CHANGE_NOTIFY,
    VAS_DEBUG,
    VAS_DEBUG_BY_ID,
    VAS_SUB_VERSION
};

class AutoBalanceConfig
{
private:
    static AutoBalanceConfig* InstancePointer;
    std::unordered_map<int, int> _forcedCreatureIds;  // The unordered map values correspond with the VAS.AutoBalance.XX.Name entries in the configuration file.
    std::vector<int> _integerValues;
    std::vector<float> _floatValues;
    unsigned int _numOfIntKeys;
    unsigned int _numOfFloatKeys;

    int GetValidDebugLevel()
    {
        int debugLevel = sWorld->getIntConfig(VAS_VasDebug);

        if ((debugLevel < 0) || (debugLevel > 3))
        {
            return 1;
        }
        return debugLevel;
    }

    int GetValidCreatureTimer()
    {
        if (sWorld->getFloatConfig(VAS_Creature_Update_Timer) <= 4)
        {
            return 5;
        }
        return sWorld->getFloatConfig(VAS_Creature_Update_Timer);
    }

    void LoadForcedCreatureIdsFromString(std::string creatureIds, int forcedPlayerCount) // Used for reading the string from the configuration file to for those creatures who need to be scaled for XX number of players.
    {
        std::string delimitedValue;
        std::stringstream creatureIdsStream;

        creatureIdsStream.str(creatureIds);
        while (std::getline(creatureIdsStream, delimitedValue, ',')) // Process each Creature ID in the string, delimited by the comma - ","
        {
            int creatureId = atoi(delimitedValue.c_str());
            if (creatureId >= 0)
            {
                SetForcedCreatureId(creatureId, forcedPlayerCount);
            }
        }
    }

    void SetForcedCreatureId(int creatureId, int forcedPlayerCount)
    {
        _forcedCreatureIds[creatureId] = forcedPlayerCount;
    }

    // forcing the Configuration object to be a singleton by making the constructor private
    AutoBalanceConfig()
    {
        this->_numOfIntKeys = this->_numOfFloatKeys = 0;
        this->_forcedCreatureIds.clear();

        SetFloatValue(sWorld->getFloatConfig(VAS_Config_xPlayer));
        SetFloatValue(sWorld->getFloatConfig(VAS_Min_D_Mod));
        SetFloatValue(sWorld->getFloatConfig(VAS_Min_HP_Mod));
        SetFloatValue(sWorld->getFloatConfig(VAS_VAS_Damage_Modifer));
        SetFloatValue(sWorld->getFloatConfig(VAS_VAS_Group_Modifer));
        SetFloatValue(1.04f);

        SetIntValue(sWorld->getIntConfig(VAS_AutoInstance));
        SetIntValue(GetValidCreatureTimer());
        SetIntValue(sWorld->getIntConfig(VAS_PlayerChangeNotify));
        SetIntValue(GetValidDebugLevel());
        SetIntValue(sWorld->getIntConfig(VAS_DebugByID));
        SetIntValue(10);

        LoadForcedCreatureIdsFromString(sWorld->GetVAS40(), 40);
        LoadForcedCreatureIdsFromString(sWorld->GetVAS25(), 25);
        LoadForcedCreatureIdsFromString(sWorld->GetVAS10(), 10);
        LoadForcedCreatureIdsFromString(sWorld->GetVAS5(), 5);
        LoadForcedCreatureIdsFromString(sWorld->GetVAS2(), 2);
    };

    AutoBalanceConfig(AutoBalanceConfig const&);
    void operator=(AutoBalanceConfig const&);

public:
    static AutoBalanceConfig* Instanace()
    {
        if(!InstancePointer)
        {
            InstancePointer = new AutoBalanceConfig;
        }
        return InstancePointer;
    }

    int GetIntValue(unsigned int key)
    {
        return (key <= _numOfIntKeys) ? _integerValues.at(key) : 0;
    }

    float GetFloatValue(unsigned int key)
    {
        return (key <= _numOfFloatKeys) ? _floatValues.at(key) : 0.0f;
    }

    unsigned int SetIntValue(int intValue)
    {
        _integerValues.push_back(intValue);
        _numOfIntKeys++;
        return (_integerValues.size() -1);
    }

    unsigned int SetIntValue(unsigned int key, int intValue)
    {
        if(key >= _numOfIntKeys)
        {
            return 0;
        }
        _integerValues[key] = intValue;
        return key;
    }

    unsigned int SetFloatValue(float floatValue)
    {
        _floatValues.push_back(floatValue);
        _numOfFloatKeys++;
        return (_floatValues.size() - 1);
    }

    unsigned int SetFloatValue(unsigned int key, float floatValue)
    {
        if(key >= _numOfFloatKeys){
            return 0;
        }
        _floatValues[key] = floatValue;
        return key;
    }

    void ValidateScriptHookVersion() //May be Deprecated in the future as this would be bundled as a patch.
    {
        if (sScriptMgr->VAS_Script_Hooks() < VAS_SCRIPT_HOOK_VERSION_NEEDED)
        {
            sLog->outError("  VAS_Script_Hooks v%4.2f Found", sScriptMgr->VAS_Script_Hooks());
            sLog->outError("  VAS AutoBalance needs %4.2f+ to run correctly!", VAS_SCRIPT_HOOK_VERSION_NEEDED);
            SetFloatValue(CONFIG_XPLAYER, 0.0f);
        }
    }

    int GetForcedCreatureId(int creatureId){
        if(_forcedCreatureIds.find(creatureId) == _forcedCreatureIds.end()) // Don't want the _forcedCreatureIds unordered map to blowup to a massive empty array
        {
            return 0;
        }
        return _forcedCreatureIds[creatureId];
    }
};

struct AutoBalanceCreatureInfo
{
    uint32 TimeToNextUpdate;
    float DamageMultiplier;
};

static std::map<uint32, AutoBalanceCreatureInfo> CreatureInfo; // A hook should be added to remove the mapped entry when the creature is dead or this should be added into the creature object
AutoBalanceConfig* AutoBalanceConfig::InstancePointer = NULL;

class VAS_AutoBalance_WorldScript : public WorldScript
{
    public:
        VAS_AutoBalance_WorldScript()
            : WorldScript("VAS_AutoBalance_WorldScript")
        {
        }

    void OnConfigLoad(bool /*reload*/)
    {
    }

    void OnStartup()
    {
    }

    void SetInitialWorldSettings()
    {

        sLog->outStaticDebug("----------------------------------------------------");
        sLog->outStaticDebug("  Powered by {VAS} AutoBalance v%4.2f.%u ", AutoBalanceConfig::Instanace()->GetFloatValue(VAS_VERSION), AutoBalanceConfig::Instanace()->GetIntValue(VAS_SUB_VERSION));
        sLog->outStaticDebug("----------------------------------------------------");
        AutoBalanceConfig::Instanace()->ValidateScriptHookVersion();
        sLog->outStaticDebug("  xPlayer = %4.1f ", AutoBalanceConfig::Instanace()->GetFloatValue(CONFIG_XPLAYER));
        sLog->outStaticDebug("  AutoInstance = %u ", AutoBalanceConfig::Instanace()->GetIntValue(AUTOINSTANCE));
        sLog->outStaticDebug("  PlayerChangeNotify = %u ", AutoBalanceConfig::Instanace()->GetIntValue(PLAYER_CHANGE_NOTIFY));
        sLog->outStaticDebug("  Min.D.Mod = %4.2f ", AutoBalanceConfig::Instanace()->GetFloatValue(MIN_D_MOD));
        sLog->outStaticDebug("  Min.HP.Mod = %4.2f ", AutoBalanceConfig::Instanace()->GetFloatValue(MIN_HP_MOD));
        sLog->outStaticDebug("  VAS.Group.Modifer = %4.2f ", AutoBalanceConfig::Instanace()->GetFloatValue(VAS_GROUP_MODIFIER));
        sLog->outStaticDebug("  VAS.Damage.Modifer = %4.2f ", AutoBalanceConfig::Instanace()->GetFloatValue(VAS_DAMAGE_MODIFIER));
        sLog->outStaticDebug("  VasDebug   =  %u ", AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG));
        sLog->outStaticDebug("  DebugByID   =  %u", AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG_BY_ID));
        sLog->outStaticDebug("  Creature_Update_Timer   =  %u", AutoBalanceConfig::Instanace()->GetIntValue(CREATURE_UPDATE_TIMER));
        sLog->outStaticDebug("----------------------------------------------------\n");
    }

};

class VAS_AutoBalance_PlayerScript : public PlayerScript
{
    public:
        VAS_AutoBalance_PlayerScript()
            : PlayerScript("VAS_AutoBalance_PlayerScript")
        {
        }

    void OnLogin(Player *Player)
    {

        if (AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG) >= 3)
            sLog->outStaticDebug("### VAS_AutoBalance_PlayerScript - OnLogin Player=%s", Player->GetName());
    }
};

class VAS_AutoBalance_UnitScript : public UnitScript
{
    public:
        VAS_AutoBalance_UnitScript()
            : UnitScript("VAS_AutoBalance_UnitScript")
        {
        }

    uint32 DealDamage(Unit* AttackerUnit, Unit *playerVictim,uint32 damage, DamageEffectType damagetype)
    {

        if (AttackerUnit->GetMap()->IsDungeon() && playerVictim->GetMap()->IsDungeon())
            if (AttackerUnit->GetTypeId() != TYPEID_PLAYER)
            {
                if (AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG) >= 3)
                    sLog->outStaticDebug("### VAS_AutoBalance_UnitScript - VAS_Unit_DealDamage Attacker=%s Victim=%s Start Damage=%u",AttackerUnit->GetName(),playerVictim->GetName(),damage);
                damage = VAS_Modifer_DealDamage(AttackerUnit,damage);
                if (AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG) >= 3)
                    sLog->outStaticDebug("### VAS_AutoBalance_UnitScript - VAS_Unit_DealDamage Attacker=%s Victim=%s End Damage=%u",AttackerUnit->GetName(),playerVictim->GetName(),damage);
            }
            return damage;
    }

    void CalculateSpellDamageTaken(SpellNonMeleeDamage *damageInfo, int32 damage, SpellEntry const *spellInfo, WeaponAttackType attackType, bool crit)
    {

        if ((damageInfo->attacker->GetMap()->IsDungeon() && damageInfo->target->GetMap()->IsDungeon()) || ( damageInfo->attacker->GetMap()->IsBattleground() && damageInfo->target->GetMap()->IsBattleground()))
            if (damageInfo->attacker->GetTypeId() != TYPEID_PLAYER)
            {
                if (AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG) >= 3)
                    sLog->outStaticDebug("### VAS_AutoBalance_UnitScript - CalculateSpellDamageTaken Attacker=%s Victim=%s Start Damage=%u",damageInfo->attacker->GetName(),damageInfo->target->GetName(),damageInfo->damage);

                if (damageInfo->attacker->isHunterPet() || damageInfo->attacker->isPet() || damageInfo->attacker->isSummon() || damageInfo->attacker->IsControlledByPlayer())
                    return;

                float damageMultiplier = CreatureInfo[damageInfo->attacker->GetGUID()].DamageMultiplier;

                damageInfo->damage *= damageMultiplier;

                if (AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG) >= 3)
                    sLog->outStaticDebug("### VAS_AutoBalance_UnitScript - CalculateSpellDamageTaken Attacker=%s Victim=%s End Damage=%u",damageInfo->attacker->GetName(),damageInfo->target->GetName(),damageInfo->damage);
            }
            return;
    }

    void CalculateMeleeDamage(Unit *playerVictim, uint32 damage, CalcDamageInfo *damageInfo, WeaponAttackType attackType)
    {

        // Make sure the Attacker and the Victim are in the same location, in addition that the attacker is not player.
        if (((damageInfo->attacker->GetMap()->IsDungeon() && damageInfo->target->GetMap()->IsDungeon()) || (damageInfo->attacker->GetMap()->IsBattleground() && damageInfo->target->GetMap()->IsBattleground())) && (damageInfo->attacker->GetTypeId() != TYPEID_PLAYER))
            if (!(damageInfo->attacker->isHunterPet() || damageInfo->attacker->isPet() || damageInfo->attacker->isSummon() || damageInfo->attacker->IsControlledByPlayer())) // Make sure that the attacker is not a Pet of some sort
            {
                if (AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG) >= 3)
                    sLog->outStaticDebug("### VAS_AutoBalance_UnitScript - CalculateMeleeDamage Attacker=%s Victim=%s Start Damage=%u",damageInfo->attacker->GetName(),damageInfo->target->GetName(),damageInfo->damage);

                damageInfo->damage *= CreatureInfo[damageInfo->attacker->GetGUID()].DamageMultiplier;

                if (AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG) >= 3)
                    sLog->outStaticDebug("### VAS_AutoBalance_UnitScript - CalculateMeleeDamage Attacker=%s Victim=%s End Damage=%u",damageInfo->attacker->GetName(),damageInfo->target->GetName(),damageInfo->damage);
            }
            return;
    }

    uint32 VAS_Modifer_DealDamage(Unit* AttackerUnit,uint32 damage)
    {

    if (AttackerUnit->isHunterPet() || AttackerUnit->isPet() || AttackerUnit->isSummon() || AttackerUnit->IsControlledByPlayer())
        return damage;

    float damageMultiplier = CreatureInfo[AttackerUnit->GetGUID()].DamageMultiplier;

    return damage * damageMultiplier;

    }

};


class VAS_AutoBalance_AllMapScript : public AllMapScript
{
    public:
        VAS_AutoBalance_AllMapScript()
            : AllMapScript("VAS_AutoBalance_AllMapScript")
        {
        }

    void OnPlayerEnterAll(Map* map, Player* player)
    {
        if (AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG) >= 2)
        {
            sLog->outStaticDebug("----------------------------------------------------");
            sLog->outStaticDebug("## VAS_AutoBalance_AllMapScript - OnPlayerEnterAll");
            sLog->outStaticDebug("## For InsatanceID %u",map->GetInstanceId());
            sLog->outStaticDebug("## IsDungeon= %u",map->GetEntry()->IsDungeon());
            sLog->outStaticDebug("## For Map %u",player->GetMapId());
            sLog->outStaticDebug("## PlayersInMap %u",map->GetPlayersCountExceptGMs());
            sLog->outStaticDebug("## pDifficulty %u",uint32(player->GetDifficulty(player->GetMap()->IsHeroic())));
            sLog->outStaticDebug("## pGetDungeonDifficulty %u",uint32(player->GetDungeonDifficulty()));
            sLog->outStaticDebug("## pGetRaidDifficulty %u",uint32(player->GetRaidDifficulty()));
            sLog->outStaticDebug("## maxPlayers %u",((InstanceMap*)sMapMgr->FindMap(player->GetMapId(), player->GetInstanceId()))->GetMaxPlayers());
            sLog->outStaticDebug("## IsHeroic=%s IsRaid=%s IsRegularDifficulty=%s IsRaidOrHeroicDungeon=%s IsNonRaidDungeon=%s",BOOL_TO_STRING(player->GetMap()->IsHeroic()),BOOL_TO_STRING(player->GetMap()->IsRaid()),BOOL_TO_STRING(player->GetMap()->IsRegularDifficulty()),BOOL_TO_STRING(player->GetMap()->IsRaidOrHeroicDungeon()),BOOL_TO_STRING(player->GetMap()->IsNonRaidDungeon()));
            sLog->outStaticDebug("----------------------------------------------------\n");
        }

        if (AutoBalanceConfig::Instanace()->GetIntValue(PLAYER_CHANGE_NOTIFY) >= 1)
        {
            if ((map->GetEntry()->IsDungeon()) && !player->isGameMaster() )
            {
                Map::PlayerList const &playerList = map->GetPlayers();
                if (!playerList.isEmpty())
                {
                    for (Map::PlayerList::const_iterator playerIteration = playerList.begin(); playerIteration != playerList.end(); ++playerIteration)
                    {
                        if (Player* playerHandle = playerIteration->getSource())
                        {
                            ChatHandler chatHandle = ChatHandler(playerHandle);
                            chatHandle.PSendSysMessage("|cffFF0000 [AutoBalance]|r|cffFF8000 %s entered the Instance %s. Auto setting player count to %u |r",player->GetName(),map->GetMapName(),map->GetPlayersCountExceptGMs());
                        }
                    }
                }
            }
        }
    }

    void OnPlayerLeaveAll(Map* map, Player* player)
    {

        //if (AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG) >= 3)
            //slog->outString("#### VAS_AutoBalance_AllMapScript - OnPlayerLeaveAll map=%s player=%s", map->GetMapName(),player->GetName());

        int instancePlayerCount = map->GetPlayersCountExceptGMs() - 1;

        if (instancePlayerCount >=1)
        {
            if (AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG) >= 2)
            {
                sLog->outStaticDebug("----------------------------------------------------");
                sLog->outStaticDebug("## VAS_AutoBalance_AllMapScript - OnPlayerLeaveAll");
                sLog->outStaticDebug("## For InsatanceID %u",map->GetInstanceId());
                sLog->outStaticDebug("## IsDungeon= %u",map->GetEntry()->IsDungeon());
                sLog->outStaticDebug("## For Map %u",player->GetMapId());
                sLog->outStaticDebug("## PlayersInMap %u",instancePlayerCount);
                sLog->outStaticDebug("----------------------------------------------------\n");
            }

            if (AutoBalanceConfig::Instanace()->GetIntValue(PLAYER_CHANGE_NOTIFY) >= 1)
            {
                if ((map->GetEntry()->IsDungeon()) && !player->isGameMaster())
                {
                    Map::PlayerList const &playerList = map->GetPlayers();
                    if (!playerList.isEmpty())
                    {
                        for (Map::PlayerList::const_iterator playerIteration = playerList.begin(); playerIteration != playerList.end(); ++playerIteration)
                        {
                            if (Player* playerHandle = playerIteration->getSource())
                            {
                                ChatHandler chatHandle = ChatHandler(playerHandle);
                                chatHandle.PSendSysMessage("|cffFF0000 [VAS-AutoBalance]|r|cffFF8000 %s left the Instance %s. Auto setting player count to %u |r",player->GetName(),map->GetMapName(),instancePlayerCount);
                            }
                        }
                    }
                }
            }
        }
    }
};

class VAS_AutoBalance_WorldMapScript : public WorldMapScript
{
    public:
        VAS_AutoBalance_WorldMapScript()
            : WorldMapScript("VAS_AutoBalance_WorldMapScript",0)
        {
        }

    void OnPlayerEnter(Map* map, Player* player)
    {

        if (AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG) >= 3)
            sLog->outStaticDebug("### VAS_AutoBalance_WorldMapScript - OnPlayerEnter Map=%s player=%s",map->GetMapName(),player->GetName());
    }

    void OnPlayerLeave(Map* map, Player* player)
    {

        if (AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG) >= 3)
            sLog->outStaticDebug("### VAS_AutoBalance_WorldMapScript - OnPlayerLeave Map=%s player=%s",map->GetMapName(),player->GetName());
    }
};


class VAS_AutoBalance_AllCreatureScript : public AllCreatureScript
{
    public:
        VAS_AutoBalance_AllCreatureScript()
            : AllCreatureScript("VAS_AutoBalance_AllCreatureScript")
        {
        }


    void Creature_SelectLevel(const CreatureTemplate *creatureTemplate, Creature* creature)
    {

        if (creature->GetMap()->IsDungeon())
        {
            ModifyCreatureAttributes(creature);
            //if (AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG) >= 3)
                //slog->outString("### VAS_AutoBalance_VASScript - VAS_Creature_SelectLevel InstanceID=%u   Creature=%s",creature->GetInstanceId(),creatureTemplate->Name.c_str());
        }
    }

    void OnAllCreatureUpdate(Creature* creature, uint32 diff)
    {

        if (CreatureInfo[creature->GetGUID()].TimeToNextUpdate <= diff)
            {
                CreatureInfo[creature->GetGUID()].TimeToNextUpdate = 0;
                if (creature->GetMap()->IsDungeon() || creature->GetMap()->IsBattleground())
                    ModifyCreatureAttributes(creature);
                CreatureInfo[creature->GetGUID()].TimeToNextUpdate = AutoBalanceConfig::Instanace()->GetIntValue(CREATURE_UPDATE_TIMER) * IN_MILLISECONDS;
             }
            else
                CreatureInfo[creature->GetGUID()].TimeToNextUpdate -= diff;
    }

    void GetPlayerClassList(Creature* creature, std::unordered_map<uint8,int>& playerClassList)
    {
        playerClassList.clear();
        Map::PlayerList const &playerList = creature->GetMap()->GetPlayers();
        if(!playerList.isEmpty())
        {
            for (Map::PlayerList::const_iterator playerIteration = playerList.begin(); playerIteration != playerList.end(); ++playerIteration)
            {
                if (Player* player = playerIteration->getSource())
                {
                    if(playerClassList.find(player->getClass()) == playerClassList.end())
                    {
                        if(!player->isGameMaster())
                        {
                            playerClassList[player->getClass()] = 1;
                        }
                    }
                    else
                    {
                        if(!player->isGameMaster())
                        {
                            playerClassList[player->getClass()] += 1;
                        }
                    }
                }
            }
        }
    }

    void ModifyCreatureAttributes(Creature* creature)
    {
        if(creature->isHunterPet() || creature->isPet() || creature->isSummon() || creature->IsControlledByPlayer() || AutoBalanceConfig::Instanace()->GetIntValue(AUTOINSTANCE) < 1 || creature->GetMap()->GetPlayersCountExceptGMs() <= 0)
        {
            return;
        }

        CreatureTemplate const *creatureTemplate = creature->GetCreatureTemplate();
        CreatureBaseStats const* creatureStats = sObjectMgr->GetCreatureBaseStats(creature->getLevel(), creatureTemplate->unit_class);

        float damageMultiplier = 1.0f;
        float healthMultiplier = 1.0f;

        uint32 baseHealth = creatureStats->GenerateHealth(creatureTemplate);
        uint32 baseMana = creatureStats->GenerateMana(creatureTemplate);
        uint32 instancePlayerCount = creature->GetMap()->GetPlayersCountExceptGMs();
        uint32 maxNumberOfPlayers = ((InstanceMap*)sMapMgr->FindMap(creature->GetMapId(), creature->GetInstanceId()))->GetMaxPlayers();
        uint32 scaledHealth = 0;
        uint32 scaledMana = 0;

        std::unordered_map<uint8, int> playerClassList;

        //   VAS SOLO  - By MobID
        if(AutoBalanceConfig::Instanace()->GetForcedCreatureId(creatureTemplate->Entry) > 0)
        {
            maxNumberOfPlayers = AutoBalanceConfig::Instanace()->GetForcedCreatureId(creatureTemplate->Entry); // Force maxNumberOfPlayers to be changed to match the Configuration entry.
        }

        // (tanh((X-2.2)/1.5) +1 )/2    // 5 Man formula X = Number of Players
        // (tanh((X-5)/2) +1 )/2        // 10 Man Formula X = Number of Players
        // (tanh((X-16.5)/6.5) +1 )/2   // 25 Man Formula X = Number of players
        //
        // Note: The 2.2, 5, and 16.5 are the number of players required to get 50% health.
        //       It's not required this be a whole number, you'd adjust this to raise or lower
        //       the hp modifier for per additional player in a non-whole group. These
        //       values will eventually be part of the configuration file once I finalize the mod.
        //
        //       The 1.5, 2, and 6.5 modify the rate of percentage increase between
        //       number of players. Generally the closer to the value of 1 you have this
        //       the less gradual the rate will be. For example in a 5 man it would take 3
        //       total players to face a mob at full health.
        //
        //       The +1 and /2 values raise the TanH function to a positive range and make
        //       sure the modifier never goes above the value or 1.0 or below 0.
        //
        //       Lastly this formula has one side effect on full groups Bosses and mobs will
        //       never have full health, this can be tested against by making sure the number
        //       of players match the maxNumberOfPlayers variable.

        switch (maxNumberOfPlayers)
        {
        case 40:                                                                     // Using 25 Man formula, 40 man bosses don't have much have health in the first
            healthMultiplier = (tanh((instancePlayerCount - 16.5f) / 1.5f) + 1) / 2; // place but since they are targeted for level 60 characters it should be a low
            break;                                                                   // enough number. This may change should this be wrong.
        case 25:
            healthMultiplier = (tanh((instancePlayerCount - 16.5f) / 1.5f) + 1) / 2;
            break;
        case 10:
            healthMultiplier = (tanh((instancePlayerCount - 5) / 1.5f) + 1) / 2;
            break;
        case 2:
            healthMultiplier = instancePlayerCount / maxNumberOfPlayers;             // Two Man Creatures are too easy if handled by the 5 man formula, this would only
            break;                                                                   // apply in the situation where it's specified in the configuration file.
        default:
            healthMultiplier = (tanh((instancePlayerCount - 2.2) / 1.5) + 1) / 2;    // default to a 5 man group
        }

        //   VAS SOLO  - Map 0,1 and 530 ( World Mobs )                                                               // This may be where VAS_AutoBalance_CheckINIMaps might have come into play. None the less this is
        if((creature->GetMapId() == 0 || creature->GetMapId() == 1 || creature->GetMapId() == 530) && (creature->isElite() || creature->isWorldBoss()))  // specific to World Bosses and elites in those Maps, this is going to use the entry XPlayer in place of instancePlayerCount.
        {
            if(baseHealth > 800000){
                healthMultiplier = (tanh((AutoBalanceConfig::Instanace()->GetFloatValue(CONFIG_XPLAYER) - 5) / 1.5f) + 1) / 2;
            }else{
                healthMultiplier = (tanh((AutoBalanceConfig::Instanace()->GetFloatValue(CONFIG_XPLAYER) - 2.2f) / 1.5f) + 1) / 2; // Assuming a 5 man configuration, as World Bosses have been relatively retired since BC so unless the boss has some substantial baseHealth
            }

        }

        // Applying the Group Modifier
        healthMultiplier *= AutoBalanceConfig::Instanace()->GetFloatValue(VAS_GROUP_MODIFIER);

        // Ensure that the healthMultiplier is not lower than the configuration specified value. -- This may be Deprecated later.
        if(healthMultiplier <= AutoBalanceConfig::Instanace()->GetFloatValue(MIN_HP_MOD) )
        {
            healthMultiplier = AutoBalanceConfig::Instanace()->GetFloatValue(MIN_HP_MOD);
        }

        //Getting the list of Classes in this group - this will be used later on to determine what additional scaling will be required based on the ratio of tank/dps/healer
        //GetPlayerClassList(creature, playerClassList); // Update playerClassList with the list of all the participating Classes


        scaledHealth = uint32((baseHealth * healthMultiplier) + 1);
        // Now adjusting Mana, Mana is something that can be scaled linearly
        scaledMana = ((baseMana/maxNumberOfPlayers) * instancePlayerCount);
        // Now Adjusting Damage, this too is linear for now .... this will have to change I suspect.
        damageMultiplier = ((instancePlayerCount / maxNumberOfPlayers) * AutoBalanceConfig::Instanace()->GetFloatValue(VAS_DAMAGE_MODIFIER));

        // Can not be less then Min_D_Mod
        if(damageMultiplier <= AutoBalanceConfig::Instanace()->GetFloatValue(MIN_D_MOD))
        {
            damageMultiplier = AutoBalanceConfig::Instanace()->GetFloatValue(MIN_D_MOD);
        }

        if((AutoBalanceConfig::Instanace()->GetIntValue(VAS_DEBUG) >= 3))
        {
            sLog->outStaticDebug("## VAS-AutoBalance MobID=%u MapID=%u creatureName=%s  GUID=%llu  instancePlayerCount=%u", creatureTemplate->Entry, creature->GetMapId(), creatureTemplate->Name.c_str(), creature->GetGUID(), instancePlayerCount);
            sLog->outStaticDebug("## VAS-AutoBalance MapDifficulty=%u Health=%u / %u healthMultiplier=%4.5f VAS_Group_Modifer=%4.2f", creature->GetMap()->GetDifficulty(), scaledHealth, baseHealth, healthMultiplier, AutoBalanceConfig::Instanace()->GetFloatValue(VAS_GROUP_MODIFIER));
            sLog->outStaticDebug("## VAS-AutoBalance maxNumberOfPlayers=%u IsRaid=%s", maxNumberOfPlayers, BOOL_TO_STRING(creature->GetMap()->IsRaid()));
            sLog->outStaticDebug("## VAS-AutoBalance Mana %u / %u", baseMana, scaledMana);
            sLog->outStaticDebug("## VAS-AutoBalance damageMultiplier=%4.2f", damageMultiplier);
        }

        creature->SetCreateHealth(scaledHealth);
        creature->SetMaxHealth(scaledHealth);
        creature->ResetPlayerDamageReq();
        creature->SetCreateMana(scaledMana);
        creature->SetMaxPower(POWER_MANA, scaledMana);
        creature->SetPower(POWER_MANA, scaledMana);
        creature->SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, (float)scaledHealth);
        creature->SetModifierValue(UNIT_MOD_MANA, BASE_VALUE, (float)scaledMana);
        CreatureInfo[creature->GetGUID()].DamageMultiplier = damageMultiplier;
    }
};

void AddSC_VAS_AutoBalance()
{
    new VAS_AutoBalance_WorldScript;
    new VAS_AutoBalance_PlayerScript;
    new VAS_AutoBalance_UnitScript;
//    new VAS_AutoBalance_CreatureScript;
    new VAS_AutoBalance_AllCreatureScript;
    new VAS_AutoBalance_AllMapScript;
    new VAS_AutoBalance_WorldMapScript;
//    new VAS_AutoBalance_InstanceMapScript;
//    new VAS_AutoBalance_BattlegroundMapScript;
}
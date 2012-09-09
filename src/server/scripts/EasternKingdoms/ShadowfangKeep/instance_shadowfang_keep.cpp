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
SDName: Instance_Shadowfang_Keep
SD%Complete: 90
SDComment:
SDCategory: Shadowfang Keep
EndScriptData */

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "shadowfang_keep.h"

#define MAX_ENCOUNTER              5

class instance_shadowfang_keep : public InstanceMapScript
{
public:
    instance_shadowfang_keep() : InstanceMapScript("instance_shadowfang_keep", 33) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const
    {
        return new instance_shadowfang_keep_InstanceMapScript(map);
    }

    struct instance_shadowfang_keep_InstanceMapScript : public InstanceScript
    {
        instance_shadowfang_keep_InstanceMapScript(Map* map) : InstanceScript(map) {}

        uint64 BaronAshbury;
        uint64 BaronSilverline;
        uint64 CommanderSpringvale;
        uint64 LordWalden;
        uint64 LordGodfrey;

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        std::string str_data;

        void Initialize()
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

            BaronAshbury = 0;
            BaronSilverline = 0;
            CommanderSpringvale = 0;
            LordWalden = 0;
            LordGodfrey = 0;
        }

        void OnCreatureCreate(Creature* creature)
        {
            Map::PlayerList const &players = instance->GetPlayers();
            uint32 TeamInInstance = 0;

            if (!players.isEmpty())
            {
                if (Player* player = players.begin()->getSource())
                    TeamInInstance = player->GetTeam();
            }
            switch (creature->GetEntry())
            {
                case BARON_ASHBURY:
                    BaronAshbury = creature->GetGUID();
                    break;
                case BARON_SILVERLINE:
                    BaronSilverline = creature->GetGUID();
                    break;
                case COMMANDER_SPRINGVALE:
                    CommanderSpringvale = creature->GetGUID();
                    break;
                case LORD_WALDEN:
                    LordWalden = creature->GetGUID();
                    break;
                case LORD_GODFREY:
                    LordGodfrey = creature->GetGUID();
                    break;
                //Horde npcs are spawned by default, so change its if you are alliance
                case FORSAKEN_TROOPER:
                    if (TeamInInstance == ALLIANCE)
                        creature->UpdateEntry(BLOODFANG_BERSERKER, ALLIANCE);
                    break;
                case VETERAN_FORSAKEN_TROOPER:
                    if (TeamInInstance == ALLIANCE)
                        creature->UpdateEntry(BLOODFANG_BERSERKER, ALLIANCE);
                    break;
                case FORSAKEN_BLIGHTSPREADER:
                    if (TeamInInstance == ALLIANCE)
                        creature->UpdateEntry(BLOODFANG_BERSERKER, ALLIANCE);
                    break;
                case DEATHSTALKER_COMMANDER_BELMONT:
                    if (TeamInInstance == ALLIANCE)
                        creature->UpdateEntry(PACKLEADER_IVAR_BLOODFANG, ALLIANCE);
                    break;
             }
        }

        void OnGameObjectCreate(GameObject* go)
        {
            switch (go->GetEntry())
            {
            }
        }

        void SetData(uint32 type, uint32 data)
        {
            switch (type)
            {
                case BOSS_BARON_ASHBURY:
                    m_auiEncounter[0] = data;
                    break;
                case BOSS_BARON_SILVERLAINE:
                    m_auiEncounter[1] = data;
                    break;
                case BOSS_COMMANDER_SPRINGVALE:
                    m_auiEncounter[2] = data;
                    break;
                case BOSS_LORD_WALDEN:
                    m_auiEncounter[3] = data;
                    break;
                case BOSS_LORD_GODFREY:
                    m_auiEncounter[4] = data;
                    break;
            }

            if (data == DONE)
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' ' << m_auiEncounter[2] << ' '
                    << m_auiEncounter[3] << ' ' << m_auiEncounter[4];

                str_data = saveStream.str();

                SaveToDB();
                OUT_SAVE_INST_DATA_COMPLETE;
            }
        }

        uint64 GetData64(uint32 uiIdentifier)
        {
            switch (uiIdentifier)
            {
                case BOSS_BARON_ASHBURY:            return BaronAshbury;
                case BOSS_BARON_SILVERLAINE:        return BaronSilverline;
                case BOSS_COMMANDER_SPRINGVALE:     return CommanderSpringvale;
                case BOSS_LORD_WALDEN:              return LordWalden;
                case BOSS_LORD_GODFREY:             return LordGodfrey;
            }
            return 0;
        }

        std::string GetSaveData()
        {
            return str_data;
        }

        void Load(const char *chrIn)
        {
            if (!chrIn)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(chrIn);

            std::istringstream loadStream(chrIn);
            loadStream >> m_auiEncounter[0] >> m_auiEncounter[1] >> m_auiEncounter[2] >> m_auiEncounter[3] >> m_auiEncounter[4];

            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS)
                    m_auiEncounter[i] = NOT_STARTED;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        void Update(uint32 uiDiff)
        {
        }
    };

};

void AddSC_instance_shadowfang_keep()
{
    new instance_shadowfang_keep();
}

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
        instance_shadowfang_keep_InstanceMapScript(Map* map) : InstanceScript(map) 
        {
            SetBossNumber(MAX_ENCOUNTER);
        }

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        std::string str_data;

        void Initialize()
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
        }

        void OnCreatureCreate(Creature* creature)
        {
            switch (creature->GetEntry())
            {
            }
        }

        void OnGameObjectCreate(GameObject* go)
        {
            switch (go->GetEntry())
            {
            }
        }

        void DoSpeech()
        {
        }

        void SetData(uint32 type, uint32 data)
        {
            switch (type)
            {
            }
        }

        uint32 GetData(uint32 type)
        {
            switch (type)
            {
            }
            return 0;
        }

        std::string GetSaveData()
        {
            std::ostringstream saveStream;
            saveStream << " " << GetBossSaveData();
            return saveStream.str();
        }

        void Load(const char* str)
        {
            std::istringstream loadStream(str);
            uint32 temp;

            for (uint32 i = 0; i < MAX_ENCOUNTER; ++i)
                loadStream >> temp;
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

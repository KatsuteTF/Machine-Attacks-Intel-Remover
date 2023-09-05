// Copyright (C) 2023 Katsute | Licensed under CC BY-NC-SA 4.0

#pragma semicolon 1

#include <sourcemod>
#include <sdkhooks>
#include <tf2>
#include <tf2_stocks>

public Plugin myinfo = {
    name        = "Machine Attacks Intel Remover",
    author      = "Katsute",
    description = "Removes the intelligence for the RED team",
    version     = "1.0",
    url         = "https://github.com/KatsuteTF/Machine-Attacks-Intel-Remover"
}

public void OnPluginStart(){
    HookEvent("teamplay_flag_event", OnIntel);
}

public void OnIntel(const Event event, const char[] name, const bool dontBroadcast){
    if(GetEventInt(event, "eventtype") == TF_FLAGEVENT_PICKEDUP){
        int client = event.GetInt("player");
        if(TFTeam:GetClientTeam(client) == TFTeam_Red){
            int ent = -1;
            while((ent = FindEntityByClassname(ent, "item_teamflag")) != -1){
                int owner = GetEntPropEnt(ent, Prop_Send, "m_hOwnerEntity");
                if(owner == client){
                    AcceptEntityInput(ent, "ForceResetAndDisableSilent");
                    AcceptEntityInput(ent, "Kill");
                }
            }
        }
    }
}
using System;
using System.Linq;
using GGJ2025.Scripts.Constants;
using Godot;

namespace GGJ2025.Scripts.Helpers;
public static class GetNodeHelper
{
    public static CharacterBody3D GetPlayer(SceneTree tree)
    {
        var playerNode = tree
            .GetNodesInGroup(NodeGroup.Player)
            .FirstOrDefault(x => x.Name == GlobalConstants.PlayerName);

        if (playerNode is CharacterBody3D player)
        {
            return player;
        } 
        
        GD.PrintErr("Could not find player.");
        return null;
    }
}
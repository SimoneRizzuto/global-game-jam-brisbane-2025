using System;
using GGJ2025.Scripts.Constants;
using GGJ2025.Scripts.Enemies;
using Godot;

namespace GGJ2025.Scripts.StateMachines;

[GlobalClass]
public partial class EnemyStateMachine : Node
{
    [Export] public EnemyState EnemyState = EnemyState.Patrolling;
    public Enemy Enemy => GetParent<Enemy>();

    public Vector3? GlobalLastPositionOnPath;
    
    // signals
    public void _on_chase_player_area_3d_body_entered(Node3D bodyEntered)
    {
        var isPlayer = bodyEntered is CharacterBody3D player && player.Name == GlobalConstants.PlayerName;
        if (isPlayer)
        {
            EnemyState = EnemyState.Chasing;
            
            GD.Print("trigger enemy chase...");
            return;
        }
    }
}
using System;
using GGJ2025.Scripts.Enemies;
using GGJ2025.Scripts.Helpers;
using GGJ2025.Scripts.StateMachines;
using Godot;

namespace GGJ2025.Scripts.Modules.Enemies;

[GlobalClass]
public partial class EnemyChasingModule : Node
{
    private CharacterBody3D Player => GetNodeHelper.GetPlayer(GetTree());
    public EnemyStateMachine State;

    public override void _Ready()
    {
        State = GetParent<EnemyStateMachine>();
    }

    public override void _Process(double delta)
    {
        if (State?.EnemyState != EnemyState.Chasing) return;

        if (State.GlobalLastPositionOnPath == null)
        {
            State.GlobalLastPositionOnPath = State.Enemy.GlobalPosition;
        }
        
        var movementVector = State.Enemy.GlobalPosition.DirectionTo(Player.GlobalPosition);
        State.Enemy.CalculatedVelocity = movementVector * State.Enemy.ChaseMoveSpeed;
        
        CheckDistanceToPlayer();
    }

    private void CheckDistanceToPlayer()
    {
        var distanceSquared = State.Enemy.GlobalPosition.DistanceTo(Player.GlobalPosition);
        if (distanceSquared > 4)
        {
            State.EnemyState = EnemyState.Resetting;
        }
    }
}
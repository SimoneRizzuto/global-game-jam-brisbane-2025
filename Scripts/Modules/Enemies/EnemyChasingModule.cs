using GGJ2025.Scripts.Enemies;
using GGJ2025.Scripts.Helpers;
using GGJ2025.Scripts.StateMachines;
using Godot;

namespace GGJ2025.Scripts.Modules.Enemies;

[GlobalClass]
public partial class EnemyChasingModule : Node
{
    public EnemyStateMachine State => GetParent().GetParent<EnemyStateMachine>();
    private CharacterBody3D Player => GetNodeHelper.GetPlayer(GetTree());
    
    public override void _Process(double delta)
    {
        if (State.EnemyState != EnemyState.Chasing) return;
        
        var movementVector = State.Enemy.Position.DirectionTo(Player.Position);
        State.Enemy.CalculatedVelocity = movementVector * Enemy.MoveSpeed * (float)delta;
    }
}
using System;
using GGJ2025.Scripts.Enemies;
using GGJ2025.Scripts.StateMachines;
using Godot;

namespace GGJ2025.Scripts.Modules.Enemies;

[GlobalClass]
public partial class EnemyResettingModule : Node
{
    public EnemyStateMachine State => GetParent<EnemyStateMachine>();
    private Path3D Path => State.Enemy.Path;

    public override void _Process(double delta)
    {
        if (State?.EnemyState != EnemyState.Resetting) return;
        
        var closestPoint = Path.Curve.GetClosestPoint(State.Enemy.GlobalPosition);
        var movementVector = State.Enemy.GlobalPosition.DirectionTo(closestPoint);
        State.Enemy.CalculatedVelocity = movementVector * State.Enemy.ChaseMoveSpeed;
        
        CheckDistanceToClosestPointOnCurve(closestPoint);
    }
    
    private void CheckDistanceToClosestPointOnCurve(Vector3 closestPoint)
    {
        var distanceSquared = State.Enemy.GlobalPosition.DistanceTo(closestPoint);
        if (distanceSquared < 0.5)
        {
            State.EnemyState = EnemyState.Patrolling;
        }
    }
}
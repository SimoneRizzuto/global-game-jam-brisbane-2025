using System;
using GGJ2025.Scripts.Enemies;
using GGJ2025.Scripts.StateMachines;
using Godot;

namespace GGJ2025.Scripts.Modules.Enemies;

[GlobalClass]
public partial class EnemyResettingModule : Node
{
    private Path3D Path => State.Enemy.Path;
    public EnemyStateMachine State;

    public override void _Ready()
    {
        State = GetParent<EnemyStateMachine>();
    }

    public override void _Process(double delta)
    {
        if (State?.EnemyState != EnemyState.Resetting || State?.GlobalLastPositionOnPath == null) return;

        GD.Print(State.GlobalLastPositionOnPath.Value);
        GD.Print(State.Enemy.GlobalPosition);
        
        var movementVector = State.Enemy.GlobalPosition.DirectionTo(State.GlobalLastPositionOnPath.Value);
        State.Enemy.CalculatedVelocity = movementVector * State.Enemy.ChaseMoveSpeed;
        
        CheckDistanceToLastPointOnCurve(State.GlobalLastPositionOnPath.Value);
        
        /*
        var closestPoint = Path.Curve.GetClosestPoint(State.Enemy.GlobalPosition);
        var movementVector = State.Enemy.GlobalPosition.DirectionTo(closestPoint);
        State.Enemy.CalculatedVelocity = movementVector * State.Enemy.ChaseMoveSpeed;
        
        CheckDistanceToClosestPointOnCurve(closestPoint);
        */
    }
    
    private void CheckDistanceToLastPointOnCurve(Vector3 closestPoint)
    {
        var distanceSquared = State.Enemy.GlobalPosition.DistanceTo(closestPoint);
        if (distanceSquared < 0.1)
        {
            State.EnemyState = EnemyState.Patrolling;
            
            State.Enemy.CalculatedVelocity = Vector3.Zero;
            State.GlobalLastPositionOnPath = null;

        }
    }
}
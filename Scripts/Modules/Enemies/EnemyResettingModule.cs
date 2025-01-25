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
        
        var closestPoint = Path.Curve.GetClosestPoint(State.Enemy.Position);
        Console.WriteLine(closestPoint);
    }
}
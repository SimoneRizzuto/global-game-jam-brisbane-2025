using System;
using GGJ2025.Scripts.Enemies;
using GGJ2025.Scripts.StateMachines;
using Godot;

namespace GGJ2025.Scripts.Modules.Enemies;

[GlobalClass]
public partial class EnemyPatrollingModule : Node
{
    public EnemyStateMachine State => GetParent<EnemyStateMachine>();
    private PathFollow3D FollowPath => State.Enemy.FollowPath;

    public override void _Process(double delta)
    {
        if (State?.EnemyState != EnemyState.Patrolling) return;

        FollowPath.Progress += State.Enemy.PatrolMoveSpeed * (float)delta;
    }
}
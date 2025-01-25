using GGJ2025.Scripts.Enemies;
using GGJ2025.Scripts.StateMachines;
using Godot;

namespace GGJ2025.Scripts.Modules.Enemies;

[GlobalClass]
public partial class EnemyPatrollingModule : Node
{
    public EnemyStateMachine State => GetParent().GetParent<EnemyStateMachine>();

    public override void _Process(double delta)
    {
        if (State.EnemyState != EnemyState.Patrolling) return;
    }
}
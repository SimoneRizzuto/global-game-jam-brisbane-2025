using GGJ2025.Scripts.StateMachines;
using Godot;

namespace GGJ2025.Scripts.Modules.Enemies;

[GlobalClass]
public partial class EnemyPatrollingModule : Node
{
    public EnemyStateMachine State => GetParent().GetParent<EnemyStateMachine>();
    
}
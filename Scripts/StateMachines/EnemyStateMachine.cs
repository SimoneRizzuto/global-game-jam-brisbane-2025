using GGJ2025.Scripts.Enemies;
using Godot;

namespace GGJ2025.Scripts.StateMachines;

[GlobalClass]
public partial class EnemyStateMachine : Node
{
    [Export] public EnemyState EnemyState = EnemyState.Chasing;
    public Enemy Enemy => GetParent<Enemy>();
}
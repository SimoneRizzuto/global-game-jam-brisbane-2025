using GGJ2025.Scripts.StateMachines;
using Godot;

namespace GGJ2025.Scripts.Modules.Enemies;

[GlobalClass]
public partial class EnemyChasingModule : Node
{
    public EnemyStateMachine StateMachine => GetParent().GetParent<EnemyStateMachine>();
    
}
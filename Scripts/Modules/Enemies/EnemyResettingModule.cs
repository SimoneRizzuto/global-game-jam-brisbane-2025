using GGJ2025.Scripts.StateMachines;
using Godot;

namespace GGJ2025.Scripts.Modules.Enemies;

[GlobalClass]
public partial class EnemyResettingModule : Node
{
    public EnemyStateMachine StateMachine => GetParent().GetParent<EnemyStateMachine>();
    
    
}
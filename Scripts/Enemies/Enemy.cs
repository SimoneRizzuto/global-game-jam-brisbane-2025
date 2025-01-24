using System.Linq;
using GGJ2025.Scripts.Constants;
using GGJ2025.Scripts.Helpers;
using Godot;

namespace GGJ2025.Scripts.Enemies;
public partial class Enemy : CharacterBody3D
{
	[Export] public Vector3 CalculatedVelocity;
	
	public override void _PhysicsProcess(double delta)
	{
		Velocity = CalculatedVelocity * (float)delta;
		MoveAndSlide();
		
		var roundedPosition = Position;
		Position = roundedPosition;
	}
	
	private CharacterBody3D Player => GetNodeHelper.GetPlayer(GetTree());
	private EnemyState _state;
}
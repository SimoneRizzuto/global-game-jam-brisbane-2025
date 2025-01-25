using GGJ2025.Scripts.Constants;
using Godot;

namespace GGJ2025.Scripts.Enemies;
public partial class Enemy : CharacterBody3D
{
	[Export] public Vector3 CalculatedVelocity;
	[Export] public float ChaseMoveSpeed = 90;
	[Export] public float PatrolMoveSpeed = 1;
	
	public Path3D Path => GetParent().GetParent<Path3D>();
	public PathFollow3D FollowPath => GetParent<PathFollow3D>();

	public override void _PhysicsProcess(double delta)
	{
		Velocity = CalculatedVelocity * (float)delta;
		MoveAndSlide();
	}
}
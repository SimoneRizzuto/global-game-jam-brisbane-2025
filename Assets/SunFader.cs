using Godot;
using System;

public partial class SunFader : DirectionalLight3D
{
	[Export] private Node3D player;
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		float v = Mathf.Clamp(Mathf.InverseLerp(-150f, 0f, player.Position.Y), 0f, 1f);
		LightVolumetricFogEnergy =  v* 11f;
	}
}

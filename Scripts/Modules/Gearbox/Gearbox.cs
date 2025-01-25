using Godot;
using System;

public partial class Gearbox : Node
{
	public float oxygen = 100;
	public static Gearbox instance = null;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		if (Gearbox.instance == null)
        {
			Gearbox.instance = this;
        }
        else
        {
			this.QueueFree();
		}
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}

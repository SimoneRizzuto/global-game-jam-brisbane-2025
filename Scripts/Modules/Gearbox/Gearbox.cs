using Godot;
using System;

public partial class Gearbox : Node
{
	public float oxygen = 100;
	public static Gearbox instance = null;

	public Node UI;

	public bool paused = false;
	public bool start = false;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		start = true;
		
		if (Gearbox.instance == null)
        {
			Gearbox.instance = this;
        }
        else
        {
			this.QueueFree();
		}
		UI = FindChild("UI");
		Pause();
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{

	}

	public void Pause()
    {
		paused = true;
		UI.Call("Pause",start);

	}
	public void Unpause()
	{
		paused = false;
		start = false;
		UI.Call("UnPause");
	}

	public void GetMessage(string message, string imagePath)
    {
		UI.Call("Get_Message", message, imagePath);
    }
}

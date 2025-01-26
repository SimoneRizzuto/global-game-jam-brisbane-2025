using Godot;
using System;

public partial class TitleCardTrigger : Node3D
{
	[Export] private Node3D player;
	[Export] private TitleCard card;
	[Export(PropertyHint.MultilineText)] private string title;
	[Export(PropertyHint.MultilineText)] private string subtitle;

	[Export] private bool typeOut = false;

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if (player.Position.Y < Position.Y)
		{
			card.UpdateTitle(title,subtitle,typeOut);
			QueueFree();
		}
	}
}

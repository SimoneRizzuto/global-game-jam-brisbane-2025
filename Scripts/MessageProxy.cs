using Godot;
using System;
using GGJ2025.Scripts.MessageBubble;

public partial class MessageProxy : Node
{
	private bool triggered = false;
	public void TriggerMessage(Node3D body)
	{
		if (triggered) return;
		triggered = true;
		if (body.Name != "Player") return;
		MessageBubble p = GetParent<MessageBubble>();
		TitleCard.main.UpdateTitle(p.profilePic.ResourcePath.GetFile().TrimSuffix(".JPG"),p.Message,true,p.profilePic);
		
		GetParent().QueueFree();
	}
}

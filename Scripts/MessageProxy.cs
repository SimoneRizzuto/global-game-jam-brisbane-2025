using Godot;
using System;
using GGJ2025.Scripts.MessageBubble;

public partial class MessageProxy : Node
{
	public void TriggerMessage(Node3D body)
	{
		if (body.Name != "Player") return;
		TitleCard.main.UpdateTitle("Message",GetParent<MessageBubble>().Message,true);
	}
}

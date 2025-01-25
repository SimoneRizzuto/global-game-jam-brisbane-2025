using GGJ2025.Scripts.Constants;
using Godot;

namespace GGJ2025.Scripts.MessageBubble;
public partial class MessageBubble : Node3D
{
	[Export(PropertyHint.MultilineText)] public string Message;
	[Export] public string ProfilePicPath;

	
	// signals
	private void _on_area_3d_body_entered(Node3D bodyEntered)
	{
		var isPlayer = bodyEntered is CharacterBody3D player && player.Name == GlobalConstants.PlayerName;
		if (isPlayer)
		{
			// trigger dialogue UI, pass in Message and ProfilePicPath
			
			GD.Print("trigger message display");
			//Gearbox.instance.GetMessage(Message, ProfilePicPath);
			return;
		}
	}
}

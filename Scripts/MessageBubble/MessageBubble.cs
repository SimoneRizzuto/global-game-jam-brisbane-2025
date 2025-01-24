using Godot;

namespace GGJ2025.Scripts.MessageBubble;
public partial class MessageBubble : Node3D
{
    [Export(PropertyHint.MultilineText)] public string Message;
    [Export] public string ProfilePicPath;
}
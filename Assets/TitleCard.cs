using Godot;
using System;

public partial class TitleCard : Control
{
	[Export] private Label mainTitle;
	[Export] private Label subTitle;
	
	

	public void UpdateTitle(string title, string subtitle,bool typeOut)
	{
		mainTitle.Text = title;
		visibleTitleCharacters = typeOut ? 0 : title.Length;
		subTitle.Text = subtitle;
		visibleSubtitleCharacters = 0;

		clearTime = 8f;
	}

	private float coolDown = 0.05f;

	private float clearTime = 0f;

	private int visibleTitleCharacters = 0;
	private int visibleSubtitleCharacters = 0;

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if (Gearbox.instance.paused) return;
		coolDown -= (float)delta;
		clearTime -= (float)delta;
		
		if (coolDown < 0f)
		{
			coolDown += 0.015f;
			if (clearTime > 0f)
			{
				if (visibleTitleCharacters < mainTitle.Text.Length + 20)
				{
					visibleTitleCharacters++;
					if (visibleTitleCharacters < mainTitle.Text.Length)
						if (mainTitle.Text[visibleTitleCharacters] == '\n') coolDown += 0.25f;

				}
				else if (visibleSubtitleCharacters < subTitle.Text.Length)
				{
					visibleSubtitleCharacters++;
					if (visibleSubtitleCharacters < subTitle.Text.Length)
					if (subTitle.Text[visibleSubtitleCharacters] == '\n') coolDown += 0.25f;
				}
			}
			else
			{
				if (visibleSubtitleCharacters > 0)
				{
					
					visibleSubtitleCharacters--;
				}
				if (visibleTitleCharacters > 0)
				{
					visibleTitleCharacters--;

				}
				
			}
			
		}

		mainTitle.VisibleCharacters = visibleTitleCharacters;
		subTitle.VisibleCharacters = Math.Max(visibleSubtitleCharacters, 0);



	}
}

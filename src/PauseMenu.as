package 
{
	import flashx.textLayout.formats.TextAlign;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxSubState;

	/**
	 * @author IQAndreas
	 */
	public class PauseMenu extends FlxSubState
	{
		public static const QUIT_GAME:String = "PauseMenu::quit_game";
		public static const RESUME_GAME:String = "PauseMenu::resume_game";
		public static const RESTART:String = "PauseMenu::restart_game";
		public var text:FlxText;
		public var resumeBtn:FlxButton;
		public var quitBtn:FlxButton;
		
		public function PauseMenu()
		{
			super(true, 0x33000000, true);
		}
		
		public override function create():void
		{
			FlxG.mouse.show();
			//Sorry about all the hardcoded position values. :(
			var currentY:Number = 50;
			
			text = new FlxText(0, currentY, FlxG.width, "PAUSE");
			text.setFormat(null, 50, 0x00FF8000, TextAlign.CENTER, 0xFFCCCCCC);
			FlxG.state.add(text);
			currentY += text.height + 50;
			text.scrollFactor = new FlxPoint(0, 0);
			
			resumeBtn = new FlxButton(0, currentY, "Reprendre", resume);
			resumeBtn.x = (FlxG.width / 2) - (resumeBtn.width / 2);
			FlxG.state.add(resumeBtn);
			currentY = resumeBtn.y + 80;
			resumeBtn.scrollFactor = new FlxPoint(0, 0);
			
			quitBtn = new FlxButton(0, currentY, "Retourner au Menu", tryQuit);
			quitBtn.x = (FlxG.width / 2) - (quitBtn.width / 2);
			FlxG.state.add(quitBtn);
			quitBtn.scrollFactor = new FlxPoint(0, 0);
			
			quitBtn.scale = new FlxPoint(3, 3);
			resumeBtn.scale = new FlxPoint(3, 3);
		}
		
		private function resume():void
		{
			FlxG.mouse.hide();
			quitBtn.visible = false;
			resumeBtn.visible = false;
			text.visible = false;
			this.close(RESUME_GAME);
		}
		
		private function tryQuit():void
		{
			this.close(QUIT_GAME);

			//TODO
			//this.setSubState(new Dialog("Are you sure you want to quit?", yes, no));
			//this.quit(null, yes);
		}
		
		/*
		private const yes:String = "Yes";
		private const no:String = "No";
		
		private function quit(state:FlxSubState, result:String):void
		{
			if (result == yes)
			{
				this.close(QUIT_GAME);
			}
		}*/

	}
}

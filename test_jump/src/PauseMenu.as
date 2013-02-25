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
	import org.flixel.plugin.photonstorm.FlxCollision;

	/**
	 * Pause
	 * @author 
	 */
	public class PauseMenu extends FlxSubState
	{
		public static const QUIT_GAME:String = "PauseMenu::quit_game";
		public static const RESUME_GAME:String = "PauseMenu::resume_game";
		public static const RESTART:String = "PauseMenu::restart_game";
		public var text:FlxText;
		public var restartText:FlxText;
		public var resumeText:FlxText;
		public var quitText:FlxText;
		public var cursor:FlxSprite;
		public var resumePic:FlxSprite;
		public var restartPic:FlxSprite;
		public var quitPic:FlxSprite;
		[Embed(source = '../assets/gfx/ui/cursor.png')] protected var ImgCursor:Class;
		[Embed(source = '../assets/gfx/ui/btn_menu.png')] protected var ImgMenu:Class;
		[Embed(source = '../assets/fonts/phillysansps.otf',	fontFamily = "philly", embedAsCFF = "false")] protected var	Font3:Class;
		
		public function PauseMenu()
		{
			super(true, 0x33000000, true);
		}
		
		public override function create():void
		{			
			// RESUME			
			resumePic = new FlxSprite(0, FlxG.height *3/15, ImgMenu);
			resumePic.x = (FlxG.width / 2) - (resumePic.frameWidth / 2);
			FlxG.state.add(resumePic);
			resumePic.scrollFactor = new FlxPoint(0, 0);
			
			resumeText = new FlxText(0, FlxG.height * 3 / 15, FlxG.width, "Reprendre");
			resumeText.y += resumePic.frameHeight / 7;
			resumeText.setFormat("philly", 40, 0x00000000, TextAlign.CENTER, 0xFFCCCCCC);
			FlxG.state.add(resumeText);
			resumeText.scrollFactor = new FlxPoint(0, 0);
			
			
			// RESTART
			restartPic = new FlxSprite(0, FlxG.height *6/15, ImgMenu);
			restartPic.x = (FlxG.width / 2) - (restartPic.frameWidth / 2);
			FlxG.state.add(restartPic);
			restartPic.scrollFactor = new FlxPoint(0, 0);
			
			restartText = new FlxText(0, FlxG.height * 6 / 15, FlxG.width, "Recommencer");
			restartText.y += restartPic.frameHeight / 7;
			restartText.setFormat("philly", 40, 0x00000000, TextAlign.CENTER, 0xFFCCCCCC);
			FlxG.state.add(restartText);
			restartText.scrollFactor = new FlxPoint(0, 0);
			
			// RETOUR AU MENU
			quitPic = new FlxSprite(0, FlxG.height *9/15, ImgMenu);
			quitPic.x = (FlxG.width / 2) - (quitPic.frameWidth / 2);
			FlxG.state.add(quitPic);
			quitPic.scrollFactor = new FlxPoint(0, 0);
			
			quitText = new FlxText(0, FlxG.height * 9 / 15, FlxG.width, "Retour au menu");
			quitText.y += quitPic.frameHeight / 7;
			quitText.setFormat("philly", 40, 0x00000000, TextAlign.CENTER, 0xFFCCCCCC);
			FlxG.state.add(quitText);
			quitText.scrollFactor = new FlxPoint(0, 0);
			
			
			// PAUSE
			text = new FlxText(0, FlxG.height /15, FlxG.width, "PAUSE");
			text.setFormat("philly", 60, 0x00FF8000, TextAlign.CENTER, 0xFFCCCCCC);
			FlxG.state.add(text);
			text.scrollFactor = new FlxPoint(0, 0);
			
			// CURSEUR SOURIS
			cursor = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y, ImgCursor);
			FlxG.state.add(cursor)
		}
		
		// UPDATE DU MENU PAUSE
		public function inPause():void {
			// GESTION CLICS SOURIS
			if (FlxG.mouse.justPressed()) {
				
				//RESTART
				if (FlxCollision.pixelPerfectCheck(cursor, restartPic))
					restart();
					
				//RESUME
				if (FlxCollision.pixelPerfectCheck(cursor, resumePic))
					resume();
					
				//QUIT
				if (FlxCollision.pixelPerfectCheck(cursor, quitPic))
					tryQuit();
	
			}
			cursor.x = FlxG.mouse.x - cursor.frameWidth/2;
			cursor.y = FlxG.mouse.y - cursor.frameHeight/2;	
		}
		
		// REDEMARRER
		private function restart():void
		{
			this.close(RESTART);
		}
		
		// REPRENDRE
		private function resume():void
		{
			quitPic.visible = false;
			resumePic.visible = false;
			restartPic.visible = false;
			quitText.visible = false;
			resumeText.visible = false;
			restartText.visible = false;
			cursor.visible = false;
			text.visible = false;
			this.close(RESUME_GAME);
		}
		
		// RETOUR AU MENU
		private function tryQuit():void
		{
			this.close(QUIT_GAME);
		}
	}
}

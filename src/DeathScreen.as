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
	public class DeathScreen extends FlxSubState
	{
		public static const QUIT_GAME:String = "DeathScreen::quit_game";
		public static const RETRY:String = "DeathScreen::retry";
		public static const RESTART:String = "DeathScreen::restart";
		public var text:FlxText;
		public var restartText:FlxText;
		public var resumeText:FlxText;
		public var quitText:FlxText;
		public var cursor:FlxSprite;
		public var resumePic:FlxSprite;
		public var restartPic:FlxSprite;
		public var quitPic:FlxSprite;
		[Embed(source = '../assets/gfx/ui/cursor.png')] protected var ImgCursor:Class;
		[Embed(source = '../assets/gfx/ui/cursor_anim.png')] protected var ImgCursorAnim:Class;
		[Embed(source = '../assets/gfx/ui/btn_menu.png')] protected var ImgMenu:Class;
		[Embed(source = '../assets/gfx/ui/btn_menu_on.png')] protected var ImgMenuOn:Class;
		[Embed(source = '../assets/fonts/phillysansps.otf',	fontFamily = "philly", embedAsCFF = "false")] protected var	Font3:Class;
		
		public function DeathScreen()
		{
			super(true, 0x33FF00FF, true);
			trace("dead");
			FlxG.mouse.hide();
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
			text = new FlxText(0, FlxG.height /15, FlxG.width, "MORT");
			text.setFormat("philly", 60, 0x00FF8000, TextAlign.CENTER, 0xFFCCCCCC);
			FlxG.state.add(text);
			text.scrollFactor = new FlxPoint(0, 0);
			
			// CURSEUR SOURIS
			cursor = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y);
			cursor.loadGraphic(ImgCursorAnim, true, false, 40, 40);
			cursor.addAnimation("souris", [0, 1, 2, 3], 8, true);
			cursor.play("souris");
			FlxG.state.add(cursor)
		}
		
		// UPDATE DU MENU PAUSE
		public function inPause():void {
			// GESTION CLICS SOURIS				
				//RESTART
				if (FlxCollision.pixelPerfectCheck(cursor, restartPic)) {
					restartPic.loadGraphic(ImgMenuOn);
					if (FlxG.mouse.justPressed())
					restart();
				}
				else
					restartPic.loadGraphic(ImgMenu);
					
				//RESUME
				if (FlxCollision.pixelPerfectCheck(cursor, resumePic)) {
					resumePic.loadGraphic(ImgMenuOn);
					if (FlxG.mouse.justPressed())
					retry();
				}
				else
					resumePic.loadGraphic(ImgMenu);
				
				//QUIT
				if (FlxCollision.pixelPerfectCheck(cursor, quitPic)) {
					quitPic.loadGraphic(ImgMenuOn);
					if (FlxG.mouse.justPressed())
					tryQuit();
				}
				else
					quitPic.loadGraphic(ImgMenu);
			cursor.x = FlxG.mouse.x - cursor.frameWidth/2;
			cursor.y = FlxG.mouse.y - cursor.frameHeight/2;	
		}
		
		// REPRENDRE
		private function retry():void
		{
			cursor.kill();
			restartPic.kill();
			restartText.kill();
			resumePic.kill();
			resumeText.kill();
			quitPic.kill();
			quitText.kill();
			text.kill();
			this.close(RETRY);
		}
		
		// RECOMMENCER
		private function restart():void
		{
			this.close(RESTART);
		}
		
		// RETOUR AU MENU
		private function tryQuit():void
		{
			this.close(QUIT_GAME);
		}
	}
}
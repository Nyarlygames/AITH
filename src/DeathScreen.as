package 
{
	import flash.sampler.NewObjectSample;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxSubState;
	import com.greensock.*;
	import com.greensock.easing.*;
	import org.flixel.plugin.photonstorm.FlxSpecialFX;
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
		
		[Embed(source = '../assets/gfx/ui/cursor.png')] 			protected var ImgCursor:Class;
		[Embed(source = '../assets/gfx/ui/cursor_anim.png')] 		protected var ImgCursorAnim:Class;
		[Embed(source = '../assets/gfx/ui/menu-mort.png')] 			protected var ImgMenu:Class;
		[Embed(source = '../assets/gfx/ui/mort-mort.png')] 			protected var ImgMort:Class;
		[Embed(source = '../assets/gfx/ui/recommencer-mort.png')] 	protected var ImgRestart:Class;
		[Embed(source = '../assets/gfx/ui/continuer-mort.png')] 	protected var ImgContinue:Class;
		[Embed(source = '../assets/gfx/ui/filtre-mort.png')] 	protected var ImgFiltre:Class;
		[Embed(source = '../assets/gfx/ui/pause_pic.png')] 		protected var ImgPause:Class;
		[Embed(source = '../assets/fonts/phillysansps.otf',	fontFamily = "philly", embedAsCFF = "false")] protected var	Font3:Class;
		
		public var text:FlxText;
		public var restartText:FlxText;
		public var resumeText:FlxText;
		public var quitText:FlxText;
		public var cursor:FlxSprite;
		public var deathPic:FlxSprite;
		public var filtreDeath:FlxSprite;
		public var restartPic:FlxSprite;
		public var continuePic:FlxSprite;
		public var menuPic:FlxSprite;
		
		public function DeathScreen()
		{
			super(true, 0xA4B7A3, true);
			FlxG.mouse.hide();
		}
		
		public override function create():void
		{
			
			// Filtre de mort
			filtreDeath = new FlxSprite(0, 0, ImgFiltre);
			filtreDeath.loadGraphic(ImgFiltre, true, false, 800, 600);
			filtreDeath.scrollFactor = new FlxPoint(0, 0);
			FlxG.state.add(filtreDeath);
			
			// Texte de mort
			deathPic = new FlxSprite(40, 30, ImgMort);
			deathPic.loadGraphic(ImgMort, true, false, 211, 81);
			deathPic.scrollFactor = new FlxPoint(0, 0);
			FlxG.state.add(deathPic);
			
			// Texte de continue
			continuePic = new FlxSprite(40,112, ImgContinue);
			continuePic.loadGraphic(ImgContinue, true, false, 300, 62);
			continuePic.scrollFactor = new FlxPoint(0, 0);
			FlxG.state.add(continuePic);
			
			// Texte de restart
			restartPic = new FlxSprite(40, 174, ImgRestart);
			restartPic.loadGraphic(ImgRestart, true, false, 300, 63);
			restartPic.scrollFactor = new FlxPoint(0, 0);
			FlxG.state.add(restartPic);
			
			// Texte de menu
			menuPic = new FlxSprite(627, 516, ImgMenu);
			menuPic.loadGraphic(ImgMenu, true, false, 150, 72);
			menuPic.scrollFactor = new FlxPoint(0, 0);
			FlxG.state.add(menuPic);
			
			// CURSEUR SOURIS
			cursor = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y);
			cursor.loadGraphic(ImgCursorAnim, true, false, 40, 40);
			cursor.addAnimation("souris", [0, 1, 2, 3], 8, true);
			cursor.play("souris");
			FlxG.state.add(cursor)
		}
		
		// UPDATE DU MENU PAUSE
		public function inPause():void
		{
			
			// Continue la partie
			if (FlxCollision.pixelPerfectCheck(cursor, continuePic)) 
			{
				TweenMax.to(continuePic.scale, 0.5, { x : 1.1, y : 1.1, ease:Linear.easeOut});
				if (FlxG.mouse.justPressed())
				{
					retry();
				}
			}
			else
			{
				TweenMax.to(continuePic.scale, 0.5, { x : 1, y : 1, ease:Linear.easeOut});
			}
			
			// Relance la partie
			if (FlxCollision.pixelPerfectCheck(cursor, restartPic)) 
			{
				TweenMax.to(restartPic.scale, 0.5, { x : 1.1, y : 1.1, ease:Linear.easeOut});
				if (FlxG.mouse.justPressed())
				{
					restart();
				}
			}
			else
			{
				TweenMax.to(restartPic.scale, 0.5, { x : 1, y : 1, ease:Linear.easeOut});
			}
			
			// Renvoie au menu
			if (FlxCollision.pixelPerfectCheck(cursor, menuPic)) 
			{
				TweenMax.to(menuPic.scale, 0.5, { x : 1.1, y : 1.1, ease:Linear.easeOut});
				if (FlxG.mouse.justPressed())
				{
					tryQuit();
				}
			}
			else
			{
				TweenMax.to(menuPic.scale, 0.5, { x : 1, y : 1, ease:Linear.easeOut});
			}
			
			
			
			// Gestion clavier
			cursor.x = FlxG.mouse.x - cursor.frameWidth/2;
			cursor.y = FlxG.mouse.y - cursor.frameHeight/2;	
		}
		
		// REPRENDRE
		private function retry():void
		{
			filtreDeath.kill();
			deathPic.kill();
			restartPic.kill();
			menuPic.kill();
			continuePic.kill();
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

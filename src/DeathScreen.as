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
	import org.flixel.FlxSound;

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
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Menu_Navigate_Click.wav')] public var SfxMenuClick:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Menu_Navigate_idle.wav')] public var SfxMenuIdle:Class;
		
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
		public var soundChoose:FlxSound = new FlxSound();
		public var sfxIdle:FlxSound = new FlxSound();
		public var sfxIdle2:FlxSound = new FlxSound();
		public var sfxIdle3:FlxSound = new FlxSound();
		
		public function DeathScreen()
		{
			super(true, 0xA4B7A3, true);
			FlxG.mouse.hide();
		}
		
		public override function create():void
		{
			
			soundChoose.loadEmbedded(SfxMenuClick);
			sfxIdle.loadEmbedded(SfxMenuIdle);
			sfxIdle2.loadEmbedded(SfxMenuIdle);
			sfxIdle3.loadEmbedded(SfxMenuIdle);
			sfxIdle.volume = 0.8;
			sfxIdle2.volume = 0.8;
			sfxIdle3.volume = 0.8;
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
			continuePic = new FlxSprite(40,150, ImgContinue);
			continuePic.loadGraphic(ImgContinue, true, false, 300, 62);
			continuePic.scrollFactor = new FlxPoint(0, 0);
			FlxG.state.add(continuePic);
			
			// Texte de restart
			restartPic = new FlxSprite(40, 225, ImgRestart);
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
			//____________SOURIS___________________//
			// Continue la partie
			if (FlxCollision.pixelPerfectCheck(cursor, continuePic)) 
			{
				sfxIdle.play();
				TweenMax.to(continuePic.scale, 0.5, { x : 1.1, y : 1.1, ease:Linear.easeOut});
				if (FlxG.mouse.justPressed())
				{
					sfxIdle.stop();
					soundChoose.play();
					retry();
				}
			}
			else
			{
				sfxIdle.stop();
				TweenMax.to(continuePic.scale, 0.5, { x : 1, y : 1, ease:Linear.easeOut});
			}
			
			// Relance la partie
			if (FlxCollision.pixelPerfectCheck(cursor, restartPic)) 
			{
				sfxIdle2.play();
				TweenMax.to(restartPic.scale, 0.5, { x : 1.1, y : 1.1, ease:Linear.easeOut});
				if (FlxG.mouse.justPressed())
				{
					sfxIdle2.stop();
					soundChoose.play();
					restart();
				}
			}
			else
			{
				sfxIdle2.stop();
				TweenMax.to(restartPic.scale, 0.5, { x : 1, y : 1, ease:Linear.easeOut});
			}
			
			// Renvoie au menu
			if (FlxCollision.pixelPerfectCheck(cursor, menuPic)) 
			{
				sfxIdle3.play();
				TweenMax.to(menuPic.scale, 0.5, { x : 1.1, y : 1.1, ease:Linear.easeOut});
				if (FlxG.mouse.justPressed())
				{
					sfxIdle3.stop();
					soundChoose.play();
					tryQuit();
				}
			}
			else
			{
				sfxIdle3.stop();
				TweenMax.to(menuPic.scale, 0.5, { x : 1, y : 1, ease:Linear.easeOut});
			}
			//____________SOURIS___________________//
			
			//____________CLAVIER___________________//
			
			if (FlxG.keys.justPressed("ENTER"))
			{
				sfxIdle.stop();
				sfxIdle2.stop();
				sfxIdle3.stop();
				soundChoose.play();
				retry();
			}
			if (FlxG.keys.justPressed("BACKSPACE"))
			{
				sfxIdle.stop();
				sfxIdle2.stop();
				sfxIdle3.stop();
				soundChoose.play();
				restart();
			}
			if (FlxG.keys.justPressed("ESCAPE"))
			{
				sfxIdle.stop();
				sfxIdle2.stop();
				sfxIdle3.stop();
				soundChoose.play();
				tryQuit();
			}			
			
			//____________CLAVIER___________________//
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
			cursor.kill();
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

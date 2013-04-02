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
	import com.greensock.*;
	import com.greensock.easing.*;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import flash.media.SoundMixer;
	import org.flixel.FlxSound;

	/**
	 * Pause
	 * @author 
	 */
	public class PauseMenu extends FlxSubState
	{
		public static const QUIT_GAME:String = "PauseMenu::quit_game";
		public static const RESUME_GAME:String = "PauseMenu::resume_game";
		public static const RESTART:String = "PauseMenu::restart_game";
		
		[Embed(source = '../assets/gfx/ui/cursor.png')] 		protected var ImgCursor:Class;
		[Embed(source = '../assets/gfx/ui/cursor_anim.png')]	protected var ImgCursorAnim:Class;
		[Embed(source = '../assets/gfx/ui/pause_pic.png')] 		protected var ImgPause:Class;
		[Embed(source = '../assets/gfx/ui/btn_menu.png')] 		protected var ImgMenu:Class;
		[Embed(source = '../assets/gfx/ui/btn_mute.png')] 		protected var ImgMute:Class;
		[Embed(source = '../assets/gfx/ui/pause-textes.png')] 	protected var ImgPauseTxt:Class;
		[Embed(source = '../assets/gfx/ui/pause-in.png')] 		protected var ImgPauseIn:Class;
		[Embed(source = '../assets/gfx/ui/btn_menu_on.png')] 	protected var ImgMenuOn:Class;
		[Embed(source = '../assets/fonts/phillysansps.otf',	fontFamily = "philly", embedAsCFF = "false")] protected var	Font3:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Menu_Navigate_Click.wav')] public var SfxMenuClick:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Menu_Navigate_idle.wav')] public var SfxMenuIdle:Class;
		
		
		public var text:FlxText;
		public var restartText:FlxText;
		public var resumeText:FlxText;
		public var quitText:FlxText;
		
		public var pauseTxt:FlxSprite;
		public var pauseTxtRep:FlxSprite;
		public var pauseTxtRest:FlxSprite;
		public var pauseTxtMenu:FlxSprite;
		public var pauseIn:FlxSprite;
		public var pausePic:FlxSprite;
		public var btnMute:FlxSprite;
		
		public var cursor:FlxSprite;
		public var resumePic:FlxSprite;
		public var restartPic:FlxSprite;
		public var quitPic:FlxSprite;
		public var soundChoose:FlxSound = new FlxSound();
		public var sfxIdle:FlxSound = new FlxSound();
		public var sfxIdle2:FlxSound = new FlxSound();
		public var sfxIdle3:FlxSound = new FlxSound();
		
		public function PauseMenu()
		{
			super(true, 0x33000000, true);
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
			/*	Bouton de mute */
				pausePic = new FlxSprite(0, 0, ImgPause);
				pausePic.scrollFactor = new FlxPoint(0, 0);
				FlxG.state.add(pausePic);
				/*Bouton de mute */
			
			/*	Bouton de mute 
				btnMute = new FlxSprite(711, 12, ImgMute);
				btnMute.loadGraphic(ImgMute, true, false, 80, 80);
				btnMute.addAnimation("unmuted", [0], 10, true);
				btnMute.addAnimation("muted", [1], 10, true);
				btnMute.play("unmuted");
				btnMute.scrollFactor.x = 0;
				btnMute.scrollFactor.y = 0;
				FlxG.state.add(btnMute);
				Bouton de mute */
			
			/*	Texte de pause */
				pauseIn = new FlxSprite(1400, 450, ImgPauseIn);
				pauseIn.scrollFactor.x = 0;
				pauseIn.scrollFactor.y = 0;
				FlxG.state.add(pauseIn);
			/*	Texte de pause */
			
			/*	Textes de reprendre */
				pauseTxtRep = new FlxSprite(469, 459, ImgPauseTxt);
				pauseTxtRep.loadGraphic(ImgPauseTxt, true, false, 250, 46);
				pauseTxtRep.addAnimation("reprendre", [0], 10, true);
				pauseTxtRep.addAnimation("recommencer", [1], 10, true);
				pauseTxtRep.addAnimation("retourmenu", [1], 10, true);
				pauseTxtRep.play("recommencer");
				pauseTxtRep.scrollFactor.x = 0;
				pauseTxtRep.scrollFactor.y = 0;
				FlxG.state.add(pauseTxtRep);
			/*	Texte de reprendre */
			
			/*	Textes de recommencer */
				pauseTxtRest = new FlxSprite(469, 414, ImgPauseTxt);
				pauseTxtRest.loadGraphic(ImgPauseTxt, true, false, 250, 46);
				pauseTxtRest.addAnimation("reprendre", [0], 10, true);
				pauseTxtRest.addAnimation("recommencer", [1], 10, true);
				pauseTxtRest.addAnimation("retourmenu", [1], 10, true);
				pauseTxtRest.play("reprendre");
				pauseTxtRest.scrollFactor.x = 0;
				pauseTxtRest.scrollFactor.y = 0;
				FlxG.state.add(pauseTxtRest);
			/*	Texte de recommencer */
			
			/*	Textes de retour menu */
				pauseTxtMenu = new FlxSprite(469, 505, ImgPauseTxt);
				pauseTxtMenu.loadGraphic(ImgPauseTxt, true, false, 250, 46);
				pauseTxtMenu.addAnimation("reprendre", [0], 10, true);
				pauseTxtMenu.addAnimation("recommencer", [1], 10, true);
				pauseTxtMenu.addAnimation("retourmenu", [2], 10, true);
				pauseTxtMenu.play("retourmenu");
				pauseTxtMenu.scrollFactor.x = 0;
				pauseTxtMenu.scrollFactor.y = 0;
				FlxG.state.add(pauseTxtMenu);
			/*	Texte de retour menu */
			
			/*	Curseur */
				cursor = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y);
				cursor.loadGraphic(ImgCursorAnim, true, false, 40, 40);
				cursor.addAnimation("souris", [0, 1, 2, 3], 8, true);
				cursor.play("souris");
				FlxG.state.add(cursor);
			/*	Curseur */
			if ((FlxG.state as Play).sound != null) {
				(FlxG.state as Play).sound.volume = 0;
				(FlxG.state as Play).old_volume1 = (FlxG.state as Play).player.vitesse1.volume;
				(FlxG.state as Play).old_volume2 = (FlxG.state as Play).player.vitesse2.volume;
				(FlxG.state as Play).old_volume3 = (FlxG.state as Play).player.vitesse3.volume;
				(FlxG.state as Play).player.vitesse1.volume = 0;
				(FlxG.state as Play).player.vitesse2.volume = 0;
				(FlxG.state as Play).player.vitesse3.volume = 0;
			}
			
		}
		
		// UPDATE DU MENU PAUSE
		public function inPause():void {
			// GESTION CLICS SOURIS
			
				// Relance la partie
				if (FlxCollision.pixelPerfectCheck(cursor, pauseTxtRep)) 
				{
					sfxIdle.play();
					TweenMax.to(pauseTxtRep.scale, 0.5, { x : 1.1, y : 1.1, ease:Linear.easeOut});
					if (FlxG.mouse.justPressed())
					{
						sfxIdle.stop();
						soundChoose.play();
						restart();
					}
				}
				else
				{
					sfxIdle.stop();
					TweenMax.to(pauseTxtRep.scale, 0.5, { x : 1, y : 1, ease:Linear.easeOut});
				}
					
				// Reprend la partie
				if (FlxCollision.pixelPerfectCheck(cursor, pauseTxtRest)) 
				{
					sfxIdle2.play();
					TweenMax.to(pauseTxtRest.scale, 0.5, { x : 1.1, y : 1.1, ease:Linear.easeOut});
					if (FlxG.mouse.justPressed())
					{
						sfxIdle2.stop();
						soundChoose.play();
						resume();
					}
				}
				else
				{
					sfxIdle2.stop();
					TweenMax.to(pauseTxtRest.scale, 0.5, { x : 1, y : 1, ease:Linear.easeOut});
				}
				
				// Retourne au menu
				if (FlxCollision.pixelPerfectCheck(cursor, pauseTxtMenu)) 
				{
					sfxIdle3.play();
					TweenMax.to(pauseTxtMenu.scale, 0.5, { x : 1.1, y : 1.1, ease:Linear.easeOut});
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
					TweenMax.to(pauseTxtMenu.scale, 0.5, { x : 1, y : 1, ease:Linear.easeOut});
				}
				/*
				// Mute le son
				if (FlxCollision.pixelPerfectCheck(cursor, btnMute)) 
				{
					TweenMax.to(btnMute.scale, 0.5, { x : 1.1, y : 1.1, ease:Linear.easeOut } );
					if (FlxG.mouse.justPressed())
					{
					}
				}
				else
				{
					TweenMax.to(btnMute.scale, 0.5, { x : 1, y : 1, ease:Linear.easeOut } );
				}*/
				
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
			pausePic.kill();
			//btnMute.kill();
			pauseTxtRest.kill();
			pauseTxtMenu.kill();
			pauseTxtRep.kill();
			cursor.kill();
			pauseIn.kill();
			
			this.close(RESUME_GAME);
		}
		
		// RETOUR AU MENU
		private function tryQuit():void
		{
			this.close(QUIT_GAME);
		}
	}
}

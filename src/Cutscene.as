package
{
	import flash.utils.Timer;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSave;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import flash.display.MovieClip;
	import flash.media.SoundMixer;
	import flash.events.Event;
	import org.flixel.FlxTimer;
	import com.greensock.*;
	import com.greensock.events.TweenEvent;
	import com.greensock.easing.*;
	import org.flixel.plugin.photonstorm.FlxCollision;
	
	/**
	 * 
	 * @author
	 */
	public class Cutscene extends FlxState
	{		
		[Embed(source = '../assets/gfx/cine/1.png')] 		protected var ImgIntro1:Class;
		[Embed(source = '../assets/gfx/cine/2.png')] 		protected var ImgIntro2:Class;
		[Embed(source = '../assets/gfx/cine/3.png')] 		protected var ImgIntro3:Class;
		[Embed(source = '../assets/gfx/cine/4.png')] 		protected var ImgIntro4:Class;
		[Embed(source = '../assets/gfx/cine/5.png')] 		protected var ImgIntro5:Class;
		[Embed(source = '../assets/gfx/cine/6.png')] 		protected var ImgIntro6:Class;
		
		[Embed(source = '../assets/gfx/cine/A.png')] 		protected var ImgTxtIntro1:Class;
		[Embed(source = '../assets/gfx/cine/B.png')] 		protected var ImgTxtIntro2:Class;
		[Embed(source = '../assets/gfx/cine/C.png')] 		protected var ImgTxtIntro3:Class;
		[Embed(source = '../assets/gfx/cine/D.png')] 		protected var ImgTxtIntro4:Class;
		[Embed(source = '../assets/gfx/cine/E.png')] 		protected var ImgTxtIntro5:Class;
		[Embed(source = '../assets/gfx/cine/F1.png')] 		protected var ImgTxtIntro61:Class;
		[Embed(source = '../assets/gfx/cine/F2.png')] 		protected var ImgTxtIntro62:Class;
		[Embed(source = '../assets/gfx/ui/btn-skip.png')] 	protected var ImgBtnSkip:Class;
		[Embed(source = '../assets/gfx/ui/cursor.png')] 				protected var ImgCursor:Class;
		[Embed(source = '../assets/gfx/ui/cursor_anim.png')] 			protected var ImgCursorAnim:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Music_CutScene.wav')] public var SfxCutscene:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Menu_Navigate_Click.wav')] public var SfxMenuClick:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Menu_Navigate_idle.wav')] public var SfxMenuIdle:Class;

		public var intro1:FlxSprite;
		public var intro2:FlxSprite;
		public var intro3:FlxSprite;
		public var intro4:FlxSprite;
		public var intro5:FlxSprite;
		public var intro6:FlxSprite;
		public var skip:FlxSprite;
		public var cursor:FlxSprite;
		
		public var introTxt1:FlxSprite;
		public var introTxt2:FlxSprite;
		public var introTxt3:FlxSprite;
		public var introTxt4:FlxSprite;
		public var introTxt5:FlxSprite;
		public var introTxt61:FlxSprite;
		public var introTxt62:FlxSprite;
		public var currentframe:int = 1;
		
		public var tw1 : TweenMax;
		public var tw2 : TweenMax;
		public var tw3 : TweenMax;
		public var tw4 : TweenMax;
		public var tw5 : TweenMax;
		
		public var timer:FlxTimer 		= new FlxTimer();
		public var timerTween:FlxTimer	= new FlxTimer();
		
		public var music:FlxSound = new FlxSound();
		public var soundChoose:FlxSound = new FlxSound();
		public var sfxIdle:FlxSound = new FlxSound();
		
		override public function create():void
		{
			music.loadEmbedded(SfxCutscene, true, true);
			soundChoose.loadEmbedded(SfxMenuClick);
			sfxIdle.loadEmbedded(SfxMenuIdle);
			music.play();
			intro1 = new FlxSprite(0, 0, ImgIntro1);
			intro2 = new FlxSprite(0, 0, ImgIntro2);
			intro3 = new FlxSprite(0, 0, ImgIntro3);
			intro4 = new FlxSprite(0, 0, ImgIntro4);
			intro5 = new FlxSprite(0, 0, ImgIntro5);
			intro6 = new FlxSprite(0, 0, ImgIntro6);
			skip = new FlxSprite(0, FlxG.height, ImgBtnSkip);
			skip.y -= skip.frameHeight + 10;
			skip.x += 10;
			
			introTxt1 = new FlxSprite(518, 32, ImgTxtIntro1);
			introTxt2 = new FlxSprite(475, 35, ImgTxtIntro2);
			introTxt3 = new FlxSprite(483, 20, ImgTxtIntro3);
			introTxt4 = new FlxSprite(539, 18, ImgTxtIntro4);
			introTxt5 = new FlxSprite(428, 525, ImgTxtIntro5);
			introTxt61 = new FlxSprite(90, 70, ImgTxtIntro61);
			introTxt62 = new FlxSprite(120, 460, ImgTxtIntro62);
			
			
			tw1 = new TweenMax(introTxt1.scale, 2, { x : 1, y : 1 , ease:Bounce.easeInOut} );
			tw2 = new TweenMax(introTxt2.scale,	2, { x : 1, y : 1 , ease:Bounce.easeInOut} );
			tw3 = new TweenMax(introTxt3.scale, 2, { x : 1, y : 1 , ease:Bounce.easeInOut} );
			tw4 = new TweenMax(introTxt4.scale, 2, { x : 1, y : 1 , ease:Bounce.easeInOut} );
			tw5 = new TweenMax(introTxt5.scale, 2, { x : 1, y : 1 , ease:Bounce.easeInOut} );
			
			
			/*
			introTxt1.alpha = 1;
			introTxt2.alpha = 0;
			introTxt3.alpha = 0;
			introTxt4.alpha = 0;
			introTxt5.alpha = 0;
			introTxt61.alpha = 0;
			introTxt62.alpha = 0;
			*/
			
			/*
			tw1 = new TweenMax(introTxt1, 2, {	alpha : 1, ease:Linear.easeInOut, onComplete : reverseTween1 } );
			tw2 = new TweenMax(introTxt2, 2, {	alpha : 1, ease:Linear.easeInOut, onComplete : reverseTween2 } );
			tw3 = new TweenMax(introTxt3, 2, {	alpha : 1, ease:Linear.easeInOut, onComplete : reverseTween3 } );
			tw4 = new TweenMax(introTxt4, 2, {	alpha : 1, ease:Linear.easeInOut, onComplete : reverseTween4 } );
			tw5 = new TweenMax(introTxt5, 2, {	alpha : 1, ease:Linear.easeInOut, onComplete : reverseTween5 } );
			*/
			
			timer.start(4, 0, switch_page);
			
			FlxG.state.add(intro6);
			FlxG.state.add(introTxt62);
			FlxG.state.add(introTxt61);
			
			FlxG.state.add(intro5);
			FlxG.state.add(introTxt5);
			
			FlxG.state.add(intro4);
			FlxG.state.add(introTxt4);
			
			FlxG.state.add(intro3);
			FlxG.state.add(introTxt3);
			
			FlxG.state.add(intro2);
			FlxG.state.add(introTxt2);
			
			FlxG.state.add(intro1);
			FlxG.state.add(introTxt1);
			FlxG.state.add(skip);
			cursor = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y);
			cursor.loadGraphic(ImgCursorAnim, true, false, 40, 40);
			cursor.addAnimation("souris", [0, 1, 2, 3], 8, true);
			cursor.play("souris");
			FlxG.state.add(cursor)
			FlxG.mouse.hide();
		}
		
		override public function update():void {
			cursor.x = FlxG.mouse.x - cursor.frameWidth/2;
			cursor.y = FlxG.mouse.y - cursor.frameHeight / 2;
			super.update();
			if (FlxG.keys.justReleased("ENTER") || FlxG.keys.justReleased("ESCAPE")) {
				music.stop();
				FlxG.switchState(new UnivChooser);
			}
			if (FlxCollision.pixelPerfectCheck(cursor, skip)) {
				sfxIdle.play();
				if (FlxG.mouse.justPressed()) {
					music.stop();
					sfxIdle.stop();
					soundChoose.play();
					FlxG.switchState(new UnivChooser);
				}
			}
			else {
				sfxIdle.stop();
			}
			if (FlxG.keys.justReleased("SPACE") || FlxG.mouse.justPressed()) {
				switch_page(timer);
			}
		}
		
		public function switch_page(timer:FlxTimer):void {
			
			timer.stop();
			timer.start(4, 0, switch_page);
				switch (currentframe) {
					case 1:
						tw2.play();
						reverseTween1();
						fadeOut(intro1);
						break;
					case 2:
						tw3.play();
						reverseTween2();
						fadeOut(intro2);
						break;
					case 3:
						tw4.play();
						reverseTween3();
						fadeOut(intro3);
						break;
					case 4:
						tw5.play();
						reverseTween4();
						fadeOut(intro4);
						break;
					case 5:
						reverseTween5();
						fadeOut(intro5);
						skip.kill();
						cursor.kill();
						break;
					case 6:
						music.stop();
						FlxG.switchState(new UnivChooser);
						break;
				}
				currentframe++;
				
			function fadeOut(superImg : FlxSprite):void
			{
				TweenMax.to(superImg, 1, { alpha :0, ease:Linear.easeInOut });
			}
		}
		
		private function reverseTween1():void
		{
			tw1 = new TweenMax(introTxt1, 1, { alpha : 0 , ease:Linear.easeInOut } );
			tw1.play();
		}
		
		private function reverseTween2():void
		{
			tw2 = new TweenMax(introTxt2, 1, { alpha : 0 , ease:Linear.easeInOut } );
			tw2.play();
		}
		
		private function reverseTween3():void
		{
			tw3 = new TweenMax(introTxt3, 1, { alpha : 0 , ease:Linear.easeInOut } );
			tw3.play();
		}
		
		private function reverseTween4():void
		{
			tw4 = new TweenMax(introTxt4, 1, { alpha : 0 , ease:Linear.easeInOut } );
			tw4.play();
		}
		
		private function reverseTween5():void
		{
			tw5 = new TweenMax(introTxt5, 1, { alpha : 0 , ease:Linear.easeInOut } );
			tw5.play();
		}
		
	} 
}
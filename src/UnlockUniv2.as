package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxSound;
	
	/**
	 * EndGame
	 * @author ...
	 */
	public class UnlockUniv2 extends FlxState 
	{
		[Embed(source = '../assets/gfx/ui/get-univ2.png')] protected var ImgGG:Class;
		[Embed(source = '../assets/gfx/ui/tile-tubes.png')] 		protected var ImgTubes:Class;
		[Embed(source = '../assets/gfx/ui/cursor.png')] 			protected var ImgCursor:Class;
		[Embed(source = '../assets/gfx/ui/cursor_anim.png')]		protected var ImgCursorAnim:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Menu_Navigate_Click.wav')] public var SfxMenuClick:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Menu_Navigate_idle.wav')] public var SfxMenuIdle:Class;
		public var gg:FlxSprite;
		public var cursor:FlxSprite;
		public var retour:FlxSprite;
		public var soundChoose:FlxSound = new FlxSound();
		public var soundUniverse:FlxSound = new FlxSound();
		public var sfxIdle:FlxSound = new FlxSound();
		
		public function UnlockUniv2() 
		{
			gg = new FlxSprite(0, 0, ImgGG);
			add(gg);
			soundChoose.loadEmbedded(SfxMenuClick);
			sfxIdle.loadEmbedded(SfxMenuIdle);
			sfxIdle.volume = 0.8;
			
			/*	Retour au menu */
				retour = new FlxSprite(50, FlxG.height);
				retour.loadGraphic(ImgTubes, true, false, 194, 50);
				retour.addAnimation("off", [6], 10, true);
				retour.addAnimation("on", [7], 10, true);
				retour.x = 576;
				retour.y -= retour.frameHeight + 10;
				add (retour);
				retour.play("off");
			/*	Retour au menu */	
			// CURSEUR SOURIS
			cursor = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y);
			cursor.loadGraphic(ImgCursorAnim, true, false, 40, 40);
			cursor.addAnimation("souris", [0, 1, 2, 3], 8, true);
			cursor.play("souris");
			add(cursor)
			FlxG.mouse.hide();		
			
		}
	
		override public function update():void {
			cursor.x = FlxG.mouse.x - cursor.frameWidth/2;
			cursor.y = FlxG.mouse.y - cursor.frameHeight/2;
			super.update();
			if (FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) {
				sfxIdle.stop();
				soundChoose.play();
				FlxG.switchState(new UnivChooser);
			}
			if (FlxG.overlap(cursor, retour))
			{
				retour.play("on");
				sfxIdle.play();
				if (FlxG.mouse.justPressed())
				{
					sfxIdle.stop();
					soundChoose.play();
					FlxG.switchState(new UnivChooser());
				}
			}
			else
			{
				sfxIdle.stop();
				retour.play("off");
			}
		}
	}

}
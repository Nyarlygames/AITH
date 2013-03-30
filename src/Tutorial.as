package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxCollision;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Tutorial extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/ui/tuto-space.png')] protected var ImgTuto:Class;
		[Embed(source = '../assets/gfx/ui/tuto-play.png')] protected var ImgPlay:Class;
		[Embed(source = '../assets/gfx/ui/cursor_anim.png')] 			protected var ImgCursorAnim:Class;
		
		public var btnPlay:FlxSprite;
		public var cursor:FlxSprite;
		
		public function Tutorial() 
		{
			super(FlxG.width / 2, FlxG.height / 3, ImgTuto);
			btnPlay = new FlxSprite(FlxG.width / 2, FlxG.height *3 / 4, ImgPlay);
			x -= frameWidth / 2;
			btnPlay.x -= frameWidth / 2;
			FlxG.state.add(btnPlay);
			FlxG.state.add(this);
			// CURSEUR SOURIS
			cursor = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y);
			cursor.loadGraphic(ImgCursorAnim, true, false, 40, 40);
			cursor.addAnimation("souris", [0, 1, 2, 3], 8, true);
			cursor.play("souris");
			FlxG.state.add(cursor);
		}
		
		override public function update():void {
			cursor.x = FlxG.mouse.x - cursor.frameWidth/2;
			cursor.y = FlxG.mouse.y - cursor.frameHeight / 2;
			
			if (FlxCollision.pixelPerfectCheck(cursor, btnPlay) && FlxG.mouse.justPressed()) {
				FlxG.map.loaded = true;
			}
		}
		
	}

}
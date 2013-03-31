package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import com.greensock.*;
	import com.greensock.easing.*;
	
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
			
			this.btnPlay.scale.x = 0.8;
			this.btnPlay.scale.y = 0.8;
			
			this.scale.x = 0.8;
			this.scale.y = 0.8;
			
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
			
			if (FlxCollision.pixelPerfectCheck(cursor, btnPlay)|| (FlxG.keys.pressed("SPACE")) || (FlxG.keys.pressed("ENTER")) )
			{
				TweenMax.to(btnPlay.scale, 0.3, { x:1,y:1 , ease:Linear.easeIn } );
				TweenMax.to(this.scale, 0.3, { x:1,y:1 , ease:Linear.easeIn } );
				if (FlxG.mouse.justPressed() || (FlxG.keys.justPressed("SPACE")) || (FlxG.keys.pressed("ENTER")))
				{
					TweenMax.to(btnPlay, 1, { y : -100, alpha: 0, ease:Expo.easeIn } );
					TweenMax.to(this, 1, {y : -100, alpha: 0, ease:Expo.easeIn } );
					FlxG.map.loaded = true;
					cursor.kill();
				}
			}
			else
			{
				TweenMax.to(btnPlay.scale, 0.3, { x:0.8,y:0.8 , ease:Linear.easeIn } );
				TweenMax.to(this.scale, 0.3, { x:0.8,y:0.8 , ease:Linear.easeIn } );
			}
		}
		
	}

}
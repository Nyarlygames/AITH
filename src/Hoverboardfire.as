package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Hoverboardfire extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/gameplay/anim_flammes_overboard.png')] protected var ImgHoverboard:Class;
		public var target:AlienNormal;
		public var hidden:Boolean = false;
		
		public function Hoverboardfire(alien:AlienNormal) 
		{
			target = alien;
			super(target.x, target.y);
			loadGraphic(ImgHoverboard, true, false, 80, 20);
			addAnimation("idle", [0, 1, 2, 3], 15, true);
			y += target.frameHeight
			x += target.frameWidth/2;
			play("idle");
			FlxG.state.add(this);
		}
		
		override public function update():void {
			if ((target.exists == false) && !hidden) {
				hidden = true;
				kill();
				destroy();
				exists = false;
				visible = false;
			}
		}
	}

}
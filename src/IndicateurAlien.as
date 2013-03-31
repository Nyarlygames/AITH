package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author ...
	 */
	public class IndicateurAlien extends FlxSprite 
	{
		public var target:AlienHorizontal;
		[Embed(source = '../assets/gfx/gameplay/point_d_exclamation.png')] protected var ImgIncomming:Class;
		
		public function IndicateurAlien(alien:AlienHorizontal) 
		{
			target = alien;
			super(800, target.y);
			loadGraphic(ImgIncomming, true, false, 60, 60);
			y -= target.frameHeight + frameHeight + 30;
			x -= frameWidth;
			addAnimation("incomming", [0, 1, 2, 3], 10, true);
			play("incomming");
			scrollFactor = new FlxPoint(0, 0);
			FlxG.state.add(this);
		}
		
		override public function update():void {
			if (target.onScreen(FlxG.camera) || (FlxG.player.dead)) {
				kill();
				if (this != null)
					destroy();
			}
			if (target.x < FlxG.player.x){
				visible = false;
				exists = false;
				if (_curAnim != null)
					_curAnim.destroy();
			}
		}
		
	}

}
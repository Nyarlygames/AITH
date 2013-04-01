package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSound;
	
	/**
	 * ...
	 * @author ...
	 */
	public class IndicateurAlien extends FlxSprite 
	{
		public var target:AlienHorizontal;
		[Embed(source = '../assets/gfx/gameplay/point_d_exclamation.png')] protected var ImgIncomming:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'AlienEnRoute_Stinger.wav')] public var SfxIndic:Class;
		
		public var indic:FlxSound = new FlxSound();
		
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
			indic.loadEmbedded(SfxIndic, true, false);
			indic.play();
		}
		
		override public function update():void {
			if (target.onScreen(FlxG.camera) || (FlxG.player.dead)) {
				if (indic != null) {
					indic.stop();
					indic.kill();
					indic.destroy();
				}
				kill();
				if (this != null)
					destroy();
			}
			if (target.x < FlxG.player.x) {
				if (indic != null) {
					indic.stop();
					indic.kill();
					indic.destroy();
				}
				visible = false;
				exists = false;
				if (_curAnim != null)
					_curAnim.destroy();
			}
		}
		
	}

}
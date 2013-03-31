package  
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.plugin.photonstorm.FlxCollision;
	
	/**
	 * Soucoupe
	 * @author ...
	 */
	public class Soucoupe extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/gameplay/soucoupe.png')] protected var ImgSoucoupe:Class;
		[Embed(source = '../assets/gfx/gameplay/halo_soucoupe_anim_aspiration.png')] protected var ImgHalo:Class;
		//[Embed(source = "../assets/sfx/gameplay/Soucoupe_in.mp3")] 		public var SfxIdle:Class;
		[Embed(source = "../assets/sfx/gameplay/Soucoupe_in.mp3")] 		public var SfxIn:Class;
		
		//public var soundIdle:FlxSound 		= new FlxSound();
		public var soundIn:FlxSound 		= new FlxSound();
		public var gravityup:int = 400;								// GRAVITY MODIFIER
		public var applied:Boolean = false;
		public var halo:FlxSprite;
		
		
		public function Soucoupe(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgSoucoupe);
			soundIn.loadEmbedded(SfxIn);
			halo = new FlxSprite(xpos + 20, ypos + frameHeight);
			halo.loadGraphic(ImgHalo, true, false, 80, 260);
			halo.addAnimation("aspire", [0, 1, 2, 3], 10, true);
			halo.addAnimation("default", [0], 10, true);
			FlxG.state.add(halo);
			immovable = true;
		}
	
		override public function update():void 
		{
			if (FlxG.player != null) 
			{
				FlxG.overlap(FlxG.player, halo, aspire);
				FlxG.overlap(FlxG.player, this, soucoupes);
			}
		}
		
		// Soucoupes
		public function soucoupes(obj1:FlxSprite, obj2:FlxSprite):void 
		{
			if (FlxCollision.pixelPerfectCheck(obj1, obj2)) {
				FlxG.player.die_motherfucker(0);
			}
		}
		
		public function aspire(obj1:FlxObject, obj2:FlxObject):void 
		{
			halo.play("aspire");
			FlxG.player.velocity.y -= gravityup * FlxG.elapsed;
		}
	}

}
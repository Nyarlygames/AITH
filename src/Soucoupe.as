package  
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	
	/**
	 * Soucoupe
	 * @author ...
	 */
	public class Soucoupe extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/gameplay/soucoupe.png')] protected var ImgSoucoupe:Class;
		[Embed(source = '../assets/gfx/gameplay/halo_soucoupe.png')] protected var ImgHalo:Class;
		//[Embed(source = "../assets/sfx/gameplay/Soucoupe_in.mp3")] 		public var SfxIdle:Class;
		[Embed(source = "../assets/sfx/gameplay/Soucoupe_in.mp3")] 		public var SfxIn:Class;
		
		//public var soundIdle:FlxSound 		= new FlxSound();
		public var soundIn:FlxSound 		= new FlxSound();
		public var gravityup:int = 300;								// GRAVITY MODIFIER
		public var applied:Boolean = false;
		public var halo:FlxSprite;
		
		
		public function Soucoupe(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgSoucoupe);
			soundIn.loadEmbedded(SfxIn);
			halo = new FlxSprite(xpos + 20, ypos + frameHeight, ImgHalo);
			FlxG.state.add(halo);
			immovable = true;
		}
	
		override public function update():void {
			if (FlxG.player != null)
				if (!FlxG.overlap(FlxG.player, halo, getup) && (applied == true)) 
				{
					applied = false;
				}

		}
		
		public function getup(obj1:FlxObject, obj2:FlxObject):void {
			// HORIZONTAUX _
			if (applied == false) {
				soundIn.play();
				FlxG.player.velocity.y = -gravityup;
				/* TODO 
				 * Gravityup en fonction de la position du joueur comparé à la soucoupe
				 */
				applied = true;
			}
		}
	}

}
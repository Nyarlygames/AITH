package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxSound;
	
	/**
	 * Tube vert
	 * @author ...
	 */
	public class TubeVert extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/gameplay/picktube-tiles.png')] protected var ImgTubes:Class;
		[Embed(source = "../assets/sfx/gameplay/PetitTube_Pick.mp3")] public var SfxPetitTube:Class;
		[Embed(source = "../assets/sfx/gameplay/GrosTube_Pick.mp3")] public var SfxGrosTube:Class;
		
		public var loot:int = 0;
		public var soundPetitTube:FlxSound = new FlxSound();
		public var soundGrosTube:FlxSound = new FlxSound();
		public var type:int;
		
		public function TubeVert(xpos:int, ypos:int, point:int, id:int) 
		{
			super(xpos, ypos);
			type = id;
			soundPetitTube.loadEmbedded(SfxPetitTube);
			soundGrosTube.loadEmbedded(SfxGrosTube);
			soundGrosTube.volume = 1;
			soundPetitTube.volume = 1;
			
			this.loadGraphic(ImgTubes, true, false, 60, 60);
			this.addAnimation("petit",  [0,1,2,3], 10, true);
			this.addAnimation("gros",  [4,5,6,7], 10, true);
			switch (id) {
				case 0:
					play("petit");
					break;
				case 1:
					play("gros");
					break;
			}
			loot = point;
		}
		
	}

}
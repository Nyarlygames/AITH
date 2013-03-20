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
		
		[Embed(source = '../assets/gfx/gameplay/petit_tube.png')] protected var ImgTube:Class;
		[Embed(source = '../assets/gfx/gameplay/gros_tube.png')] protected var ImgGrosTube:Class;
		[Embed(source = "../assets/sfx/gameplay/PetitTube_Pick.mp3")] public var SfxPetitTube:Class;
		[Embed(source = "../assets/sfx/gameplay/GrosTube_Pick.mp3")] public var SfxGrosTube:Class;
		
		public var loot:int = 0;
		public var soundPetitTube:FlxSound = new FlxSound();
		public var soundGrosTube:FlxSound = new FlxSound();
		
		public function TubeVert(xpos:int, ypos:int, point:int, id:int) 
		{
			super(xpos, ypos);
			soundPetitTube.loadEmbedded(SfxPetitTube);
			soundGrosTube.loadEmbedded(SfxGrosTube);
			switch (id) {
				case 0:
					loadGraphic(ImgTube);
					break;
				case 1:
					loadGraphic(ImgGrosTube);
					break;
			}
			loot = point;
		}
		
	}

}
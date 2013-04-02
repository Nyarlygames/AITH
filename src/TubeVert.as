package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxSound;
	import org.flixel.FlxG;
	
	/**
	 * Tube vert
	 * @author ...
	 */
	public class TubeVert extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/gameplay/picktube-tiles.png')] protected var ImgTubes:Class;
		[Embed(source = "../assets/sfx/gameplay/PetitTube_Pick.mp3")] public var SfxPetitTube:Class;
		[Embed(source = "../assets/sfx/gameplay/GrosTube_Pick.mp3")] public var SfxGrosTube:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Petit_Tube1.wav')] public var SfxPetitTube1:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Petit_Tube2.wav')] public var SfxPetitTube2:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Petit_Tube3.wav')] public var SfxPetitTube3:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Gros_Tube1.wav')] public var SfxGrosTube1:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Gros_tube2.wav')] public var SfxGrosTube2:Class;
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
		
		public function tubesound(loot:int):void {
			if (loot == 1) {
				var chance:int = Math.ceil(Math.random() * 3);
				switch(chance) {
					case 1:
						FlxG.play(SfxPetitTube1, 1, false, true);
						break;
					case 2:
						FlxG.play(SfxPetitTube2, 1, false, true);
						break;
					case 3:
						FlxG.play(SfxPetitTube3, 1, false, true);
						break;
				}
			}
			else {
				var chance2:int = Math.ceil(Math.random() * 2);
				switch(chance2) {
					case 1:
						FlxG.play(SfxGrosTube1, 0.7, false, true);
						break;
					case 2:
						FlxG.play(SfxGrosTube2, 0.7, false, true);
						break;
				}
			}
		}
	}

}
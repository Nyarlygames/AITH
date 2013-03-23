package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
	
	/**
	 * Checkpoints
	 * @author ...
	 */
	public class Checkpoints extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/gameplay/checkpoint_tile.png')]			 protected var ImgCheck:Class;
		[Embed(source = "../assets/sfx/gameplay/CheckPoint_Activation.mp3")] 	public var SfxActivate:Class;
		[Embed(source = "../assets/sfx/gameplay/CheckPoint_Revive.mp3")] 		public var SfxRevives:Class;
		
		static var soundActivate:FlxSound 		= new FlxSound();
		public var soundRevives:FlxSound 		= new FlxSound();
		
		public var validated:Boolean = false;
		
		public function Checkpoints(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgCheck);
			soundActivate.loadEmbedded(SfxActivate);
			soundRevives.loadEmbedded(SfxRevives);
			immovable = true;
			y -= frameHeight /2 ;
			this.loadGraphic(ImgCheck, true, false, 80, 200);
			this.addAnimation("default",  [0], 30, true);
			this.addAnimation("validation",  [0,1,2,3], 30, true);
			this.addAnimation("valide",  [3], 30, true);
			play("default");
		}
		
		override public function update():void {
			if ((FlxG.player != null) && (FlxG.player.x >= x) && (validated == false)) {
				FlxG.player.checkpoint.x = x; 
				FlxG.player.checkpoint.y = y;
				play("val");
				validated = true;
				soundActivate.play();
			}}
	}

}
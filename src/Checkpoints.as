package  
{
	import flash.external.ExternalInterface;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
	import org.flixel.FlxText;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	/**
	 * Checkpoints
	 * @author ...
	 */
	public class Checkpoints extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/gameplay/checkpoint_tile.png')]			 protected var ImgCheck:Class;
		[Embed(source = "../assets/sfx/gameplay/CheckPoint_Activation.mp3")] 	public var SfxActivate:Class;
		[Embed(source = "../assets/sfx/gameplay/CheckPoint_Revive.mp3")] 		public var SfxRevives:Class;
		[Embed(source = '../assets/fonts/phillysansps.otf',	fontFamily = "philly", embedAsCFF = "false")] protected var	Font:Class;
		
		public var soundActivate:FlxSound 		= new FlxSound();
		public var soundRevives:FlxSound 		= new FlxSound();
		
		public var validated:Boolean = false;
		
		public function Checkpoints(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgCheck);
			soundActivate.loadEmbedded(SfxActivate);
			soundRevives.loadEmbedded(SfxRevives);
			immovable = true;
			offset.x = -200;
			
			this.loadGraphic(ImgCheck, true, false, 80, 200);
			this.addAnimation("default",  [0], 30, true);
			this.addAnimation("validation",  [0,1,2,3], 30, true);
			this.addAnimation("valide",  [3], 30, true);
			play("default");
		}
		
		override public function update():void {
			if ((FlxG.player != null) && (FlxG.player.x >= x) && (validated == false)) 
			{
				var txtCP : FlxText = new FlxText( FlxG.player.x, FlxG.player.y, 500, "Checkpoint !", true);
				txtCP.scrollFactor.x = 0;
				txtCP.setFormat("philly", 30, 0x00000000,null, 0xFFEA0000);
				FlxG.state.add(txtCP);
				//TweenMax.to(txtCP, 2, {alpha : 0, ease:Linear.easeIn } );
				
				FlxG.player.checkpoint.x = x; 
				FlxG.player.checkpoint.y = y + frameHeight - FlxG.player.frameHeight;
				FlxG.player.checkscore = 0;
				play("valide");
				validated = true;
				soundActivate.play();
			}	
		}
	}

}
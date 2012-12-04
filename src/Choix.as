package  
{
	import flash.geom.Point;
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	/**
	 * Liste des choix
	 * @author ...
	 */
	public class Choix extends FlxGroup 
	{
		
		 [Embed(source = '../assets/gfx/choix.png')] public var ImgChoix:Class;
		 [Embed(source = '../assets/gfx/cadrechoix.png')] public var ImgCadrechoix:Class;
		 [Embed(source = '../assets/gfx/choix2.png')] public var ImgChoix2:Class;
		 [Embed(source = '../assets/gfx/choix3.png')] public var ImgChoix3:Class;
		 [Embed(source = '../assets/gfx/choix4.png')] public var ImgChoix4:Class;
		 public var choice:FlxSprite;
		 public var groupimg:FlxGroup = new FlxGroup();
		 
		public function Choix(droite:FlxSprite) 
		{
			choice = new FlxSprite(FlxG.width / 2, 0, ImgCadrechoix);
			/*
			for (var i:int = 0; i < 4; i++) {
				switch(i){
					case 0:
						choice = new FlxSprite(FlxG.width / 2, 0, ImgChoix);
						break;
					case 1:
						choice = new FlxSprite(FlxG.width / 2, 0, ImgChoix2);
						break;
					case 2:
						choice = new FlxSprite(FlxG.width / 2, 0, ImgChoix3);
						break;
					case 3:
						choice = new FlxSprite(FlxG.width / 2, 0, ImgChoix4);
						break;
				}
				choice.y = i * (60 + 10);
				add(choice);
				
			}*/
			
		}
		
	}

}
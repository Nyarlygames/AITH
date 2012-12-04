package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * écran droit
	 * @author ...
	 */
	
	public class Droite extends FlxSprite
	{
		 [Embed(source = '../assets/gfx/jaune.png')] public var ImgJaune:Class;
		 [Embed(source = '../assets/gfx/rouge.png')] public var ImgRouge:Class;
		 [Embed(source = '../assets/gfx/bleue.png')] public var ImgBleue:Class;
		 [Embed(source = '../assets/gfx/verte.png')] public var ImgVerte:Class;
		 [Embed(source = '../assets/gfx/cadredroite.png')] public var ImgBgdroite:Class;
		 public var cursor:Cursor
		 public var hasMoved:Boolean = false;
		 public var bg:FlxSprite = new FlxSprite(FlxG.width / 2, 0, ImgBgdroite);
		 
		public function Droite (cur:Cursor)
		{
			super(FlxG.width / 2, FlxG.height, ImgJaune);
			y -= frameHeight;
			cursor = cur;
			immovable = true;
			velocity.x = 0;
			velocity.y = 0;
		}
		
		override public function update():void {
			if (hasMoved == false) {
				switch (cursor.pos) {
					case 0 :
						loadGraphic(ImgRouge);
						y = FlxG.height - frameHeight;
						break;
					case 1 :
						loadGraphic(ImgJaune);
						y = FlxG.height - frameHeight;
						break;
					case 2 : 
						loadGraphic(ImgBleue);
						y = FlxG.height - frameHeight;
						break;
					case 3 :
						loadGraphic(ImgVerte);
						y = FlxG.height - frameHeight;
						break;
				}
			}
			
			if (int (x) == 0) {
				velocity.x = 0;
				velocity.y = 0;
				hasMoved = true;
			}
		}
		public function getImg(pos:int):Class {
				switch (cursor.pos) {
					case 0 :
						return(ImgRouge);
						break;
					case 1 :
						return(ImgJaune);
						break;
					case 2 : 
						return(ImgBleue);
						break;
					case 3 :
						return(ImgVerte);
						break;
				}
				return(ImgJaune);
		}
		
	}

}
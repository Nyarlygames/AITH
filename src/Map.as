package  
{
	import org.flixel.FlxGroup;
	
	/**
	 * Maps
	 * @author ...
	 */
	public class Map 
	{
		
		public var ens:FlxGroup = new FlxGroup();
		public var speed:int = 0;
		public var id:int = 0;
		public var bg:String = new String("");
		
		// Crée le groupe d'ennemis à partir d'un fichier
		
		/* FORMAT :
			 * ID STAGE
			 * INITSPEED
			 * BACKGROUND PICTURE
			 * TYPEENNEMIS X Y NBTUBE
			 * BOSS
			 * ...
		 * */
		public function Map(map:Class) 
		{
			var fileContent:String = new map();
			var lignes:Array = fileContent.split('\n');
			var en:Array;
			if (lignes != null) {
				id = lignes[0];
				speed = lignes[1];
				bg = lignes[2];
			}
			for (var i:int = 3;  i < lignes.length; i++) {
				if (lignes[i] != null)
					en = lignes[i].split('/');
					if (en != null) {
						switch(en[0]){
							case "Alien":
								ens.add(new Alien(en[1], en[2], en[3], speed));
							break;
							case "Tube":
								ens.add(new TubeVert(en[1], en[2], speed));
							break;
							case "Jump":
								ens.add(new Jump(en[1], en[2], en[3], speed));
							break;
							default:
								ens.add(new Alien(en[1], en[2], en[3], speed));
						}
					}
			}
		}
		
	}

}
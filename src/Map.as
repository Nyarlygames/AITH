package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import net.pixelpracht.tmx.TmxMap;
	import net.pixelpracht.tmx.TmxObject;
	import net.pixelpracht.tmx.TmxObjectGroup;
	import net.pixelpracht.tmx.TmxPropertySet;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	
	/**
	 * Maps
	 * @author ...
	 */
	public class Map 
	{
		
		public var ens:FlxGroup = new FlxGroup();
		public var item:FlxGroup = new FlxGroup();
		public var destructible:FlxGroup = new FlxGroup();
		public var speed:int = 0;
		public var id:int = 0;
		public var bg:String = new String("");
		public var links:Array = new Array();
        public var tile:FlxTilemapExt = new FlxTilemapExt();
		public var tilemap:FlxTilemap = new FlxTilemap();
        [Embed(source = '../assets/gfx/aith_tiles.png')] public var MapTiles:Class;
        [Embed(source = '../assets/gfx/des_ground.png')] public var ImgDesSol:Class;
		
		public function Map(map:Class) 
		{
			
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onTmxLoaded);
			loader.load(new	URLRequest('../maps/map3bis.tmx'));
			var fileContent:String = new map();
			var lignes:Array = fileContent.split('\n'); 
			var en:Array;
			if (lignes != null) {
				id = lignes[0];
				speed = lignes[1];
				bg = lignes[2];
			}
		}
		
		public function onTmxLoaded(e:Event):void {
			
			var xml:XML = new XML(e.target.data);
			var tmx:TmxMap = new TmxMap(xml);

			var csv:String = tmx.getLayer('Tile').toCsv(tmx.getTileSet('aith_tiles'));
			tile.loadMap(csv, MapTiles, 40, 40);
			FlxG.state.add(tile);
			
			var group:TmxObjectGroup = tmx.getObjectGroup('Objs');
			for each(var object:TmxObject in group.objects) {
				if (object.custom != null) {
					//object.custom["test"];			OBJ PROPRETY
				}
				switch(object.name) {
					case "Tube":
						item.add (new TubeVert(object.x, object.y));
						break;
					case "Alien":
						ens.add (new Alien(object.x, object.y, 100));
						break;
					case "Piques":
						item.add (new TubeVert(object.x, object.y));
						break;
					case "Des_sol":
						var ground:FlxSprite = new FlxSprite(object.x, object.y, ImgDesSol);
						links.push(object.custom["p"]);
						destructible.add(ground);
						break;
				}
			}
			FlxG.state.add(item);
			FlxG.state.add(destructible);
			FlxG.state.add(ens);
		}
	}

}
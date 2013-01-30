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
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	
	/**
	 * Maps
	 * @author ...
	 */
	public class Map 
	{
		
		public var ens:FlxGroup = new FlxGroup();
		public var obs:FlxGroup = new FlxGroup();
		public var speed:int = 0;
		public var id:int = 0;
		public var bg:String = new String("");
        public var tile:FlxTilemapExt;
		public var tilemap:FlxTilemap = new FlxTilemap();
        [Embed(source = 'slopeTiles.png')] public var MapTiles:Class;
        [Embed(source = 'slopeTest.csv', mimeType = "application/octet-stream")] public var MapData:Class;
		
		public function Map(map:Class) 
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onTmxLoaded);
			loader.load(new	URLRequest('../maps/map1.tmx'));
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
			
			
			var group:TmxObjectGroup = tmx.getObjectGroup('Objs');
			for each(var object:TmxObject in group.objects) {
				switch(object.type) {
					case "Tube":
						obs.add (new TubeVert(object.x, object.y));
						break;
					case "Alien":
						ens.add (new Alien(object.x, object.y, 100));
						break;
				}
			}
			FlxG.state.add(obs);
			FlxG.state.add(ens);
		}
	}

}
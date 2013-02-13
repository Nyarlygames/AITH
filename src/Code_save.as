
// ROTATION JIMI SUR TREMPLIN (manque le retour à la normale)
	if (mytile == FlxTilemapExt.SLOPE_FLOOR_LEFT && player.angle >= -45) {
		player.angularVelocity = -50;

	}
	else if (mytile == FlxTilemapExt.SLOPE_FLOOR_RIGHT) {
		player.angularVelocity = 50;
	}
	else {
		if (player.angle > 0) {
			//player.angle = 0;
			player.angularVelocity = 10;
			FlxG.log("test");
		}
	}
	

// CHANGE LE TYPE D'UNE TILE (mauvais calcul de la tile)
	(obj2 as FlxTilemap).setTileByIndex( Math.round((player.y + 80) / 40) * 40 +Math.floor((player.x + 60) / 40) * 40, 0, true);
	
	
// CHECK SI LE JOUEUR QUITTE UN TREMPLIN (je sais plus si ca marche ou si ca foire)
	/*if (mytile == 0) {
		if (player.isTouching(0x1000)) {
			trace("JUMP");
			player.velocity.y = -(player.velocity.x + player.velocity.y) / 2;
			player.jumping == true;
			//player.velocity.y = player.cur_velocity.y;
			//player.velocity.x = player.cur_velocity.x;
		}
		//player.velocity.y = -(player.velocity.x);
		//player.jumping == true;
	}*/
	

// TEST DESTRUCTION SOL DESTRUCTIBLE (version par petits bouts)
	/*for each(var object:TmxObject in map.destructible.members) {
				if (object.custom["plaque"] == (obj2 as TmxObject).custom["plaque"]) {
					(object as FlxObject).kill();
				}
			}
	for (var i:int = 0; i < map.links.length; i++) {
		if (map.links[i] == "1")
			map.destructible.members[i].kill();
	}*/
	
	
 // ACTIVE PLUGIN FLXSCROLLZONE
	/*if (FlxG.getPlugin(FlxScrollZone) == null)
	{
		FlxG.addPlugin(new FlxScrollZone);
	}*/
	
	
// BOUCLE SUR FLXGROUP
	/*for each (var item:FlxSprite in map.ens.members) {
		if (item != null){
			item.y = background.sol.y - item.frameHeight;
		}
	}*/
	
	
// SUR DE RETOURNER AU MENU ? (PauseMenu)
	/*this.setSubState(new Dialog("Are you sure you want to quit?", yes, no));
	this.quit(null, yes);
	
	private const yes:String = "Yes";
	private const no:String = "No";
	
	private function quit(state:FlxSubState, result:String):void
	{
		if (result == yes)
		{
			this.close(QUIT_GAME);
		}
	}*/
	
	
// PROPRIETE OBJET (score des tubes vert?)
	/*if (object.custom != null) {
		//object.custom["test"];
	}*/
	
// SON ARRIERE PLAN
	/*sound = new FlxSound();
	sound.loadStream("../assets/sfx/musiques/Shinshuu_Plains_I.mp3", true, true);
	sound.play();*/
	
// PROPRIETE ALIENS POUR COLLISIONS AVEC JOUEUR
	/*elasticity = 1;
	immovable = true;*/
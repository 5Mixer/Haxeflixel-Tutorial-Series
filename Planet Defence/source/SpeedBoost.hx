package ;

import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.util.FlxAngle;

class SpeedBoost extends FlxSprite {
	var angleFromPlanet:Int;
	var planet:Planet;

	public function new (_angle,_planet){
		super(0,0);

		angleFromPlanet = _angle;
		planet = _planet;

		//makeGraphic(16,16,FlxColor.GREEN);
		loadGraphic("assets/images/BoostSpeed.png",false,8,8);

		new FlxTimer(5,function (timer){
			kill();
		});
	}

	public function onTouchPlayer (player){
		player.speed = 80;
	}

	override public function update () {
		super.update();

		calculatePosition();
	}

	function calculatePosition () {
		//This functions works out our sprites X and Y position, based on an Angle, and a Planet.
		//It also rotates the sprite to face the planet
		x = Math.cos((angleFromPlanet-90) *( Math.PI / 180)) * (planet.planetRadius+4) + planet.getMidpoint().x-4;
		y = Math.sin((angleFromPlanet-90) * (Math.PI / 180)) * (planet.planetRadius+4) + planet.getMidpoint().y-4;

		angle = FlxAngle.angleBetween(planet,this,true)+90;
	}

}
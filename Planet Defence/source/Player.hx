package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxAngle;
import flixel.FlxG;
import Planet;

class Player extends FlxSprite {

	var angleFromPlanet:Float;
	var planet:Planet;

	public function new (_angle,_planet){
		super(0,0);

		angleFromPlanet = _angle;
		planet = _planet;

		makeGraphic(16,16,FlxColor.GREEN);

		FlxG.camera.follow(this);
	}

	override public function update () {
		super.update();

		angleFromPlanet+= FlxG.elapsed;

		calculatePosition();
	}

	function calculatePosition () {
		//This functions works out our sprites X and Y position, based on an Angle, and a Planet.
		//It also rotates the sprite to face the planet
		x = Math.cos(angleFromPlanet-90 * Math.PI / 180) * (planet.planetRadius - 4 + 8) + planet.getMidpoint().x - 8;
		y = Math.sin(angleFromPlanet-90 * Math.PI / 180) * (planet.planetRadius - 4  + 8) + planet.getMidpoint().y - 8;

		angle = FlxAngle.angleBetween(planet,this,true)+90;
	}
}
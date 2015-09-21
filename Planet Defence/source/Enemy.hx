package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxAngle;
import flixel.FlxG;
import flixel.FlxObject;
import Planet;

class Enemy extends FlxSprite {

	var angleFromPlanet:Float;
	var planet:Planet;
	var speed:Float = 18;
	var distanceFromGround:Float = 150;

	public function new (_angle,_planet){
		super(0,0);

		angleFromPlanet = _angle;
		planet = _planet;

		//makeGraphic(16,16,FlxColor.GREEN);
		loadGraphic("assets/images/Enemy.png",true,16,16);

		animation.add("Idle",[0,1,2,3],10,false);
	}

	override public function update () {
		super.update();

		distanceFromGround -= FlxG.elapsed * speed;

		if (distanceFromGround < 1){
			kill();
		}

		calculatePosition();
	}

	function calculatePosition () {
		//This functions works out our sprites X and Y position, based on an Angle, and a Planet.
		//It also rotates the sprite to face the planet
		x = Math.cos((angleFromPlanet-90) *( Math.PI / 180)) * (planet.planetRadius + distanceFromGround + 8) + planet.getMidpoint().x - 8;
		y = Math.sin((angleFromPlanet-90) * (Math.PI / 180)) * (planet.planetRadius + distanceFromGround + 8) + planet.getMidpoint().y - 8;

		angle = FlxAngle.angleBetween(planet,this,true)+90;
	}
}
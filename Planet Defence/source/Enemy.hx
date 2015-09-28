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
	var onTouchGround:Void->Void;

	public function new (_angle,_planet,onTouchMethod){
		super(0,0);

		onTouchGround = onTouchMethod;

		angleFromPlanet = _angle;
		planet = _planet;

		//makeGraphic(16,16,FlxColor.GREEN);
		loadGraphic("assets/images/Enemy.png",true,16,16);

		animation.add("Idle",[0,1,2,3],10,false);
	}

	override public function update () {
		super.update();

		animation.play("Idle");

		distanceFromGround -= FlxG.elapsed * speed;

		if (distanceFromGround < 1){
			onTouchGround();
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
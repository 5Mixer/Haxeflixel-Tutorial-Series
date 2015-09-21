package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxAngle;
import flixel.FlxG;
import flixel.FlxObject;
import Planet;

class Player extends FlxSprite {

	var angleFromPlanet:Float;
	var planet:Planet;
	var speed:Float = 40;

	public function new (_angle,_planet){
		super(0,0);

		setFacingFlip(FlxObject.RIGHT,false,false);
		setFacingFlip(FlxObject.LEFT,true,false);

		angleFromPlanet = _angle;
		planet = _planet;

		//makeGraphic(16,16,FlxColor.GREEN);
		loadGraphic("assets/images/Player.png",true,16,16);

		animation.add("Idle",[0,1],2,false);
		animation.add("Walk",[6,7,8,9],15,false);


		FlxG.camera.follow(this);
	}

	override public function update () {
		super.update();

		var leftKey = FlxG.keys.anyPressed(["LEFT","A"]);
		var rightKey = FlxG.keys.anyPressed(["RIGHT","D"]);
		var shootKey = FlxG.keys.anyPressed(["UP","W","SPACE"]);

		if (leftKey){
			angleFromPlanet -= FlxG.elapsed * speed;
			animation.play("Walk");
			facing = FlxObject.LEFT;
		}else if (rightKey){
			angleFromPlanet+= FlxG.elapsed * speed;
			animation.play("Walk");
			facing = FlxObject.RIGHT;
		}else{
			animation.play("Idle");
		}

		if (shootKey){
			//The player should shoot
		}
		

		calculatePosition();
	}

	function calculatePosition () {
		//This functions works out our sprites X and Y position, based on an Angle, and a Planet.
		//It also rotates the sprite to face the planet
		x = Math.cos((angleFromPlanet-90) *( Math.PI / 180)) * (planet.planetRadius - 4 + 8) + planet.getMidpoint().x - 8;
		y = Math.sin((angleFromPlanet-90) * (Math.PI / 180)) * (planet.planetRadius - 4  + 8) + planet.getMidpoint().y - 8;

		angle = FlxAngle.angleBetween(planet,this,true)+90;
	}
}
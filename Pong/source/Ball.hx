package ;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;

class Ball extends FlxSprite {
	public function new (X,Y){
		super(X,Y);

		makeGraphic(10,10,FlxColor.WHITE);

		velocity.x = 150;

		elasticity = 1;
	}

	override public function update (){
		super.update();

		if (y < 0){
			velocity.y *= -1;
		}
		if (y+height > FlxG.height){
			velocity.y *= -1;
		}
	}
}
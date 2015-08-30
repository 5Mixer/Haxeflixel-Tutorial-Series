package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Paddle extends FlxSprite {

	public function new (X,Y) {
		super(X,Y);

		makeGraphic(10,100,FlxColor.WHITE);
	}

	override public function update () {

	}

}
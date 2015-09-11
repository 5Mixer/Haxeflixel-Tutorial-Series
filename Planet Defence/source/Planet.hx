package ;

import flixel.FlxSprite;

class Planet extends FlxSprite {
	public function new (X,Y){
		super(X,Y);

		loadGraphic("assets/images/Planet.png");
	}
}
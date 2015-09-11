package ;

import flixel.FlxSprite;

class Planet extends FlxSprite {

	public var planetRadius = 100;

	public function new (X,Y){
		super(X,Y);

		loadGraphic("assets/images/Planet.png");
	}
}
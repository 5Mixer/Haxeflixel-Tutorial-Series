package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;

class Paddle extends FlxSprite {

	var upKey:String;
	var downKey:String;

	public function new (X,Y,_upKey:String,_downKey:String) {
		super(X,Y);

		upKey = _upKey;
		downKey = _downKey;

		makeGraphic(10,100,FlxColor.WHITE);
	}

	override public function update () {
		super.update();

		if (FlxG.keys.anyPressed([upKey])){
			y -= 1;
		}else if (FlxG.keys.anyPressed([downKey])){
			y += 1;
		}
	}

}
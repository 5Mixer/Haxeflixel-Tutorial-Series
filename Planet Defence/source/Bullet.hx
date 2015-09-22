package ;

import flixel.FlxSprite;
import flixel.util.FlxTimer;

class Bullet extends FlxSprite {

	var speed:Float = 50;

	public function new (_angle,X,Y){
		super(X,Y);

		loadGraphic("assets/images/Bullet.png",false);

		angle = _angle;

		var vx = Math.cos((angle-90) * (Math.PI / 180)) * speed;
		var vy = Math.sin((angle-90) * (Math.PI / 180)) * speed;

		velocity.set(vx,vy);

		new FlxTimer (5, function (timer) {
			kill();
		});

	}
}
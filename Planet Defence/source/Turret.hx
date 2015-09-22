package ;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxG;

class Turret extends FlxSprite {
	var reloadTimer:Float = 0;
	var bulletGroup:FlxGroup;
	var spread:Int = 30;

	public function new(_angle,X,Y,_bulletGroup){
		super(X,Y);

		angle = _angle;

		bulletGroup = _bulletGroup;

		loadGraphic("assets/images/Turret.png",false);
	}

	override public function update (){
		super.update();

		reloadTimer += FlxG.elapsed;

		if (reloadTimer > 2){
			reloadTimer = 0;

			bulletGroup.add(new Bullet(angle,getMidpoint().x,getMidpoint().y));
			bulletGroup.add(new Bullet(angle-spread,getMidpoint().x,getMidpoint().y));
			bulletGroup.add(new Bullet(angle+spread,getMidpoint().x,getMidpoint().y));
		}
	}
}
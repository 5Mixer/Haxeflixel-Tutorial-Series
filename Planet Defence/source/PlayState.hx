package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var planet:Planet;
	var player:Player;

	var reloadTimer:Float = 0;

	var enemyGroup:FlxGroup = new FlxGroup();
	var bulletGroup:FlxGroup = new FlxGroup();
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		add(bulletGroup);

		planet = new Planet(FlxG.width/2,FlxG.height/2);
		add(planet);

		add(enemyGroup);

		player = new Player(0,planet);
		add(player);

		new FlxTimer(4,createEnemy,0);

		FlxG.worldBounds.setSize(1000,1000);

	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();

		reloadTimer += FlxG.elapsed;

		var shootKey = FlxG.keys.anyPressed(["UP","W","SPACE"]);

		if (shootKey){
			//The player should shoot
			if (reloadTimer > 0.2){
				reloadTimer = 0;
				bulletGroup.add(new Bullet(player.angle,player.getMidpoint().x,player.getMidpoint().y));
			}			
		}

		FlxG.collide(enemyGroup,bulletGroup, function (e,b){
			e.kill();
			b.kill();
		});
	}

	function createEnemy (timer){
		enemyGroup.add(new Enemy(FlxRandom.intRanged(1,360),planet));
	}
}
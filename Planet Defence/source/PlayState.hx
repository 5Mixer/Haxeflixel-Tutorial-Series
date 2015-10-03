package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;
import flixel.util.FlxSpriteUtil;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var planet:Planet;
	var player:Player;

	var reloadTimer:Float = 0;

	var enemyGroup:FlxGroup = new FlxGroup();
	var turretGroup:FlxGroup = new FlxGroup();
	var bulletGroup:FlxGroup = new FlxGroup();

	var speedBoosts:FlxGroup = new FlxGroup();

	var moneyText:FlxText;
	var healthText:FlxText;
	var turretButton:FlxButton;

	var lives:Int = 3;
	var money:Int = 0;
	var turretCost:Int = 15;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		add(bulletGroup);

		add(turretGroup);

		planet = new Planet(FlxG.width/2,FlxG.height/2);
		add(planet);

		add(enemyGroup);

		player = new Player(0,planet);
		add(player);

		add(speedBoosts);

		//UI elements
		moneyText = new FlxText(0,0,FlxG.width,"$0");
		moneyText.setFormat(null,16,FlxColor.GOLDENROD);
		moneyText.scrollFactor.set();
		add(moneyText);

		turretButton = new FlxButton(0,0,"Buy Turret", createTurret );
		FlxSpriteUtil.screenCenter(turretButton,true,false);
		turretButton.scrollFactor.set();
		add(turretButton);

		healthText = new FlxText(0,0,FlxG.width,"3/3");
		healthText.setFormat(null,16,FlxColor.CORAL,"right");
		healthText.scrollFactor.set();
		add(healthText);

		new FlxTimer(4,createEnemy,0);
		new FlxTimer(10,createBoost,0);

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

		//Allow placing of turrets
		if (FlxG.keys.justPressed.SHIFT){
			createTurret();
		}

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
			money += 5;
			e.kill();
			b.kill();
		});

		FlxG.collide(player,speedBoosts, function (p,sb){
			sb.onTouchPlayer(p);
			sb.kill();

			new FlxTimer(6,function (timer){
				p.speed = 40;
			});
		});

		healthText.text = lives+"/3";
		moneyText.text = "$"+money;
		turretButton.visible = money >= turretCost;
	}

	function createEnemy (timer){
		enemyGroup.add(new Enemy(FlxRandom.intRanged(1,360),planet, onTouchGround));
	}

	function createBoost (timer){
		speedBoosts.add(new SpeedBoost(FlxRandom.intRanged(1,360),planet));
	}

	function onTouchGround () {
		lives--;
		if (lives == 0){
			FlxG.switchState(new MenuState());
		}
	}

	function createTurret () {
		if (money >= turretCost){
			money -= turretCost;
			turretGroup.add(new Turret(player.angle,player.x,player.y,bulletGroup));
			turretCost += 5;
		}
		
	}
}
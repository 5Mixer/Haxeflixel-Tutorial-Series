package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColorUtil;
import flixel.util.FlxRandom;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup;
import Paddle;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var ball:Ball;
	var paddles:FlxGroup = new FlxGroup();

	var leftScore = 0;
	var rightScore = 0;

	var scoreText:FlxText;
	var winText:FlxText;

	var background:FlxSprite;

	var maxScore:Int = 5;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		background = new FlxSprite();
		background.makeGraphic(FlxG.width,FlxG.height,FlxColor.WHITE);
		background.color = FlxColorUtil.makeFromHSBA(FlxRandom.intRanged(1,360),0.7,0.7);
		add(background);

		scoreText = new FlxText(0,0,FlxG.width,"0|0");
		scoreText.setFormat(null, 24, FlxColor.GREEN,"center");
		add(scoreText);

		winText = new FlxText(0,300,FlxG.width,"Player Won");
		winText.setFormat(null, 24, FlxColor.WHITE,"center");
		winText.visible = false;
		add(winText);

		paddles.add(new Paddle(30,200,"W","S"));
		paddles.add(new Paddle(FlxG.width - 40,200,"UP","DOWN"));
		add(paddles);

		add(ball = new Ball(FlxG.width/2,FlxG.height/2));
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

		FlxG.collide(ball,paddles,function (ball:FlxSprite,paddle:FlxSprite){
			ball.velocity.y = (ball.getMidpoint().y - paddle.getMidpoint().y)*6;

			FlxG.sound.play("assets/sounds/pop.wav");

			FlxG.camera.shake(0.01,0.1);

			background.color = FlxColorUtil.makeFromHSBA(FlxRandom.intRanged(1,360),0.7,0.7);
		});

		if (ball.x < 0){
			//Increase right score
			rightScore++;
			ball.resetBall();
			scoreText.text = leftScore + "|" + rightScore;

			if (rightScore > maxScore){
				scoreText.visible = true;
				scoreText.text = "Right Player won!";
				ball.velocity.set();

				new FlxTimer(4, function (timer){
					FlxG.resetGame();
				} );
			}
		}
		if (ball.x+ball.width > FlxG.width){
			//Increase left score
			leftScore++;
			ball.resetBall();
			scoreText.text = leftScore + "|" + rightScore;

			if (leftScore > maxScore){
				scoreText.visible = true;
				scoreText.text = "Left Player won!";
				ball.velocity.set();

				new FlxTimer(4, function (timer){
					FlxG.resetGame();
				} );
			}
		}
	}
}
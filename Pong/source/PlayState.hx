package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.group.FlxGroup;
import Paddle;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var ball:Ball;
	var paddles:FlxGroup = new FlxGroup();
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

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

		FlxG.collide(ball,paddles,function (ball,paddles){
			//increase score
		});
	}	
}
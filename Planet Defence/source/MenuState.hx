package ;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;

class MenuState extends FlxState{

	override public function create (){
		super.create();

		FlxG.scaleMode = new ScaleMode();

		//UI elements
		var titleText = new FlxText(0,20,FlxG.width,"Planet Defence");
		titleText.setFormat(null,16,FlxColor.LIME,'center');
		titleText.scrollFactor.set();
		add(titleText);

		var instructionsText = new FlxText(0,100,FlxG.width,"Press Space to begin!");
		instructionsText.setFormat(null,8,FlxColor.CORAL,'center');
		instructionsText.scrollFactor.set();
		add(instructionsText);

		FlxG.signals.gameResized.add( function (width,height){
			titleText.fieldWidth = width/2;
			instructionsText.fieldWidth = width/2;
		});
	}

	override public function update (){
		super.update();

		if (FlxG.keys.justPressed.SPACE){
			FlxG.switchState( new PlayState());
		}
	}
}
package ;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import flixel.addons.display.FlxStarField;

class Stars extends flixel.addons.display.FlxStarField2D {

	//Store the position of the camera the previous frame
	var lastCamX:Float = 0;
	var lastCamY:Float = 0;

	public function new (X,Y,Width,Height,StarAmount){
		super(X, Y, Width, Height, StarAmount);

		lastCamX = FlxG.camera.scroll.x;
		lastCamY = FlxG.camera.scroll.y;

		scrollFactor.set();
		starVelocityOffset.set();

		FlxG.signals.gameResized.add( function (w,h){
			width = w;
			height = h;
			setSize(w,h);
			try{
				makeGraphic(FlxG.width*2,FlxG.height*2,FlxColor.BLACK);
			}catch (e:Dynamic){

			}

			randomiseStars();
		});
	}

	override public function update () {
		starVelocityOffset.set((lastCamX-FlxG.camera.scroll.x)/15,(lastCamY-FlxG.camera.scroll.y)/15);
		super.update();

		lastCamX = FlxG.camera.scroll.x;
		lastCamY = FlxG.camera.scroll.y;
	}

	function randomiseStars(){
		if (_stars != null){
			for (star in _stars){
				star.x = FlxRandom.intRanged(0,FlxG.width*2);
				star.y = FlxRandom.intRanged(0,FlxG.height*2);
			}
		}
	}
}
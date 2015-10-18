package ;

import flixel.FlxG;
import flixel.system.scaleModes.BaseScaleMode;
import flixel.system.scaleModes.StageSizeScaleMode;

@:allow(flixel.FlxGame)
class ScaleMode extends StageSizeScaleMode
{
	override public function onMeasure(Width:Int, Height:Int):Void
	{
		FlxG.width = Std.int(Width/2);
		FlxG.height = Std.int(Height/2);

		FlxG.game.scaleX = FlxG.game.scaleY = 1;
		FlxG.game.x = FlxG.game.y = 0;

		if (FlxG.camera != null)
		{
			var oldW = FlxG.camera.width;
			var oldH = FlxG.camera.height;

			var newW = Math.ceil(Width / FlxG.camera.zoom);
			var newH = Math.ceil(Height / FlxG.camera.zoom);

			FlxG.camera.setSize(newW, newH);
			FlxG.camera.flashSprite.x += (newW - oldW) / 2;
			FlxG.camera.flashSprite.y += (newH - oldH) / 2;
		}
	}
}

package;

import flixel.util.FlxStringUtil;
import openfl.events.Event;
import openfl.text.TextFormat;
import cpp.vm.Gc;
import openfl.text.TextField;
import openfl.Lib;

class Memory extends TextField {
    private var overCounter = 0;
    private var isOver = false;

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

    public function new(x:Float = 15, y:Float = 20, color:Int = 0x000000) {
        super();

        this.x = x;
        this.y = y;

        defaultTextFormat = new TextFormat("_sans", 12, color);
        text = "Memory: ";

		addEventListener(Event.ENTER_FRAME, function(e)
		{
			var usedMemory:Float = Gc.memUsage();
            if (Gc.memUsage() < 0 && !isOver)
            {
                isOver = true;
            }
            if (Gc.memUsage() > 0 && isOver)
            {
                overCounter++;
                isOver = false;
            }
            if (isOver) {
                usedMemory = 2147483647+(2147483647-(Math.abs(Gc.memUsage()))); // funny math to represent values over 2GB
            }
            text = "Memory: " + FlxStringUtil.formatBytes(usedMemory + 4294967296*overCounter);
		});
    }
}
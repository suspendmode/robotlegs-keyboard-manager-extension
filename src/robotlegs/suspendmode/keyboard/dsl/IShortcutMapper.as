package robotlegs.suspendmode.keyboard.dsl
{
	import robotlegs.suspendmode.keyboard.impl.Shortcut;

	public interface IShortcutMapper
	{
		function withKey(keyCode:uint, keyLocation:uint=0):IShortcutMapper;

		function toListener(listener:Function):Shortcut;

	}
}

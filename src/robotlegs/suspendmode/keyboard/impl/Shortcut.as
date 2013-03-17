/**
 *
 * Copyright 2012(C) by Piotr Kucharski.
 * email: suspendmode@gmail.com
 * mobile: +48 791 630 277
 *
 * All rights reserved. Any use, copying, modification, distribution and selling of this software and it's documentation
 * for any purposes without authors' written permission is hereby prohibited.
 *
 */
package robotlegs.suspendmode.keyboard.impl
{
	import robotlegs.suspendmode.keyboard.dsl.IShortcutMapper;

	/**
	 *
	 * @author suspendmode@gmail.com
	 *
	 */
	public class Shortcut implements IShortcutMapper
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 */
		public const keys:Vector.<Key>=new Vector.<Key>();

		/**
		 *
		 */
		public var trigger:String=null;

		/**
		 *
		 */
		public var active:Boolean=false;

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 */
		public const listeners:Vector.<Function>=new Vector.<Function>();

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param keyCode
		 * @param keyLocation
		 * @return
		 *
		 */
		public function withKey(keyCode:uint, keyLocation:uint=0):IShortcutMapper
		{
			var key:Key=new Key();
			key.keyCode=keyCode;
			key.keyLocation=keyLocation;
			keys.push(key)
			return this;
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param listener
		 *
		 */
		public function toListener(listener:Function):Shortcut
		{
			listeners.push(listener);
			return this;
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 *
		 */
		public function dispose():void
		{
			while (keys.length)
			{
				keys.shift();
			}
			while (listeners.length)
			{
				listeners.shift();
			}
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param shortcut
		 * @return
		 *
		 */
		public function equals(shortcut:Shortcut):Boolean
		{
			if (shortcut.trigger != trigger)
			{
				return false;
			}

			if (shortcut.keys.length != keys.length)
			{
				return false;
			}

			for (var i:int=0; i < keys.length; i++)
			{
				var k1:Key=keys[i];
				var k2:Key=shortcut.keys[i];
				if (!k1.equals(k2))
				{
					return false;
				}
			}
			return true;
		}

		public function keysEquals(keys:Vector.<Key>):Boolean
		{
			if (this.keys.length != keys.length)
			{
				return false;
			}

			for (var i:int=0; i < this.keys.length; i++)
			{
				var k1:Key=keys[i];
				var k2:Key=this.keys[i];
				if (!k1.equals(k2))
				{
					return false;
				}
			}
			return true;
		}
	}
}

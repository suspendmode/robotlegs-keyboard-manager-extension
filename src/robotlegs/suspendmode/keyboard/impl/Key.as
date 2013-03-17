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
	import flash.ui.KeyLocation;

	/**
	 *
	 * @author suspendmode@gmail.com
	 *
	 */
	public class Key
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        /**
         * 
         */
		public var keyCode:uint;
        
        /**
         * 
         */
		public var keyLocation:uint;

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		

        /**
         * 
         * @param key
         * @return 
         * 
         */
		public function equals(key:Key):Boolean
		{
			if (key.keyCode == keyCode && key.keyLocation == keyLocation)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

        /**
         * 
         * @return 
         * 
         */
		public function toString():String
		{
			if (keyLocation == KeyLocation.LEFT)
			{
				return "[Key:" + keyCode + ", location:LEFT]";
			}
			else if (keyLocation == KeyLocation.D_PAD)
			{
				return "[Key:" + keyCode + ", location:D_PAD]";
			}
			else if (keyLocation == KeyLocation.NUM_PAD)
			{
				return "[Key:" + keyCode + ", location:NUM_PAD]";
			}
			else if (keyLocation == KeyLocation.RIGHT)
			{
				return "[Key:" + keyCode + ", location:RIGHT]";
			}
			else if (keyLocation == KeyLocation.STANDARD)
			{
				return "[Key:" + keyCode + ", location:STANDARD]";
			}
			else
			{
				return "[Key:" + keyCode + "]";
			}

		}
	}
}

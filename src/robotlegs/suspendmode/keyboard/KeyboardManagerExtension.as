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
package robotlegs.suspendmode.keyboard
{
	import robotlegs.bender.extensions.utils.ensureContextUninitialized;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;
	import robotlegs.suspendmode.keyboard.api.IKeyboardManager;
	import robotlegs.suspendmode.keyboard.impl.KeyboardManager;


	/**
	 *
	 * @author suspendmode@gmail.com
	 *
	 */
	public class KeyboardManagerExtension implements IExtension
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 * @inheritDoc
		 */
		public function extend(context:IContext):void
		{
            ensureContextUninitialized(context, this);
            
			context.injector.map(IKeyboardManager).toSingleton(KeyboardManager);
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
    }
}

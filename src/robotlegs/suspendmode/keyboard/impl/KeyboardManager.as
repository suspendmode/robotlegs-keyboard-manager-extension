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
	import flash.events.KeyboardEvent;
	
	import robotlegs.suspendmode.keyboard.api.IKeyboardManager;
	import robotlegs.suspendmode.keyboard.dsl.IShortcutMapper;

	/**
	 *
	 * @author suspendmode@gmail.com
	 *
	 */
	public class KeyboardManager extends KeyboardManagerBase implements IKeyboardManager
	{

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param keyCode
		 * @param keyLocation
		 * @return
		 *
		 */
		public function mapTrigger(keyCode:uint, keyLocation:uint=0):IShortcutMapper
		{
            var shortcut:IShortcutMapper=createMapping(null, keyCode, keyLocation);
            mappings.push(shortcut);
            return shortcut;
		}

		/**
		 *
		 * @param keyCode
		 * @param keyLocation
		 * @return
		 *
		 */
		public function mapGateDown(keyCode:uint, keyLocation:uint=0):IShortcutMapper
		{
            var shortcut:IShortcutMapper=createMapping(KeyboardEvent.KEY_DOWN, keyCode, keyLocation);
            mappings.push(shortcut);
            return shortcut;
		}
        
        /**
         *
         * @param keyCode
         * @param keyLocation
         * @return
         *
         */
        public function mapGateUp(keyCode:uint, keyLocation:uint=0):IShortcutMapper
        {
            var shortcut:IShortcutMapper=createMapping(KeyboardEvent.KEY_UP, keyCode, keyLocation);
            mappings.push(shortcut);
            return shortcut;
        }
               
        /**
         * 
         * @param trigger
         * @param keyCode
         * @param keyLocation
         * @return 
         * 
         */
        public function createMapping(trigger: String, keyCode: uint, keyLocation: uint = 0): IShortcutMapper {
            var shortcut:Shortcut=new Shortcut();
            shortcut.trigger = trigger;
            shortcut.withKey(keyCode, keyLocation);
            return shortcut;
        }
     
        /**
         * 
         * @param shortcut
         * 
         */
        public function unmap(shortcut: Shortcut): void {
            var i: int = getMappingIndex(shortcut);
            mappings.splice(i, 1);
        }
        
        /**
         * 
         * @param shortcut
         * @return 
         * 
         */
        private function getMappingIndex(shortcut:Shortcut):int
        {
            for (var i: int = 0; i < mappings.length; i++) {
                var m: Shortcut = mappings[i];
                if (m.equals(shortcut)) {
                    return i;
                }
            }
            return -1;
        }
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}

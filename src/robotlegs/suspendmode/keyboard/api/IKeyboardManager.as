package robotlegs.suspendmode.keyboard.api
{
    import robotlegs.suspendmode.keyboard.dsl.IShortcutMapper;
    import robotlegs.suspendmode.keyboard.impl.Shortcut;

    public interface IKeyboardManager
    {
        /**
         * 
         * @param keyCode
         * @param keyLocation
         * @return 
         * 
         */
        function mapTrigger(keyCode:uint, keyLocation: uint = 0): IShortcutMapper;
        
        /**
         * 
         * @param keyCode
         * @param keyLocation
         * @return 
         * 
         */
        function mapGateUp(keyCode:uint, keyLocation: uint = 0): IShortcutMapper;
        
        /**
         * 
         * @param keyCode
         * @param keyLocation
         * @return 
         * 
         */
        function mapGateDown(keyCode:uint, keyLocation: uint = 0): IShortcutMapper;        
                
        /**
         * 
         * @param shortcut
         * 
         */
        function unmap(shortcut: Shortcut): void;        
                
        /**
         * 
         * @param trigger
         * @param keyCode
         * @param keyLocation
         * @return 
         * 
         */
        function createMapping(trigger: String, keyCode: uint, keyLocation: uint = 0): IShortcutMapper;
    }
}
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
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;

	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.ILogger;

	/**
	 *
	 *
	 *
	 */
	[Event(name="activate", type="flash.events.Event")]

	/**
	 *
	 */
	[Event(name="deactivate", type="flash.events.Event")]

	/**
	 *
	 */
	[Event(name="change", type="flash.events.Event")]

	/**
	 *
	 * @author suspendmode@gmail.com
	 *
	 */
	public class KeyboardManagerBase extends EventDispatcher
	{

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 */
		public const mappings:Vector.<Shortcut>=new Vector.<Shortcut>();

		/**
		 *
		 */
		public const buffer:Vector.<Key>=new Vector.<Key>();

		[Inject(optional="false")]
		/**
		 *
		 */
		public var log:ILogger;

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		[Inject(optional="true")]
		/**
		 *
		 */
		public var contextView:ContextView;

		[Inject(optional="true")]
		/**
		 *
		 */
		public var stage:Stage;

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param target
		 *
		 */
		public function KeyboardManagerBase(stage:Stage=null, target:IEventDispatcher=null)
		{
			super(target);
			this.stage=stage;
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		[PostConstruct]
		/**
		 *
		 */
		public function initialize():void
		{

			var stage:Stage=stage || contextView.view.stage;

			if (!stage)
			{
				throw new IllegalOperationError("no stage or ContextView");
			}
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardEvent);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyboardEvent);
		}

		[PreDestroy]
		/**
		 *
		 */
		public function dispose():void
		{
			var stage:Stage=stage || contextView.view.stage;

			if (!stage)
			{
				throw new IllegalOperationError("no stage or ContextView");
			}
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyboardEvent);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyboardEvent);

		}

		/**
		 *
		 */
		private var _enabled:Boolean=true;
		;

		/**
		 *
		 * @return
		 *
		 */
		public function get enabled():Boolean
		{
			return _enabled;
		}

		/**
		 *
		 * @param value
		 *
		 */
		public function set enabled(value:Boolean):void
		{
			if (_enabled == value)
				return;
			_enabled=value;
			if (value)
			{
				dispatchEvent(new Event(Event.ACTIVATE));
			}
			else
			{
				dispatchEvent(new Event(Event.DEACTIVATE));
			}
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param event
		 *
		 */
		private function onKeyboardEvent(event:KeyboardEvent):void
		{
			if (!enabled)
			{
				return;
			}
			if (log)
			{
				log.debug("keyboard keyCode:{0}:{1} event: {2}", [event.keyCode, String.fromCharCode(event.keyCode), event]);
			}

			var key:Key=new Key();
			key.keyCode=event.keyCode;
			key.keyLocation=event.keyLocation;

			if (event.type == KeyboardEvent.KEY_DOWN)
			{
				addToBuffer(key);
			}
			else
			{
				removeFromBuffer(key);
			}

			log.info("buffer {0}:{1}", [buffer.length, buffer]);
			process(mappings, buffer, event);

			event.updateAfterEvent();
		}

		private function addToBuffer(key:Key):void
		{
			var i:int=getKeyIndex(key);
			if (i == -1)
			{
				buffer.push(key);
				dispatchEvent(new Event(Event.CHANGE));
			}
		}

		private function getKeyIndex(key:Key):int
		{
			for (var i:int=0; i < buffer.length; i++)
			{
				var k:Key=buffer[i];
				if (k.equals(key))
				{
					return i;
				}
			}
			return -1;
		}

		private function removeFromBuffer(key:Key):void
		{
			var i:int=getKeyIndex(key);
			if (i != -1)
			{
				buffer.splice(i, 1);
				dispatchEvent(new Event(Event.CHANGE));
			}
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param mappings
		 * @param buffer
		 * @param event
		 *
		 */
		private function process(mappings:Vector.<Shortcut>, buffer:Vector.<Key>, event:KeyboardEvent):void
		{
			for each (var shortcut:Shortcut in mappings)
			{
				if (!shortcut.trigger && event.type == KeyboardEvent.KEY_UP)
				{
					continue;
				}

				if (shortcut.trigger && event.type == KeyboardEvent.KEY_DOWN)
				{
					if (!shortcut.keysEquals(buffer))
					{
						continue;
					}
					shortcut.active=true;
					applyListneners(shortcut);
					continue;
				}

				else if (shortcut.trigger && shortcut.active && event.type == KeyboardEvent.KEY_UP)
				{
					if (!shortcut.keysEquals(buffer))
					{
						continue;
					}
					shortcut.active=false;
				}

				else if (shortcut.trigger == KeyboardEvent.KEY_UP && event.type == KeyboardEvent.KEY_UP && !shortcut.active)
				{
					if (!shortcut.keysEquals(buffer))
					{
						continue;
					}
					shortcut.active=true;
					applyListneners(shortcut);
					shortcut.active=false;
				}

				else if (shortcut.trigger == KeyboardEvent.KEY_DOWN && event.type == KeyboardEvent.KEY_DOWN && !shortcut.active)
				{
					if (!shortcut.keysEquals(buffer))
					{
						continue;
					}
					shortcut.active=true;
					applyListneners(shortcut);
					shortcut.active=false;
				}
			}
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/**
		 *
		 * @param mapping
		 *
		 */
		private function applyListneners(shortcut:Shortcut):void
		{
			if (log)
			{
				log.debug("applyListneners:{0}", [shortcut]);
			}
			if (!shortcut.listeners.length)
			{
				return;
			}

			for each (var listener:Function in shortcut.listeners)
			{
				if (listener.length == 0)
				{
					listener();
				}
				else if (listener.length == 1)
				{
					listener(shortcut);
				}
				else
				{
					listener(shortcut, this);
				}
			}
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}

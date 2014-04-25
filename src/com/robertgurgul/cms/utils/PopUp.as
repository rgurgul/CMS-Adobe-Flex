package com.robertgurgul.cms.utils
{
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	
	import org.spicefactory.parsley.core.context.Context;
	
	import spark.components.TitleWindow;

	public class PopUp
	{
		public static var lastWindow:TitleWindow;
		
		[Inject]
		public var context:Context;
		
		public function PopUp()
		{
			
		}
		public function showWindow(obj:TitleWindow):TitleWindow
		{
			context.viewManager.addViewRoot( obj );
			closeHandler();
			lastWindow = obj;
			PopUpManager.addPopUp(obj as TitleWindow, FlexGlobals.topLevelApplication.panelCMS, true);
			PopUpManager.centerPopUp(obj as TitleWindow);
			return obj;
		}
		public function closeHandler():void
		{
			if(lastWindow) PopUpManager.removePopUp(lastWindow as TitleWindow);
		}
	}
}
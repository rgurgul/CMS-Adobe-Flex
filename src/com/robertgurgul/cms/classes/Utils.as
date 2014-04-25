package com.robertgurgul.cms.classes
{
	import com.robertgurgul.cms.view.windows.*;
	import com.robertgurgul.cms.view.windows.forms.ContactForm;
	import com.robertgurgul.cms.view.windows.login.LoginPanel;
	import com.robertgurgul.cms.view.windows.menu.AddMenu;
	
	import flash.events.Event;
	
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.TextFlow;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	
	import spark.components.TitleWindow;
	import spark.events.IndexChangeEvent;

	public class Utils
	{
		[Bindable] public static var changeViewStack:int = 0;
		[Bindable] public static var youAreIn:String;
		[Bindable] public static var visibleLoginPanel:Boolean = true;
		public static var lastWindow:TitleWindow;
		[Bindable] public static var path:String;
		
		public static var arrWindows:Array = [new LoginPanel(), new ContactForm(), new AddMenu()];

		static public function closeHandler2():void
		{
			if(Utils.lastWindow) PopUpManager.removePopUp(Utils.lastWindow as TitleWindow);
		}
		
		static public function mergeArrays(a:ArrayCollection, b:ArrayCollection):ArrayCollection
		{
			for each(var item:Object in b)
			{
				a.addItem(item);
			}
			a.refresh();
			return a;
		}
		static public function convertText(txt:String):TextFlow
		{
			var result:TextFlow = TextConverter.importToFlow(txt, TextConverter.TEXT_FIELD_HTML_FORMAT);
			return result;
		}
		static public function selectAllCheckboxes(boxCheckBox:*):void
		{
			var allChild:int = boxCheckBox.numChildren;
			
			for (var i:int = 0; i < allChild; i++)
			{
				boxCheckBox.getChildAt(i).selected = true;	
			}
			
			FlexGlobals.topLevelApplication.navi.dispatchEvent(new Event("refreshProducts"));

		}
		static public function unSelectAllCheckboxes(boxCheckBox:*):void
		{	
			var allChild:int = boxCheckBox.numChildren;
			
			for (var i:int = 0; i < allChild; i++)
			{
				boxCheckBox.getChildAt(i).selected = false;
			}
			FlexGlobals.topLevelApplication.navi.dispatchEvent(new Event("refreshProducts"));
			Alert.show('nie wybrano żadnej kategorii');
		}
		
		static public function lisenEachCheckBox(boxCheckBox:*):void
		{
			var allChild:int = boxCheckBox.numChildren;
			
			for (var i:int = 0; i < allChild; i++)
			{
				boxCheckBox.getChildAt(i).addEventListener(Event.CHANGE, function():void {FlexGlobals.topLevelApplication.navi.dispatchEvent(new Event("refreshProducts"))});
			}
		}
		
		static public function arrayCollectionFiltroza(event:IndexChangeEvent, param:String, holder:ArrayCollection, children:String):ArrayCollection
		{
			var arr:ArrayCollection = new ArrayCollection(holder.source);
			arr.filterFunction = function(item:Object):Boolean{ return item[param] == event.target.selectedItem.id };
			arr.refresh();
			
			return arr[0][children];
		}
			
	}
}
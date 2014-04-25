package com.robertgurgul.cms.components
{
	import com.robertgurgul.cms.message.utils.ReorderTableMessage;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import spark.components.DataGroup;
	import spark.layouts.supportClasses.DropLocation;
	
	public class CustomDataGroup extends DataGroup
	{
		private var selectedIndex:int;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public function CustomDataGroup()
		{
			super();
			addEventListener('setImageURL', setImageURL);
			addEventListener(DragEvent.DRAG_DROP, dragDropHandler);
			addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler);
		}
		
		public function setImageURL(e:Event):void
		{
			var obj:* = this.dataProvider.getItemAt(e.target.selectedIndex);
			selectedIndex = e.target.selectedIndex;
		}
		
		private function dragDropHandler(e:DragEvent):void 
		{
			var pos:DropLocation = this.layout.calculateDropLocation(e);
			trace(pos.dropIndex, selectedIndex, dataProvider.length);
			var obj:* = this.dataProvider.getItemAt(selectedIndex);
			this.dataProvider.removeItemAt(selectedIndex);
			var newPos:int = Math.min(pos.dropIndex, dataProvider.length);
			this.dataProvider.addItemAt(obj, newPos);
			
			for( var i:int = 0; i < this.dataProvider.length; i++)
			{
				this.dataProvider[i].order = i;
			}
			trace(this.automationName);
			
			dispatcher( new ReorderTableMessage(ReorderTableMessage.REORDER_TABLE, this.automationName, ArrayCollection(this.dataProvider) ) );
		}
		
		private function dragEnterHandler(e:DragEvent):void 
		{
			DragManager.acceptDragDrop(e.currentTarget as IUIComponent);
		}
	}
}
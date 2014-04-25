package com.robertgurgul.cms.components
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.DragSource;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	import mx.managers.DragManager;
	
	import spark.components.DataGrid;
	import spark.components.gridClasses.GridColumn;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.GridEvent;
	
	
	[SkinState("normal")]
	[SkinState("disable")]
	public class CustomDataGridSkin extends SkinnableComponent
	{
		//---------------------------------------------
		// SKIN PART
		//---------------------------------------------
		
		
		[SkinPart(required="true")]
		public var grid:DataGrid;
		
		//---------------------------------------------
		// CONSTRUCTOR
		//---------------------------------------------
		public function CustomDataGridSkin()
		{
			super();
		}
		
		//---------------------------------------------
		// OVERRIDE METHODES
		//---------------------------------------------
		override protected function getCurrentSkinState():String
		{
			return super.getCurrentSkinState();
		} 
		
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			
			if (grid == instance) {
				grid.addEventListener(GridEvent.GRID_MOUSE_DRAG, onGridMouseDrag);
				grid.addEventListener(GridEvent.GRID_MOUSE_DOWN, onGridMouseDown);
				grid.addEventListener(GridEvent.GRID_MOUSE_UP, onGridMouseUp);
			}
		}
		
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
			
			if (grid == instance) {
				grid.removeEventListener(GridEvent.GRID_CLICK, gridClickEventHandler);
			}
		}
		
		//---------------------------------------------
		// EVENT HANDLERS
		//---------------------------------------------
		
		
		protected function gridClickEventHandler(event:GridEvent):void
		{
			mx.controls.Alert.show("DataGrid Event Click");
		}
		
		private var row:DataGrid;
		private var pointX:Number;
		private var pointY:Number;
		
		protected function onGridMouseDrag(event:GridEvent):void {
			//trace ("drag");
			if (event != null && event.item != null && event.target != null && event.target.selectedItem != null && event.columnIndex == 0) {
				if (row != null && row.height != row.rowHeight) {
					if(!isNaN(row.rowHeight)) {
						row.height = row.rowHeight;
						if (row.columnHeaderGroup != null) {
							row.columnHeaderGroup.height = 0;
						}
					}
				}
				var source:DragSource = new DragSource();
				source.addData(event.item, 'Object');
				
				if (event.itemRenderer != null){
					var pt:Point = new Point(0,0);
					pt = DisplayObject(event.target).localToGlobal(pt);
					pointX = 0;
					pointY = - (event.itemRenderer.y);
					DragManager.doDrag(event.target as UIComponent, source, event, 
						row as IFlexDisplayObject, pointX, pointY);
				} else {
					DragManager.doDrag(event.target as UIComponent, source, event, 
						row as IFlexDisplayObject);
				}
			}
		}
		
		protected function onGridMouseDown(event:GridEvent):void 
		{
			row = new DataGrid();
			var items:ArrayCollection = new ArrayCollection();
			items.addItem(event.item);
			row.dataProvider = items;
			row.width = grid.width;
			row.columns = new ArrayCollection();
			for each (var col:GridColumn in grid.columns.toArray()){
				row.columns.addItem(col);
			}
			for each (var obj:Object in grid.dataProvider){

			}
		}
		
		protected function onGridMouseUp(event:GridEvent):void 
		{
			if (event != null && event.item != null && event.target.selectedItem != null && event.columnIndex == 0) {
				
				var oldIndex:int = event.target.selectedIndex;
				var newIndex:int = event.rowIndex;
				
				if (newIndex != oldIndex) {
					var item:Object = event.target.selectedItem;
					event.target.dataProvider.removeItemAt(oldIndex);
					event.target.dataProvider.addItemAt(item, newIndex);
					event.target.selectedIndex = event.rowIndex;
				}
				
				for( var i:int = 0; i < event.target.dataProvider.length; i++)
				{
					
				}
			}
		}
	}
}
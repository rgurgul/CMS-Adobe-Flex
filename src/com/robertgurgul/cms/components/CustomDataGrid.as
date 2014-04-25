package com.robertgurgul.cms.components
{
	import com.robertgurgul.cms.message.utils.ReorderTableMessage;
	
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
	import spark.events.GridEvent;
	
	public class CustomDataGrid extends DataGrid
	{
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public function CustomDataGrid()
		{
			super();
			addEventListener(GridEvent.GRID_MOUSE_DRAG, onGridMouseDrag);
			addEventListener(GridEvent.GRID_MOUSE_DOWN, onGridMouseDown);
			addEventListener(GridEvent.GRID_MOUSE_UP, onGridMouseUp);
		}
		protected function gridClickEventHandler(event:GridEvent):void
		{
			mx.controls.Alert.show("DataGrid Event Click");
		}
		
		private var row:DataGrid;
		private var pointX:Number;
		private var pointY:Number;
		
		protected function onGridMouseDrag(event:GridEvent):void 
		{
			if (event != null && event.item != null && event.target != null && event.target.selectedItem != null 
				&& event.columnIndex == 0) //chwycono kolumne tytul. 
			{
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
					
					for( var i:int = 0; i < event.target.dataProvider.length; i++)
					{
						event.target.dataProvider[i].order = i;
					}
					
					dispatcher( new ReorderTableMessage(ReorderTableMessage.REORDER_TABLE, this.automationName, event.target.dataProvider ) );
				}
			}
		}
	}
}
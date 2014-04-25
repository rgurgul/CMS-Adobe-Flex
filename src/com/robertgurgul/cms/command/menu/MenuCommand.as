package com.robertgurgul.cms.command.menu
{
	import com.robertgurgul.cms.classes.MenuItem;
	import com.robertgurgul.cms.message.utils.MenuMessage;
	import com.robertgurgul.cms.model.DataHolder;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.utils.ArrayUtil;

	public class MenuCommand
	{
		[Inject(id="loginService")]
		public var service:RemoteObject;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public function execute(): void 
		{
			service.getMenu();
			service.getMenu.addEventListener(ResultEvent.RESULT, result);
		}
		
		private function result (result: ResultEvent): void 
		{
			DataHolder.getInstance().dataMenu.removeAll();
			var ac:ArrayCollection = new ArrayCollection(ArrayUtil.toArray(result.result))[0];
			
			for each (var item2:Object in ac)
			{
				if(item2.kat1 != '')
				{			
					DataHolder.getInstance().dataMenu.addItem(new MenuItem(
						item2.id,
						item2.kat1,
						'kat1',
						item2.id_parent,
						item2.link,
						item2.kindCMS,
						item2.show_stat));
					
				} else if(item2.kat2 != '') 
				{
					var arr:ArrayCollection = new ArrayCollection(DataHolder.getInstance().dataMenu.source);
					arr.filterFunction = function(item:Object):Boolean{ return item['id'] == item2.id_parent }; //wybieram jednego z tym id == id_parent
					arr.refresh();
					var obj:MenuItem = arr[0] as MenuItem;
					item2.name = item2.kat2;
					item2.kat = 'kat2';
					item2.children = new ArrayCollection(); // dodaje kontener dla sub2
					
					obj.addChildren(item2);
					
				} else if(item2.kat3 != '') 
				{
					for each(var menu:Object in DataHolder.getInstance().dataMenu)
					{
						for each( var sub1:Object in menu.children)
						{
							if(sub1.id == item2.id_parent)
							{
								item2.name = item2.kat3;
								item2.kat = 'kat3';
								sub1.children.addItem(item2);
							}
						}
					}
				}
			}
		}
	}
}
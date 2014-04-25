package com.robertgurgul.cms.command.menu
{
	import com.robertgurgul.cms.message.pages.HomeImgMessage;
	import com.robertgurgul.cms.message.utils.MenuMessage;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.remoting.RemoteObject;
	
	public class AddMenuItemCommand
	{
		[Inject(id="loginService")]
		public var service:RemoteObject;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public function execute (msg:MenuMessage): AsyncToken 
		{
			return service.addMenu(0, msg.itemName, msg.itemKind)
		}
		
		public function error (fault: Fault): void {
			Alert.show(fault.toString());
		}
	}
}
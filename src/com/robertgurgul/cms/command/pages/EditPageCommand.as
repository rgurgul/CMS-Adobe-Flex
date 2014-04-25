package com.robertgurgul.cms.command.pages
{
	import com.robertgurgul.cms.message.pages.PageMessage;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.remoting.RemoteObject;
	
	public class EditPageCommand 
	{
		[Inject(id="loginService")]
		public var service:RemoteObject;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public function execute (msg:PageMessage): AsyncToken 
		{
			return service.editPage(msg.pageVo)
		}
		
		public function result (item: Object): void 
		{	
			Alert.show('strona zapisana');
		}
		
		public function error (fault: Fault): void {
			Alert.show(fault.toString());
		}
	}
}
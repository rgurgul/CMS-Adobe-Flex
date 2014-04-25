package com.robertgurgul.cms.command.news
{
	import com.robertgurgul.cms.message.pages.NewsMessage;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.remoting.RemoteObject;
	
	public class GetNewsCommand
	{
		[Inject(id="loginService")]
		public var service:RemoteObject;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public function execute (msg:NewsMessage): AsyncToken 
		{
			return service.getNews();
		}

		public function error (fault: Fault): void {
			Alert.show(fault.toString());
		}
	}
}
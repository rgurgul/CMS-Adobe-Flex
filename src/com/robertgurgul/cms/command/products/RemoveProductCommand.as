package com.robertgurgul.cms.command.products
{
	import com.robertgurgul.cms.message.pages.ProductsMessage;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.remoting.RemoteObject;
	
	public class RemoveProductCommand 
	{
		[Inject(id="loginService")]
		public var service:RemoteObject;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public function execute (msg:ProductsMessage): AsyncToken 
		{
			return service.removeProduct(msg.productVo.id);
		}
		
		public function error (fault: Fault): void {
			Alert.show(fault.toString());
		}
	}
}
package com.robertgurgul.cms.command.utils
{
	import com.robertgurgul.cms.message.utils.ReorderTableMessage;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.remoting.RemoteObject;
	
	public class ReorderTableCommand 
	{
		[Inject(id="loginService")]
		public var service:RemoteObject;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public function execute (msg:ReorderTableMessage): AsyncToken 
		{
			return service.reorderTable(msg.tableName, msg.arr);
		}
		
		public function error (fault: Fault): void {
			Alert.show(fault.toString());
		}
	}
}
package com.robertgurgul.cms.command.utils
{
	import com.robertgurgul.cms.message.utils.ContactMessage;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.remoting.RemoteObject;
	
	public class ContactCommand 
	{
		[Inject(id="loginService")]
		public var service:RemoteObject;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public function execute (msg:ContactMessage): AsyncToken 
		{
			return service.sendMail(msg.title, msg.email, msg.desc); 
		}
		
		public function result (result: Object): void 
		{	
			Alert.show('wiadomość wysłana');
		}
		
		public function error (fault: Fault): void {
			Alert.show(fault.toString());
		}
	}
}
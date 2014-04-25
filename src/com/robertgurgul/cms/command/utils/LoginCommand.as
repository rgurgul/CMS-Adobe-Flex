package com.robertgurgul.cms.command.utils
{
	import com.robertgurgul.cms.message.utils.LoginMessage;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.remoting.RemoteObject;
	
	public class LoginCommand 
	{
		[Inject(id="loginService")]
		public var service:RemoteObject;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public function execute (msg: LoginMessage): AsyncToken {
			return service.log(msg.login, msg.pass);
		}
		
		public function result (result: Object): void 
		{	
			if(result[0]) dispatcher( new LoginMessage('showCMS'));
		}
		
		public function error (fault: Fault): void {
			Alert.show(fault.toString());
		}
	}
}
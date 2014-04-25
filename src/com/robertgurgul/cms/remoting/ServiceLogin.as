package com.robertgurgul.cms.remoting
{
	import mx.controls.Alert;
	import mx.controls.TextInput;

	public class ServiceLogin extends MyService
	{
		public function ServiceLogin()
		{
			super(myResultCallback, myFaultCallback);
		}
		
		private function myFaultCallback():void
		{
			Alert.show('serwis fault');
		}
		
		private function myResultCallback(e:String):void
		{
			Alert.show('serwis OK');
		}
		
		public function log(email:TextInput, pass:TextInput):void
		{
			log(email.text, pass.text);
			email.text = '';
			pass.text = '';
		}
	}
}
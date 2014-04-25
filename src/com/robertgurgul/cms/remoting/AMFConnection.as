package com.robertgurgul.cms.remoting
{
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public dynamic class AMFConnection extends RemoteObject
	{
		protected var _resultCallback:Function = null;
		protected var _faultCallback:Function = null;
		
		public function AMFConnection(destination:String, endpoint:String, source:String, resultCallback:Function = null, faultCallback:Function = null)
		{
			super(destination);
			//super.endpoint = endpoint;
			super.source = source;
			showBusyCursor = true;
			
			if (resultCallback != null)
			{
				_resultCallback = resultCallback;
			}
			
			if (faultCallback != null)
			{
				_faultCallback = faultCallback;
			}
			
			addEventListener(ResultEvent.RESULT, serverResultHandler);
			addEventListener(FaultEvent.FAULT, serverFaultHandler);
		}
		
		protected function serverResultHandler(event:ResultEvent):void
		{ 
			var returnData:Object = event.result;
			
			if (_resultCallback != null)
			{
				_resultCallback(returnData);
			}
		}
		
		protected function serverFaultHandler(event:FaultEvent):void
		{
			Alert.show("\n" + event.fault.faultString + "\n\n", "AMF Connection error");
			
			if (_faultCallback != null)
			{
				_faultCallback();
			}
		}
	}
}
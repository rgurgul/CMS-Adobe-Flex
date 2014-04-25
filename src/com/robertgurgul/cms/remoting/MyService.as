package com.robertgurgul.cms.remoting
{
	public dynamic class MyService extends AMFConnection
	{
		public function MyService(resultCallback:Function = null, faultCallback:Function = null)
		{
			super("amfphp", "nie podaje endpoint", "CMSService", resultCallback, faultCallback);
		}
	}	
}

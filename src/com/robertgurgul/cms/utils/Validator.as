package com.robertgurgul.cms.utils
{
	import mx.controls.Alert;

	public class Validator
	{
		public function Validator()
		{
		}
		static public function valid(...args):Boolean
		{
			for(var i:int = 0; i < args.length; i++)
			{
				if(String(args[i]) == '' || args[i] == -1) return false;
			} 
			return true;
			
		}
	}
}
package com.robertgurgul.cms.remoting
{
	import mx.rpc.remoting.RemoteObject;

	public class RemoteConnector extends RemoteObject
	{
		public var m_objRemote:RemoteObject;
		public var remoteResult:RemoteResults;
		
		public function RemoteConnector()
		{
			super("amfphp");
			super.source = "CMSService";
			showBusyCursor = true;
			
			this.getPage.addEventListener("result", remoteResult.onGetPage);
			getPosts.addEventListener("result", remoteResult.onGetPosts);
			m_objRemote.getPhotos.addEventListener("result", remoteResult.onGetPhotos);
			m_objRemote.getMenu.addEventListener("result", remoteResult.onGetMenu);
			
			
			m_objRemote.addMenu.addEventListener("result", remoteResult.onAddMenu);
			m_objRemote.addSub2Menu.addEventListener("result", remoteResult.onAddSub2Menu);
			m_objRemote.removeMenu.addEventListener("result", remoteResult.onRemoveMenu);
			
			m_objRemote.suspendMenu.addEventListener("result", remoteResult.onSuspendMenu);
			m_objRemote.suspendPost.addEventListener("result", remoteResult.onSuspendPost);
			
			m_objRemote.savePage.addEventListener("result", remoteResult.onSavedPage);
			m_objRemote.addPost.addEventListener("result", remoteResult.onAddedPost);
			
			m_objRemote.editPost.addEventListener("result", remoteResult.onEditedPost);
			m_objRemote.removePost.addEventListener("result", remoteResult.onRemovedPost);
			m_objRemote.sendMail.addEventListener("result", remoteResult.onSentMail);
			
			m_objRemote.editProduct.addEventListener("result", remoteResult.onEditedProduct);
			
			m_objRemote.saveProduct.addEventListener("result", remoteResult.onAddedProduct);
			
			m_objRemote.log.addEventListener("result", remoteResult.resultLog);
			m_objRemote.changePass2.addEventListener("result", remoteResult.resultChangePass2);
			
			m_objRemote.addEventListener("fault", remoteResult.onServiceFault);
			
		}
	}
}
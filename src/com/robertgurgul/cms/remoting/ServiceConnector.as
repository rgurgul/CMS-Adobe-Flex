package com.robertgurgul.cms.remoting 
{
	import com.robertgurgul.cms.classes.*;
	import com.robertgurgul.cms.model.*;
	import com.robertgurgul.cms.vo.ProductVo;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.utils.ArrayUtil;
	
	public class ServiceConnector extends EventDispatcher
	{
		private var m_objRemote:RemoteObject;
		private static var m_objServiceConnector:ServiceConnector;
		
		public static function getInstance():ServiceConnector
		{
			if(m_objServiceConnector == null)
				m_objServiceConnector = new ServiceConnector();
			
			return m_objServiceConnector;
		}
		
		public function connect():void
		{
			m_objRemote = new RemoteObject();
			m_objRemote.source = "CMSService";
			m_objRemote.destination = "amfphp";
			
			m_objRemote.getPage.addEventListener("result", onGetPage);
			m_objRemote.getPosts.addEventListener("result", onGetPosts);
			m_objRemote.getPhotos.addEventListener("result", onGetPhotos);
			m_objRemote.getMenu.addEventListener("result", onGetMenu);
			m_objRemote.addMenu.addEventListener("result", onAddMenu);
			m_objRemote.addSub2Menu.addEventListener("result", onAddSub2Menu);
			m_objRemote.removeMenu.addEventListener("result", onRemoveMenu);
			m_objRemote.suspendMenu.addEventListener("result", onSuspendMenu);
			m_objRemote.suspendPost.addEventListener("result", onSuspendPost);
			m_objRemote.savePage.addEventListener("result", onSavedPage);
			m_objRemote.addPost.addEventListener("result", onAddedPost);
			m_objRemote.editPost.addEventListener("result", onEditedPost);
			m_objRemote.removePost.addEventListener("result", onRemovedPost);
			m_objRemote.sendMail.addEventListener("result", onSentMail);
			m_objRemote.editProduct.addEventListener("result", onEditedProduct);
			m_objRemote.saveProduct.addEventListener("result", onAddedProduct);
			m_objRemote.changePass2.addEventListener("result", resultChangePass2);
			m_objRemote.addEventListener("fault", onServiceFault);
			
		}
		
		//----------------------------------------------------------------------------------------------------------------------
		
		
		private function resultChangePass2(e:ResultEvent):void 
		{
			if(e.result > 0) 
			{
				Alert.show('hasło zostało zmienione');
			} else {
				Alert.show('nie znaleziono takiego użytkownika \rlub podane hasło jest identyczne z hasłem zapisanym w bazie');
			}
		}
		private function onSentMail(evt:ResultEvent):void
		{
			Alert.show('wiadomość wysłana, dziękujemy');
		}
		private function onGetPhotos(evt:ResultEvent):void
		{
			DataHolder.getInstance().dataPhotos = new ArrayCollection(ArrayUtil.toArray(evt.result[0]));
			DataHolder.getInstance().pdfs = new ArrayCollection(ArrayUtil.toArray(evt.result[1]));
		}
		private function onGetPage(evt:ResultEvent):void
		{
			var obj:ArrayCollection = evt.result as ArrayCollection;
			DataHolder.getInstance().dataPage = obj[0];
			dispatchEvent( new Event('onGetPage', true) );
			Utils.changeViewStack = 0;
			
			Controller.getInstance().btnSaveEnabled = true;
		}
		private function onGetPosts(evt:ResultEvent):void
		{
			for(var i:int = 0; i < evt.result.length; i++)
			{
				var post:ProductVo = new ProductVo();
				post.id = evt.result[i].id;
				post.img = evt.result[i].img;
				post.company = evt.result[i].company;
				post.title = evt.result[i].title;
				post.price = evt.result[i].price;
				post.descTLF = evt.result[i].descTLF;
				post.descHTML = evt.result[i].descHTML;
				post.sort = evt.result[i].order;
				DataHolder.getInstance().posts.addItem(post);
			}
			
			Controller.getInstance().btnSaveEnabled = false;
		}
		private function onGetMenu(evt:ResultEvent):void
		{
			DataHolder.getInstance().dataMenu.removeAll();
			var ac:ArrayCollection = new ArrayCollection(ArrayUtil.toArray(evt.result))[0];
			
			for each (var item2:Object in ac)
			{
				if(item2.kat1 != '')
				{			
					DataHolder.getInstance().dataMenu.addItem(new MenuItem(
						item2.id,
						item2.kat1,
						'kat1',
						item2.id_parent,
						item2.link,
						item2.kindCMS,
						item2.show_stat));
					
				} else if(item2.kat2 != '') 
				{
					var arr:ArrayCollection = new ArrayCollection(DataHolder.getInstance().dataMenu.source);
					arr.filterFunction = function(item:Object):Boolean{ return item['id'] == item2.id_parent }; //wybieram jednego z tym id == id_parent
					arr.refresh();
					var obj:MenuItem = arr[0] as MenuItem;
					item2.name = item2.kat2;
					item2.kat = 'kat2';
					item2.children = new ArrayCollection(); // dodaje kontener dla sub2
					
					obj.addChildren(item2);
					
				} else if(item2.kat3 != '') 
				{
					for each(var menu:Object in DataHolder.getInstance().dataMenu)
					{
						for each( var sub1:Object in menu.children)
						{
							if(sub1.id == item2.id_parent)
							{
								item2.name = item2.kat3;
								item2.kat = 'kat3';
								sub1.children.addItem(item2);
							}
						}
					}
				}
			}
			dispatchEvent( new Event('onGetMenu', true) );
		}
		private function onAddMenu(evt:ResultEvent):void
		{
			m_objRemote.getMenu();
			if(evt.result as Boolean)
				Alert.show('zakładka dodana');
			else 
				Alert.show('taka zakładka już istnieje');
		}
		private function onAddSub2Menu(evt:ResultEvent):void
		{
			m_objRemote.getMenu();
			if(evt.result as Boolean)
				Alert.show('zakładka dodana');
			else 
				Alert.show('taka zakładka już istnieje');
		}
		private function onRemoveMenu(evt:ResultEvent):void
		{
			m_objRemote.getMenu();
			Alert.show('zakładka usunięta');
		}
		private function onSuspendMenu(evt:ResultEvent):void
		{
			m_objRemote.getMenu();
			Alert.show('status zakladki zmieniony');
		}
		private function onSuspendPost(evt:ResultEvent):void
		{
			Alert.show('status postu zmieniony');
		}	
		private function onSavedPage(evt:ResultEvent):void
		{
			m_objRemote.getMenu();
			Alert.show('strona zapisana');
		}
		private function onAddedPost(evt:ResultEvent):void
		{
			Alert.show('post dodany');
		}
		private function onEditedPost(evt:ResultEvent):void
		{
			Alert.show('post zmieniony');
		}
		private function onRemovedPost(evt:ResultEvent):void
		{
			m_objRemote.getPosts(DataHolder.getInstance().currentPage.id);
			Alert.show('post usunięty');
		}
		private function onAddedProduct(evt:ResultEvent):void
		{
			Alert.show('produkt dodany');
			m_objRemote.getPosts(0);
		}	
		private function onEditedProduct(evt:ResultEvent):void
		{
			Alert.show('produkt zaktualizowany');
			m_objRemote.getPosts(0);
		}
		private function onServiceFault(evt:FaultEvent):void
		{
			Alert.show("Cannot connect to Webservice, Please check your configuration settings!", "Error");
		}
	}
}
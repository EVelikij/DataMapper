package com.datamapper.system.reflection
{

import com.datamapper.system.reflection.factory.MetadataFactory;

import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;

/**
   * Класс объектного представляет матаданных
   * @author Evgenij Welikij
   * 
   */  
  public class MetadataTypeDescriptor
  {
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------
    public function MetadataTypeDescriptor(describleTypeXML:XML)
    {
      _description = describleTypeXML;
      
      describe();
    }
    
    
    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------
    /**
     * XML описание типа 
     */    
    private var _description:XML;
    
    /**
     * Тип объекта 
     */    
    private var _type:Class;
    
    /**
     * полное имя класса
     */
    private var _className:String;
    
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    public var metadataHosts:Dictionary;
    
    public var methodInfo:Dictionary;
    
    public function get description():XML { return _description; }
    
    
    //--------------------------------------------------------------------------
    //
    //  Public methods
    //
    //--------------------------------------------------------------------------
    /**
     * Содержит ли host-объект метатег с указанным типом 
     * 
     * @param metadataTagName имя метатега
     * @return флаг указывающий на присутствие метатега
     * 
     */    
    public function hasMetadataTag(metadataTagName:String):Boolean
    {
      for each (var metadataHost:IMetadataHost in metadataHosts)
      {
        for each (var metadataTag:IMetadataTag in metadataHost.metadataTags)
        {
          if (metadataTag.name.toLowerCase() == metadataTagName.toLowerCase())
            return true;
        }
      }
      
      return false;
    }
    
    /**
     * Получить хост объекта для метатега
     *  
     * @param metadataTagName
     * @return 
     * 
     */    
    public function getMetadataHostsWithTags(metadataTagName:String):Array
    {
      var hosts:Array = [];
      
      for each( var metadataHost:IMetadataHost in metadataHosts )
      {
        for each( var metadataTag:IMetadataTag in metadataHost.metadataTags )
        {
          if( metadataTag.name.toLowerCase() == metadataTagName.toLowerCase() )
          {
            hosts.push( metadataHost );
            continue;
          }
        }
      }
      
      return hosts;
    }
    
    
    /**
     * Потучить метаданные по имени метатега
     * @param tagName
     * @return 
     * 
     */    
    public function getMetadataTagsByName(tagName:String):Array
    {
      var tags:Array = [];
      
      for each( var metadataHost:IMetadataHost in metadataHosts )
      {
        for each( var metadataTag:IMetadataTag in metadataHost.metadataTags )
        {
          if( metadataTag.name.toLowerCase() == tagName.toLowerCase() )
          {
            tags.push(metadataTag);
          }
        }
      }
      
      return tags;
    }
    
    /**
     * Получить метатеги для host-комопнента  
     * @param memberName
     * @return 
     * 
     */    
    public function getMetadataTagsForMember(memberName:String):Array
    {
      var tags:Array;
      
      for each( var metadataHost:IMetadataHost in metadataHosts )
      {
        if( metadataHost.name == memberName )
        {
          tags = metadataHost.metadataTags;
        }
      }
      
      return tags;
    }
    
    /**
     * Полуить  метаданные для всех свойств
     * @return 
     * 
     */    
    public function getMetadataHostProperties():Array
    {
      var hostProps:Array = [];
      
      for each( var metadataHost:IMetadataHost in metadataHosts )
      {
        if( metadataHost is MetadataHostProperty )
        {
          hostProps.push( metadataHost );
        }
      }
      
      return hostProps;
    }
    
    /**
     * Получить метаданные для всех методов
     */    
    public function getMetadataHostMethods():Array
    {
      var hostMethods:Array = [];
      
      for each( var metadataHost:IMetadataHost in metadataHosts )
      {
        if( metadataHost is MetadataHostMethod )
        {
          hostMethods.push( metadataHost );
        }
      }
      
      return hostMethods;
    }
    
    public function getMethodInfo(methodName:String):MetadataHostMethod
    {
      if ( metadataHosts[methodName] is MetadataHostMethod && 
          (metadataHosts[methodName] as MetadataHostMethod).name == methodName)
        return metadataHosts[methodName];
      
      if ( methodInfo.hasOwnProperty( methodName))
        return methodInfo[methodName];
      
      var methodNodes:XMLList = description..method.(String(@name) == methodName);
      
      if (methodNodes.length())
      {
        return methodInfo[ methodName ] = MetadataFactory.getMetadataHost(methodNodes[0]);
      }
        
      return null;
    }
    
    public function getHostPropertyType(prop:String):Class
    {
      var type:Class;
      var propNodes:XMLList = description..accessor.(String(@name) == prop);
      if (prop.length)
        type = getDefinitionByName(XML(propNodes[0]).@type) as Class;
        return type;
    }
    
    
    //--------------------------------------------------------------------------
    //
    //  Utils
    //
    //-------------------------------------------------------------------------
    private function describe():void
    {
      var classDescription:XML = null;
      
      if (_description.factory == undefined )
      {
        classDescription = _description;
        _className = classDescription.@name;
      }
      else
      {
        classDescription = _description.factory[0];
        _className = classDescription.@type;
      }
      
      _type = getDefinitionByName(_className) as Class;
      metadataHosts = getMetadataHosts(_description);
      methodInfo = new Dictionary();
    }
    
    protected function getMetadataHosts(description:XML):Dictionary
    {
      if (metadataHosts != null)
        return metadataHosts;
      
      metadataHosts = new Dictionary();   
      
      for each( var mdNode:XML in description..metadata )
      {
        var metadataTag:IMetadataTag = MetadataFactory.getMetadataTag(mdNode);
        
        if (metadataTag)
        {
          var host:IMetadataHost = getMetadataHost( mdNode.parent() );
          
          metadataTag.host = host;
          host.metadataTags.push( metadataTag );
        }
      }
      
      return metadataHosts;
    }
    
    protected function getMetadataHost( hostNode:XML ):IMetadataHost
    {
      var metadataHostName:String = hostNode.@name.toString();
      
      if( metadataHosts[ metadataHostName ] != null )
        return IMetadataHost( metadataHosts[ metadataHostName ] );
      
      return metadataHosts[ metadataHostName ] = MetadataFactory.getMetadataHost(hostNode);
    }
  }
}
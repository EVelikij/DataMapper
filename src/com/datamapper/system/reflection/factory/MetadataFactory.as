package com.datamapper.system.reflection.factory
{
import com.datamapper.system.MetadataNames;
import com.datamapper.system.reflection.IMetadataHost;
import com.datamapper.system.reflection.IMetadataTag;
import com.datamapper.system.reflection.MetadataArgument;
import com.datamapper.system.reflection.MetadataHostClass;
import com.datamapper.system.reflection.MetadataHostMethod;
import com.datamapper.system.reflection.MetadataHostProperty;
import com.datamapper.system.reflection.MetadataTag;
import com.datamapper.system.reflection.MethodParameter;

import flash.utils.getDefinitionByName;

/**
   * Фабрика для создания reflection-объектов 
   * @author Evgenij Welikij
   * 
   */  
  public class MetadataFactory
  { 
    private static var registredMatadataTags:Array = [MetadataNames.ID,
                                                      MetadataNames.FOREIGN_KEY];
    
    
    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------
    public static function registerMetadata(metadataName:String):void
    {
      if (registredMatadataTags.indexOf(metadataName) == -1)
        registredMatadataTags.push(metadataName);
    }
    
    
    /**
     * Создает новый <code>IMetadataHost</code> объект
     * 
     * @param hostNode дочерний улемент XML из метода <code>describeType</code>
     * 
     */    
    public static function getMetadataHost( hostNode:XML):IMetadataHost
    {
      var host:IMetadataHost;
      
      // property, method or class?
      var hostKind:String = hostNode.name();
      
      if( hostKind == "type" || hostKind == "factory" )
      {
        host = new MetadataHostClass();
        if( hostKind == "type" )
          host.type = getDefinitionByName( hostNode.@name.toString() ) as Class;
        else
          host.type = getDefinitionByName( hostNode.@type.toString() ) as Class;
      }
      else if( hostKind == "method" )
      {
        host = new MetadataHostMethod();
        
        if( hostNode.@returnType != "void" && hostNode.@returnType != "*" )
        {
          MetadataHostMethod( host ).returnType = Class( getDefinitionByName( hostNode.@returnType ) );
        }
        MetadataHostMethod( host ).asterix = hostNode.@returnType == "*"
        
        for each( var pNode:XML in hostNode.parameter )
        {
          var pType:Class = pNode.@type == "*" ? Object : Class( getDefinitionByName( pNode.@type ) );
          MetadataHostMethod( host ).parameters.push( new MethodParameter( int( pNode.@index ), pType, pNode.@optional == "true" ) );
        }
      }
      else
      {
        host = new MetadataHostProperty();
        host.type = hostNode.@type == "*" ? Object : Class( getDefinitionByName( hostNode.@type ) );
      }
      
      host.name = ( hostNode.@uri == undefined ) ? String( hostNode.@name[ 0 ] ) : new QName( hostNode.@uri, hostNode.@name ).toString();
      
      return host;
    }
    
    
    /**
     * Создает новый <code>IMetadataTag</code> объект
     * 
     * @param metadataNode дочерний улемент XML из метода <code>describeType</code>
     * 
     */   
    public static function getMetadataTag(metadataNode:XML):IMetadataTag
    {
      var metadataName:String = metadataNode.@name;
      
      if (registredMatadataTags.indexOf(metadataName) == -1)
        return null;
      
      var args:Array = [];
      for each( var argNode:XML in metadataNode.arg )
        args.push( new MetadataArgument( argNode.@key.toString(), argNode.@value.toString() ) );
            
      var metadataTag:IMetadataTag = new MetadataTag();
      metadataTag.name = metadataName;
      metadataTag.args = args;
     
      return metadataTag;
    }
  }
}
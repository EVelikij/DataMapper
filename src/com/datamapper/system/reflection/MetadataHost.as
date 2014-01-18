package com.datamapper.system.reflection
{
  /**
   * Базовая реализация интерфейса <code>IMetadataHost</code>
   * 
   * @author Evgenij Welikij
   * 
   */  
  public class MetadataHost implements IMetadataHost
  {
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------
    public function MetadataHost()
    {
      _metadataTags = [];
    }
    
    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------
    /**
     * переменная для хранения значения свойства <code>name</code>
     *  
     * @private 
     */    
    private var _name:String;
    
    /**
     * переменная для хранения значения свойства <code>type</code>
     *  
     * @private 
     */    
    private var _type:Class;
    
    /**
     * переменная для хранения значения свойства <code>metadataTags</code>
     *  
     * @private 
     */    
    private var _metadataTags:Array;
    
    
    //--------------------------------------------------------------------------
    //
    //  IMetadataHost implementation
    //
    //--------------------------------------------------------------------------    
    public function get name():String
    {
      return _name;
    }
    
    public function set name(value:String):void
    {
      if (value == _name)
        return;
      
      _name = value;
    }
    
    public function get type():Class
    {
      return _type;
    }
    
    public function set type(value:Class):void
    {
      if (value == _type)
        return;
      
      _type = value;
    }
    
    [ArrayElementType("com.ia.mobile.core.common.reflection.IMetadataTag")]
    public function get metadataTags():Array
    {
      return _metadataTags;
    }
    
    public function set metadataTags(value:Array):void
    {
      if (value == _metadataTags)
        return;
      
      _metadataTags = value;
    }
    
    public function hasMetadataTag(name:String):Boolean
    {
      return getMetadataTag(name) != null;
    }
     
    public function getMetadataTag(name:String):IMetadataTag
    {
      for each (var tag:IMetadataTag in metadataTags)
      {
        if (tag.name == name)
          return tag;
      }
      return null;
    }
  }
}
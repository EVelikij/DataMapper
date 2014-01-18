package com.datamapper.system.reflection
{
  /**
   * Простая реализация интерфейса <code>IMetadataArgument</code>.
   * 
   * @author Evgenij Welikij
   * 
   */  
  public class MetadataArgument implements IMetadataArgument
  {
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------
    public function MetadataArgument(key:String, value:String)
    {
      this.key = key;
      this.value = value;
    }
    
    
    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------
    /**
     * переменная для хранения значения свойства <code>key</code>
     *   
     * @private 
     */    
    private var _key:String;
    
    /**
     * переменная для хранения значения свойства <code>value</code>
     * 
     * @private 
     */    
    private var _value:String;
    
    
    //--------------------------------------------------------------------------
    //
    //  IMetadataArgument implementation
    //
    //--------------------------------------------------------------------------
    public function get key():String
    {
      return _key;
    }
    
    public function set key(value:String):void
    {
      if (value == _key)
        return;
      
      _key = value;
    }
    
    public function get value():String
    {
      return _value;
    }
    
    public function set value(value:String):void
    {
      if (value == _value)
        return;
      
      _value = value;
    }
    
    public function toString():String
    {
      return "MetadataArg: " + key + " = " + value;
    }
    
  }
}
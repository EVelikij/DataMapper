package com.datamapper.system.reflection
{
  /**
   * Базовая реализация интерфейса <code>IMetadataTag</code>
   *  
   * @author Evgenij Welikij
   * 
   */  
  public class MetadataTag implements IMetadataTag
  { 
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
     * переменная для хранения значения свойства <code>args</code>
     *  
     * @private 
     */    
    private var _args:Array;
    
    /**
     * переменная для хранения значения свойства <code>host</code>
     *  
     * @private 
     */    
    private var _host:IMetadataHost;
    
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    //----------------------------------
    //  defaultArgName
    //----------------------------------
    /**
     * переменная для хранения значения свойства <code>defaultArgName</code>
     *  
     * @private 
     */ 
    private var _defaultArgName:String;
    
    /**
     *  Имя аргумента в метатеге используемого по умолчанию
     *  (напр. "event" для [Bindable("myEvent")])
     */    
    public function get defaultArgName():String { return _defaultArgName; }
    
    public function set defaultArgName(value:String):void
    {
      if (_defaultArgName == value)
        return;
      _defaultArgName = value;
    }
    
    
    //--------------------------------------------------------------------------
    //
    //  IMetadataTag
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
    
    [ArrayElementType("com.ia.mobile.core.common.reflection.IMetadataArgument")]
    public function get args():Array
    {
      return _args;
    }
    
    public function set args(value:Array):void
    {
      if (value == _args)
        return;
      
      _args = value;
    }
    
    public function get host():IMetadataHost
    {
      return _host;
    }
    
    public function set host(value:IMetadataHost):void
    {
      if (value == _host)
        return;
      
      _host = value;
    }
    
    public function hasArg(argName:String):Boolean
    {
      return getArg(argName) != null;
    }
    
    public function getArg(argName:String):IMetadataArgument
    {
      for each (var arg:IMetadataArgument in args)
      {
        if (arg.key == argName || (arg.key == "" && argName == defaultArgName))
          return arg;
      }
      return null;
    }
    
    public function toString():String
    {
      var str:String = "[" + name;
      
      if (args && args.length)
      {
        str += "(";
        for (var i:int = 0; i < args.length; i++)
        {
          var arg:IMetadataArgument = args[i];
          
          if (arg.key != "")
            str += arg.key + "=";
          
          str += '"' + arg.value + '"';
          
          if ( i + 1 < args.length)
            str += ", ";
        }
        str += ")";
      }
      
      return str + "]";
    }
  }
}
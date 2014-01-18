package com.datamapper.system.reflection
{
  /**
   * Интерфейс ключ/значение представляющий аргумент метаданных
   * 
   * @author Evgenij Welikij
   * 
   */  
  public interface IMetadataArgument
  {
    /**
     *  Имя аргумента в метаданных (нарп. "event" в [Bindable(event="myEvent")] )
     */    
    function get key():String;
    function set key(value:String):void;
    
    /**
     *  Значение аргумента в метаданных (нарп. "myEvent" в [Bindable(event="myEvent")] )
     */
    function get value():String;
    function set value(value:String):void;
    
    function toString():String;
  }
}
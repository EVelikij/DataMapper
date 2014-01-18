package com.datamapper.system.reflection
{
  /**
   * Интерфейс представления метатега
   *   
   * @author Evgenij Welikij
   * 
   */  
  public interface IMetadataTag
  {
    /**
     * Имя тега метаданных (нарп. "Bindable" в [Bindable(event="myEvent")] ) 
     */    
    function get name():String;
    function set name(value:String):void;
    
    [ArrayElementType("com.ia.mobile.core.common.reflection.IMetadataArgument")]
    /**
     * Масив аргументов определенных в метатеге 
     */    
    function get args():Array;
    function set args(value:Array):void;
    
    /**
     * Елемент (класс, метод, свойство) для которого определен метатег
     */    
    function get host():IMetadataHost;
    function set host(value:IMetadataHost):void;
    
    /**
     * Проверяет наличие аргумента в метатеге
     *  
     * @param argName имя апроверяемого аргумента
     * @return флаг указывающий на присутствие аргумента в метатеге
     * 
     */    
    function hasArg(argName:String):Boolean;
    
    /**
     * Возвращает метааргумент с указанным именем
     * 
     * @param argName имя метааргумента
     * @return аргумент с указанным именем или <code>null</code>
     * 
     */    
    function getArg(argName:String):IMetadataArgument;
    
    function toString():String;
  }
}
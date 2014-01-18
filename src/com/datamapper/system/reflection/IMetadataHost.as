package com.datamapper.system.reflection
{
import com.ia.nucleus.system.reflection.*;
  /**
   * Интерфейс представляет  public-свойство, метод или класс
   * к которым присоеденены метаданные
   * 
   * @author Evgenij Welikij
   * 
   */  
  public interface IMetadataHost
  {
    /**
     * Имя класса, метода или свойства  
     */    
    function get name():String;
    function set name(value:String):void;
    
    /**
     * Тип класса, метода или свойства 
     */    
    function get type():Class;
    function set type(value:Class):void;
    
    
    [ArrayElementType("com.ia.mobile.core.common.reflection.IMetadataTag")]
    /**
     * Масив прикрепленных метааргументов 
     */    
    function get metadataTags():Array;
    function set metadataTags(value:Array):void;
    
    /**
     * Проверяем наличие метатега у <code>host</code>-объекта
     * 
     * @param name имя метатега
     * @return флаг указывающий на присутствие метатега
     * 
     */    
    function hasMetadataTag(name:String):Boolean;
    
    /**
     * Возворащает метатег с указанным именем
     * 
     * @param name имя метатега
     * @return мататег с указанным именем
     * 
     */    
    function getMetadataTag(name:String):IMetadataTag;
  }
}
package com.datamapper.system.reflection
{
import com.ia.nucleus.system.reflection.*;
  import flash.utils.Dictionary;
  import flash.utils.describeType;
  import flash.utils.getQualifiedClassName;

  /**
   * Статический интерфейс для метода <code>describeType</code>
   * 
   * @author Evgenij Welikij
   * 
   */  
  public class DescribeType
  {
    //--------------------------------------------------------------------------
    //
    //  Class variables
    //
    //--------------------------------------------------------------------------
    /**
     * Хешируем дескрипторы 
     */    
    private static var descriptors:Dictionary;
    
    
    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------    
    /**
     * Получить дескриптор для объекта 
     * @param target целевой объект для дескриптора
     * @return 
     * 
     */    
    public static function getDescriptor(target:Object):MetadataTypeDescriptor
    {
      descriptors ||= new Dictionary();
      
      var className:String = getQualifiedClassName( target );
      if( descriptors[ className ] != null )
         return descriptors[ className ];
      
      return descriptors[ className ] = new MetadataTypeDescriptor(describeType(target));
    }
    
    /**
     * Сброс хеша 
     */    
    public static function reset():void
    {
      for ( var key:Object in descriptors )
        delete descriptors[ key ];
    }
      
  }
}
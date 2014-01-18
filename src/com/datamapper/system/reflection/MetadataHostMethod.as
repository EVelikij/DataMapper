package com.datamapper.system.reflection
{
import com.ia.nucleus.system.reflection.*;
  /**
   * Представление метода обернутого метатегами
   * 
   * @author Evgenij Welikij
   * 
   */  
  public class MetadataHostMethod extends MetadataHost
  {
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    //----------------------------------
    //  returnType
    //----------------------------------
    /**
     * переменная для хранения значения свойства <code>returnType</code>
     *  
     * @private 
     */     
    private var _returnType:Class;
    
    /**
     * Тип возвращаемого значения методом (null, если метод возвращает <code>void</code>).
     */    
    public function get returnType():Class { return _returnType; }
    
    public function set returnType(value:Class):void
    {
      if (_returnType == value)
        return;
      _returnType = value;
    }
    
    private var _asterix:Boolean = false;
    public function get asterix():Boolean { return _asterix; }
    
    public function set asterix(value:Boolean):void
    {
      if (_asterix == value)
        return;
      _asterix = value;
    }
    
    //----------------------------------
    //  parameters
    //----------------------------------
    /**
     * переменная для хранения значения свойства <code>parameters</code>
     *  
     * @private 
     */ 
    private var _parameters:Array = [];
    
    [ArrayElementType("com.datamapper.system.reflection.MethodParameter")]
    /**
     *  Массив параметров метода 
     */    
    public function get parameters():Array { return _parameters; }
    
    public function set parameters(value:Array):void
    {
      if (_parameters == value)
        return;
      _parameters = value;
    }
    
    /**
     *  Общее кол-во параметров метода 
     */    
    public function get parameterCount():int
    {
      return _parameters.length;
    }
    
    /**
     *  Обязательное кол-во параметров
     */    
    public function get requiredParameterCount():int
    {
      var required:int = 0;
      
      for each (var param:MethodParameter in parameters)
        required += !param.optional ? 1 : 0;
      
      return required;
    }
    
  }
}
package com.datamapper.system.reflection
{
  /**
   * Класс описывает параметр метода
   *  
   * @author Evgenij Welikij
   * 
   */  
  public class MethodParameter
  {
    //--------------------------------------------------------------------------
    //
    //  Cosntructor
    //
    //--------------------------------------------------------------------------
    public function MethodParameter(index:int, type:Class, optional:Boolean = true)
    {
      this.index = index;
      this.type = type;
      this.optional = optional;
    }
    
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    /**
     * Индекс параметра в сигнатуре метода
     */    
    public var index:int;
    
    /**
     * Тип параметра в сигнатуре метода
     */    
    public var type:Class;
    
    /**
     * Флагт указывающий на опциональный параметр
     */    
    public var optional:Boolean;
  }
}
/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 19.01.14
 * Time: 16:50
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.errors
{
import avmplus.getQualifiedClassName;

import flash.net.NetStreamInfo;

import mx.utils.StringUtil;

public class DataMapError extends Error
{
  //--------------------------------------------------------------------------
  //
  //  Class constants
  //
  //--------------------------------------------------------------------------
  public static const INNER_KEY_EXIST_TEMPLATE:String = "There is no [Id] property for type {0}.";
  public static const MANY_INNER_KEY_TEMPLATE:String = "There are more that one [Id] property for type {0}.";
  public static const FOREIGN_KEY_TYPE_TEMPLATE:String = "There is no type for [ForeignKey] in {0} property for type {1}.";
  public static const MANY_FOREIGN_KEYS_TEMPLATE:String = "There are more that one [ForeignKey] for type {0} in {1}.";


  //--------------------------------------------------------------------------
  //
  //  Class methods
  //
  //--------------------------------------------------------------------------
  public static function innerKeyExist(type:Class):DataMapError
  {
    // build message string
    var message:String = StringUtil.substitute(INNER_KEY_EXIST_TEMPLATE, getQualifiedClassName(type));
    return new DataMapError(message);
  }

  public static function manyInnerKey(type:Class):DataMapError
  {
    var message:String = StringUtil.substitute(MANY_INNER_KEY_TEMPLATE, getQualifiedClassName(type));

    return new DataMapError(message);
  }

  public static function foreignKeyType(property:String, type:Class):DataMapError
  {
    var message:String = StringUtil.substitute(FOREIGN_KEY_TYPE_TEMPLATE,
            property,
            getQualifiedClassName(type));

    return new DataMapError(message);
  }

  public static function manyForeignKeys(foreignKeyType:String, type:Class):DataMapError
  {
    var message:String = StringUtil.substitute(MANY_FOREIGN_KEYS_TEMPLATE,
            foreignKeyType,
            getQualifiedClassName(type));

    return new DataMapError(message);
  }



  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function DataMapError(message:String)
  {
    super(message);
  }
}
}

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
  public static const KEY_EXIST_ERROR_TEMPLATE:String = "There is no [Id] property for type {0}.";
  public static const MANY_KEY_ERROR_TEMPLATE:String = "There is more that one [Id] property for type {0}.";


  //--------------------------------------------------------------------------
  //
  //  Class methods
  //
  //--------------------------------------------------------------------------
  public static function innerKeyExistError(type:Class):DataMapError
  {
    // build message string
    var message:String = StringUtil.substitute(KEY_EXIST_ERROR_TEMPLATE, getQualifiedClassName(type));
    return new DataMapError(message);
  }

  public static function manyKeyError(type:Class):DataMapError
  {
    var message:String = StringUtil.substitute(MANY_KEY_ERROR_TEMPLATE, getQualifiedClassName(type));

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

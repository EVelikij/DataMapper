/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 01.02.14
 * Time: 19:15
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.errors
{
import avmplus.getQualifiedClassName;

import com.datamapper.system.MetadataNames;
import com.datamapper.system.MetadataTagArguments;

import mx.utils.StringUtil;

public class DataPointError extends Error
{
  //--------------------------------------------------------------------------
  //
  //  Class constants
  //
  //--------------------------------------------------------------------------
  public static const NO_TYPE_ARGUMENT_TEMPLATE:String = "[{0}] attribute doesn't have " + MetadataTagArguments.TYPE
          + " argument for type {1}.";


  //--------------------------------------------------------------------------
  //
  //  Class methods
  //
  //--------------------------------------------------------------------------
  public static function noTypeForHasMany(type:Class):DataPointError
  {
    var message:String = StringUtil.substitute(NO_TYPE_ARGUMENT_TEMPLATE, MetadataNames.HAS_MANY, getQualifiedClassName(type));

    return new DataPointError(message);
  }

  public static function noTypeForHasAndBelongsToMany(type:Class):DataPointError
  {
    var message:String = StringUtil.substitute(NO_TYPE_ARGUMENT_TEMPLATE, MetadataNames.HAS_AND_BELONGS_TO_MANY,
            getQualifiedClassName(type));

    return new DataPointError(message);
  }


  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function DataPointError(message:String)
  {
    super(message);
  }
}
}

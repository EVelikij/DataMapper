/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 04.02.14
 * Time: 0:20
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.errors
{
import avmplus.getQualifiedClassName;

import mx.utils.StringUtil;

public class RepositoryError extends Error
{
  //--------------------------------------------------------------------------
  //
  //  Class constants
  //
  //--------------------------------------------------------------------------
  public static const REPOSITORY_EXIT_TEMPLATE:String = "Repository for type {0} already exist in the DataSource.";


  //--------------------------------------------------------------------------
  //
  //  Class methods
  //
  //--------------------------------------------------------------------------
  public static function repositoryExist(type:Class):RepositoryError
  {
    var msg:String = StringUtil.substitute(REPOSITORY_EXIT_TEMPLATE, getQualifiedClassName(type));

    return new RepositoryError(msg);
  }


  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function RepositoryError(message:String)
  {
    super(message);
  }
}
}

/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 04.02.14
 * Time: 0:20
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.errors
{

import flash.utils.getQualifiedClassName;

import mx.utils.StringUtil;

public class RepositoryError extends Error
{
  //--------------------------------------------------------------------------
  //
  //  Class constants
  //
  //--------------------------------------------------------------------------
  public static const REPOSITORY_EXIT_TEMPLATE:String = "Repository for type {0} already exist in the DataSource.";
  public static const ENTITY_TYPE_TEMPLATE:String = "Item of {0} type could no exist in repository for type {1}.";
  public static const ENTITY_WITH_ID_TEMPLATE:String = "Item with [Id] {0} already exist in repository for type {1}.";


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

  public static function wrongEntityType(entity:*, repositoryType:Class):RepositoryError
  {
    var msg:String = StringUtil.substitute(ENTITY_TYPE_TEMPLATE, getQualifiedClassName(entity), getQualifiedClassName(repositoryType));

    return new RepositoryError(msg);
  }

  public static function entityWithIdExist(id:String, repositoryType:Class):RepositoryError
  {
    var msg:String = StringUtil.substitute(ENTITY_WITH_ID_TEMPLATE, id, getQualifiedClassName(repositoryType));

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

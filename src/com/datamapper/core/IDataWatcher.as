/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 18.01.14
 * Time: 21:12
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.core
{
public interface IDataWatcher
{
  function belongsTo(association:IAssociation):void;

  function hasOne(association:IAssociation):void;

  function hasMany(association:IAssociation):void;

  function hasAndBelongsToMany(association:IAssociation):void;
}
}

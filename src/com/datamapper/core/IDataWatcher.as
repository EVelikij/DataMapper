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
  function belongsTo(association:IAssociation);

  function hasOne(association:IAssociation);

  function hasMany(association:IAssociation);

  function hasAndBelongsToMany(association:IAssociation);
}
}

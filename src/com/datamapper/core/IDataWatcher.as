/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 18.01.14
 * Time: 21:12
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.core
{
import com.datamapper.impl.associations.BelongsTo;
import com.datamapper.impl.associations.HasAndBelongsToMany;
import com.datamapper.impl.associations.HasMany;
import com.datamapper.impl.associations.HasOne;

public interface IDataWatcher
{
  function belongsTo(association:BelongsTo):void;

  function hasOne(association:HasOne):void;

  function hasMany(association:HasMany):void;

  function hasAndBelongsToMany(association:HasAndBelongsToMany):void;
}
}

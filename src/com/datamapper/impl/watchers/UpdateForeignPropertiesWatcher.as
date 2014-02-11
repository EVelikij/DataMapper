/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 10.02.14
 * Time: 22:45
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.watchers
{
import com.datamapper.core.IRepository;
import com.datamapper.impl.associations.BelongsTo;
import com.datamapper.impl.associations.HasAndBelongsToMany;
import com.datamapper.impl.associations.HasMany;
import com.datamapper.impl.associations.HasOne;

public class UpdateForeignPropertiesWatcher extends BaseDataWatcher
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function UpdateForeignPropertiesWatcher(repository:IRepository, item:*, foreignInstance:*)
  {
    super(repository, item);

    this.foreignInstance = foreignInstance;
  }

  private var foreignInstance:*;


  //--------------------------------------------------------------------------
  //
  //  Overridden methods
  //
  //--------------------------------------------------------------------------
  override public function belongsTo(association:BelongsTo):void
  {
    item[association.point.property.name] = foreignInstance;
  }

  override public function hasOne(association:HasOne):void
  {
    item[association.point.property.name] = foreignInstance;
  }

  override public function hasMany(association:HasMany):void
  {
    addAssociatedItems(association.point, [foreignInstance]);
  }

  override public function hasAndBelongsToMany(association:HasAndBelongsToMany):void
  {
  }
}
}

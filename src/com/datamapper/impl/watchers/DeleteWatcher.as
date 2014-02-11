/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 12.02.14
 * Time: 0:48
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.watchers
{
import com.datamapper.core.IRepository;
import com.datamapper.impl.associations.BelongsTo;
import com.datamapper.impl.associations.HasAndBelongsToMany;
import com.datamapper.impl.associations.HasMany;
import com.datamapper.impl.associations.HasOne;

public class DeleteWatcher extends BaseDataWatcher
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function DeleteWatcher(repository:IRepository, item:*)
  {
    super(repository, item);
  }


  //--------------------------------------------------------------------------
  //
  //  Overridden methods
  //
  //--------------------------------------------------------------------------
  override public function belongsTo(association:BelongsTo):void
  {
  }

  override public function hasOne(association:HasOne):void
  {
    var propName:String = association.point.property.name;
    association.destination.updateAssociations(item, [item[propName]], true);
    item[propName] = null;
  }

  override public function hasMany(association:HasMany):void
  {
  }

  override public function hasAndBelongsToMany(association:HasAndBelongsToMany):void
  {
  }
}
}

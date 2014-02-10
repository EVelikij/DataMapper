/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 09.02.14
 * Time: 18:31
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.watchers
{
import com.datamapper.core.IAssociation;
import com.datamapper.core.IDataPoint;
import com.datamapper.core.IDataWatcher;
import com.datamapper.core.IRepository;
import com.datamapper.core.IRepository;
import com.datamapper.impl.associations.BelongsTo;
import com.datamapper.impl.associations.HasAndBelongsToMany;
import com.datamapper.impl.associations.HasMany;
import com.datamapper.impl.associations.HasOne;
import com.datamapper.system.reflection.MetadataHostProperty;

import mx.collections.ArrayCollection;

public class BaseDataWatcher implements IDataWatcher
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function BaseDataWatcher(repository:IRepository, item:*)
  {
    this.repository = repository;
    this.item = item;
  }


  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  protected var repository:IRepository;
  protected var item:*;


  //--------------------------------------------------------------------------
  //
  //  IDataWatcher implementation
  //
  //--------------------------------------------------------------------------
  public function belongsTo(association:BelongsTo):void
  {
  }

  public function hasOne(association:HasOne):void
  {
  }

  public function hasMany(association:HasMany):void
  {
  }

  public function hasAndBelongsToMany(association:HasAndBelongsToMany):void
  {
  }


  //--------------------------------------------------------------------------
  //
  //  Utils
  //
  //--------------------------------------------------------------------------
  protected function getId():*
  {
    return repository.getInnerKeyValue(item);
  }

  protected function addAssociatedItems(point:IDataPoint, items:Array):void
  {
    var prop:MetadataHostProperty = point.property;

    switch (prop.type)
    {
      case Array:
              item[prop.name] ||= [];
              for each (var e:* in items)
                item[prop.name].push(e);
        break;

      case ArrayCollection:
              item[prop.name] ||= new ArrayCollection();

              for each (e in items)
                ArrayCollection(item[prop.name]).addItem(e);
        break;
    }
  }

}
}

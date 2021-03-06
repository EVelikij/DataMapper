/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 09.02.14
 * Time: 18:05
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.watchers
{
import com.datamapper.core.IAssociation;
import com.datamapper.core.IRepository;
import com.datamapper.core.IRepository;
import com.datamapper.impl.associations.BelongsTo;
import com.datamapper.impl.associations.HasAndBelongsToMany;
import com.datamapper.impl.associations.HasMany;
import com.datamapper.impl.associations.HasOne;
import com.datamapper.system.reflection.MetadataHostProperty;
import com.datamapper.system.reflection.MetadataHostProperty;

public class InsertDataWatcher extends BaseDataWatcher
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function InsertDataWatcher(repository:IRepository, item:*)
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
    var destinationItems:Array = association.destination.getByForeignKey(item);

    if (destinationItems.length)
    {
      item[association.point.property.name] = destinationItems[0];
      association.destination.updateAssociations(item, destinationItems);
    }
  }

  override public function hasOne(association:HasOne):void
  {
    // свойсво с внешним ключом для указанной ассоциации
    var foreignKeyProperty:MetadataHostProperty = repository.map.getForeignKeyFor(association.point.sourceType);
    var foreignKeyId:* = item[foreignKeyProperty.name];         //  значение внешнего ключа
    var associatedItem:* = association.destination.getItemById(foreignKeyId);

    if (associatedItem != null)
    {
      item[association.point.property.name] = associatedItem;

      association.destination.updateAssociations(item, [associatedItem]);
    }
  }

  override public function hasMany(association:HasMany):void
  {
    var destinationItems:Array = association.destination.getByForeignKey(item);
    addAssociatedItems(association.point, destinationItems);

    association.destination.updateAssociations(item, destinationItems);
  }

  override public function hasAndBelongsToMany(association:HasAndBelongsToMany):void
  {
    var foreignType:Class = association.point.destinationType;
    var foreignKeyProperty:MetadataHostProperty = repository.map.getForeignKeyFor(foreignType);
    var foreignRepository:IRepository = repository.dataSource.getRepositoryFor(foreignType);
    var foreignItems:Array = [];

    if (foreignKeyProperty)
    {
      var foreignIds:Array = item[foreignKeyProperty.name];


      for each (var id:* in foreignIds)
      {
        var foreign:* = foreignRepository.getItemById(id);

        if (foreign)
          foreignItems.push(foreign);

      }
    }
    else
      foreignItems = foreignRepository.getByForeignKey(item);

    addAssociatedItems(association.point, foreignItems);
    foreignRepository.updateAssociations(item, foreignItems);
  }

}
}

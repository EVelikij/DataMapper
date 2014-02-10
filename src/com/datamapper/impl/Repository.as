/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 04.02.14
 * Time: 0:40
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl
{
import com.datamapper.core.IAssociation;
import com.datamapper.core.IDataMap;
import com.datamapper.core.IDataSource;
import com.datamapper.core.IDataWatcher;
import com.datamapper.core.IRepository;
import com.datamapper.errors.RepositoryError;
import com.datamapper.impl.watchers.InsertDataWatcher;
import com.datamapper.impl.watchers.UpdateForeignPropertiesWatcher;
import com.datamapper.system.reflection.MetadataHostProperty;

import flash.events.EventDispatcher;

import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;
import mx.events.CollectionEventKind;

public class Repository extends EventDispatcher implements IRepository
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function Repository(source:ArrayCollection, type:Class, ds:DataSource)
  {
    super();

    this._source = source;
    this._type = type;
    this._ds = ds;

    _map = new DataMap(type, ds);
    _map.init();

    addEventsHandlers();
  }


  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var _source:ArrayCollection;
  private var _type:Class;
  private var _ds:DataSource;

  private var _map:DataMap;


  //--------------------------------------------------------------------------
  //
  //  IRepository implementation
  //
  //--------------------------------------------------------------------------
  public function get source():ArrayCollection { return _source; }

  public function get map():IDataMap { return _map; }

  public function get type():Class { return _type; }

  public function get dataSource():IDataSource { return _ds; }

  public function getItemById(id:*):*
  {
    var innerKeyName:String = map.id.name;

    // loop by each item in repository and check on inner key property exist
    for each (var item:* in _source)
    {
      if (item.hasOwnProperty(innerKeyName) && item[innerKeyName] == id)
        return item;
    }

    return null;
  }

  public function getInnerKeyValue(entity:*):*
  {
    if (entity.constructor != type)
      throw RepositoryError.wrongEntityType(entity, type);

    return entity[map.id.name];
  }

  public function getByForeignKey(entity:*):Array
  {
    var entityRepository:IRepository = _ds.getRepositoryFor(entity);
    var foreignKeyValue:* = entityRepository.getInnerKeyValue(entity);
    var foreignKeyProperty:MetadataHostProperty = map.getForeignKeyFor(entity);
    var result:Array = [];

    for each (var item:* in source)
    {
      if (item[foreignKeyProperty.name] == foreignKeyValue)
        result.push(item);
    }

    return result;
  }

  public function updateAssociations(foreignInstance:*, innerInstance:* = null):void
  {
    var type:Class = foreignInstance.constructor;
    var updatedItems:Array = innerInstance ? [innerInstance] : getByForeignKey(foreignInstance);

    if (updatedItems.length == 0)
      return;

    for each (var association:IAssociation in map.associations)
    {
      if (association.destination.type == type)
      {
        for each (var e:* in updatedItems)
        {
          var watcher:IDataWatcher = new UpdateForeignPropertiesWatcher(this, e, foreignInstance);
          association.accept(watcher);
        }
      }
    }
  }


  //--------------------------------------------------------------------------
  //
  //  Utils
  //
  //--------------------------------------------------------------------------
  private function addEventsHandlers():void
  {
    source.addEventListener(CollectionEvent.COLLECTION_CHANGE, source_collectionChangeHandler);
  }

  protected function itemsAdded(items:Array):void
  {
    for each (var item:* in items)
    {
      var watcher:IDataWatcher = new InsertDataWatcher(this, item);

      for each (var assoc:IAssociation in map.associations)
        assoc.accept(watcher);
    }

  }



  //--------------------------------------------------------------------------
  //
  //  Events handlers
  //
  //--------------------------------------------------------------------------
  protected function source_collectionChangeHandler(event:CollectionEvent):void
  {
    switch (event.kind)
    {
      case CollectionEventKind.ADD:
              itemsAdded(event.items);
        break;
    }
  }

}
}

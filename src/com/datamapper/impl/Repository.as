/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 04.02.14
 * Time: 0:40
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl
{
import com.datamapper.core.IDataMap;
import com.datamapper.core.IRepository;
import com.datamapper.errors.RepositoryError;

import flash.events.EventDispatcher;

import mx.collections.ArrayCollection;

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
}
}

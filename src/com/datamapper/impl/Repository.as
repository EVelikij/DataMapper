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

import flash.events.EventDispatcher;

import mx.collections.ArrayCollection;

public class Repository extends EventDispatcher implements IRepository
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function Repository(source:ArrayCollection)
  {
    super();

    this._source = source;
  }


  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var _source:ArrayCollection;



  //--------------------------------------------------------------------------
  //
  //  IRepository implementation
  //
  //--------------------------------------------------------------------------
  public function get source():ArrayCollection { return _source; }

  public function get map():IDataMap
  {
    return null;
  }

  public function get type():Class
  {
    return null;
  }

  public function getItemById(id:*):*
  {
    return null;
  }

  public function getInnerKeyValue(entity:*):*
  {
    return null;
  }
}
}

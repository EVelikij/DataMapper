/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 02.02.14
 * Time: 23:45
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.core
{
import flash.events.IEventDispatcher;

import mx.collections.ArrayCollection;

public interface IRepository extends IEventDispatcher
{
  /**
   * collection of all items
   */
  function get source():ArrayCollection;

  /**
   * object describes type of item in repository
   */
  function get map():IDataMap;

  /**
   * Type of items in repository
   */
  function get type():Class;

  function get dataSource():IDataSource;

  /**
   * Search entity item in <code>source</code> by inner key.
   *
   * @param id key value
   */
  function getItemById(id:*):*;

  /**
   * Return inner key value for entity item that is included in <code>source</code>
   * @param entity item for with the value must be find
   */
  function getInnerKeyValue(entity:*):*;

  function getByForeignKey(entity:*):Array;

  function updateAssociations(foreignInstance:*, innerInstance:* = null):void;
}
}

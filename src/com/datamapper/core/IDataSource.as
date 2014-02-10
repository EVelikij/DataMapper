/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 02.02.14
 * Time: 23:14
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.core
{
import flash.events.IEventDispatcher;

import mx.collections.ArrayCollection;

public interface IDataSource extends IEventDispatcher
{
  /**
   * Register new repository in central source
   *
   * @param col
   * @param type
   */
  function addRepository(col:ArrayCollection, type:Class):IRepository;

  /**
   * Remove previously registered repository
   * @param col
   * @param type
   */
  function removeRepository(type:Class):IRepository;

  /**
   * remove all previously created repositories
   */
  function removeAllRepositories():void

  /**
   * return repositories count
   */
  function get length():int;

  /**
   * return repository for entity
   */
  function getRepositoryFor(entityOrClass:*):IRepository;

  /**
   * check for exist repository
   */
  function hasRepositoryFor(entityOrClass:*):Boolean;

}
}

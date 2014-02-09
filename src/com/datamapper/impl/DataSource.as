/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 04.02.14
 * Time: 0:02
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl
{
import com.datamapper.core.IDataSource;
import com.datamapper.core.IRepository;
import com.datamapper.errors.RepositoryError;
import com.datamapper.events.RepositoryEvent;

import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import mx.collections.ArrayCollection;

[Event(name="added", type="com.datamapper.events.RepositoryEvent")]

[Event(name="removed", type="com.datamapper.events.RepositoryEvent")]
public class DataSource extends EventDispatcher implements IDataSource
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function DataSource()
  {
    super();
  }


  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var repositories:Array = [];
  private var repositoryTypeMap:Dictionary = new Dictionary();


  //--------------------------------------------------------------------------
  //
  //  IDataSource implementation
  //
  //--------------------------------------------------------------------------
  public function addRepository(col:ArrayCollection, type:Class):IRepository
  {
    if (repositoryTypeMap[type] == undefined)
    {
      var rep:IRepository = new Repository(col, type, this);

      repositories.push(rep);
      repositoryTypeMap[type] = rep;

      // now we can dispatch ADDED event
      dispatchEvent(new RepositoryEvent(RepositoryEvent.ADDED, rep));

      return rep;
    }
    else
      throw RepositoryError.repositoryExist(type);
  }

  public function removeRepository(type:Class):IRepository
  {
    var rep:IRepository = getRepositoryFor(type);

    if (rep)
    {
      repositories.splice(repositories.indexOf(rep), 1);
      delete repositoryTypeMap[type];

      // now we can dispatch REMOVED event
      dispatchEvent(new RepositoryEvent(RepositoryEvent.REMOVED, rep));
    }

    return rep;
  }

  public function removeAllRepositories():void
  {
    while (repositories.length)
    {
      var rep:IRepository = repositories[0];

      removeRepository(rep.type);
    }
  }

  public function getRepositoryFor(entityOrClass:*):IRepository
  {
    var type:Class = entityOrClass is Class ? entityOrClass : Object(entityOrClass).constructor;

    return repositoryTypeMap[type];
  }

  public function hasRepositoryFor(entityOrClass:*):Boolean
  {
    return getRepositoryFor(entityOrClass) != null;
  }

  public function get length():int { return repositories.length; }


}
}

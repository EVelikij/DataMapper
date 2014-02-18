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
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedSuperclassName;

import mx.collections.ArrayCollection;

import org.flexunit.runner.notification.async.WaitingListener;

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
  private var abstractRepositoryTypeMap:Dictionary = new Dictionary();


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
      rep.clean();

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

    // find repository by type
    if (repositoryTypeMap[type])
      return repositoryTypeMap[type];
    else if (abstractRepositoryTypeMap[type])
      return abstractRepositoryTypeMap[type];

    var result:IRepository;

    // now find repository by inheritance
    for each (var rep:IRepository in repositories)
    {
      var curr:Class = getDefinitionByName(getQualifiedSuperclassName(rep.type)) as Class;
      var prev:Class = null;

      while (curr != Object && prev != curr)
      {
        if (curr == type && result == null)
        {
          result = rep;
          break;
        }
        else if (curr == type && result != null)
          throw RepositoryError.abstractEntityType(entityOrClass);

        prev = curr;
        // get super class
        curr = getDefinitionByName(getQualifiedSuperclassName(rep.type)) as Class;
      }
    }

    // save founded repository
    if (result)
      abstractRepositoryTypeMap[type] = result;

    return result;
  }

  public function hasRepositoryFor(entityOrClass:*):Boolean
  {
    return getRepositoryFor(entityOrClass) != null;
  }

  public function get length():int { return repositories.length; }


}
}

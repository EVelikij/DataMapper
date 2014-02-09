/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 09.02.14
 * Time: 11:29
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.events
{
import com.datamapper.core.IRepository;

import flash.events.Event;

public class RepositoryEvent extends Event
{
  //--------------------------------------------------------------------------
  //
  //  Class constants
  //
  //--------------------------------------------------------------------------
  public static const ADDED:String = "added";

  public static const REMOVED:String = "removed";


  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function RepositoryEvent(type:String, rep:IRepository, bubbles:Boolean = false, cancelable:Boolean = false)
  {
    super(type, bubbles, cancelable);

    this.repository = rep;
  }


  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  public var repository:IRepository;


  //--------------------------------------------------------------------------
  //
  //  Overridden methods
  //
  //--------------------------------------------------------------------------
  override public function clone():Event
  {
    return new RepositoryEvent(type, repository, bubbles, cancelable);
  }


}
}

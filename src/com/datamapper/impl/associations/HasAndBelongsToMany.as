/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 01.02.14
 * Time: 12:11
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.associations
{
import com.datamapper.core.IDataPoint;
import com.datamapper.core.IDataWatcher;
import com.datamapper.core.IRepository;

public class HasAndBelongsToMany extends BaseAssociation
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function HasAndBelongsToMany(source:IDataPoint, destination:IRepository)
  {
    super(source, destination);
  }


  //--------------------------------------------------------------------------
  //
  //  Overridden methods
  //
  //--------------------------------------------------------------------------
  override public function accept(watcher:IDataWatcher):void
  {
    watcher.hasAndBelongsToMany(this);
  }
}
}

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
import com.datamapper.impl.associations.BaseAssociation;
import com.datamapper.system.reflection.MetadataHostProperty;

public class HasAndBelongsToMany extends BaseAssociation
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function HasAndBelongsToMany(source:IDataPoint, destination:IDataPoint)
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

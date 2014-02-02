/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 01.02.14
 * Time: 12:09
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.associations
{
import com.datamapper.core.IDataPoint;
import com.datamapper.core.IDataWatcher;
import com.datamapper.impl.associations.BaseAssociation;
import com.datamapper.system.reflection.MetadataHostProperty;

public class HasMany extends BaseAssociation
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function HasMany(source:IDataPoint, destination:IDataPoint)
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
    watcher.hasMany(this);
  }
}
}

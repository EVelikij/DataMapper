/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 01.02.14
 * Time: 12:07
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.associations
{
import com.datamapper.core.IDataWatcher;
import com.datamapper.impl.associations.BaseAssociation;
import com.datamapper.system.reflection.MetadataHostProperty;

public class HasOne extends BaseAssociation
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function HasOne(source:MetadataHostProperty, destination:MetadataHostProperty)
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
    watcher.hasOne(this);
  }
}
}

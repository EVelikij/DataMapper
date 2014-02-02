/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 01.02.14
 * Time: 11:57
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.associations
{
import com.datamapper.core.IAssociation;
import com.datamapper.core.IDataPoint;
import com.datamapper.core.IDataWatcher;
import com.datamapper.system.reflection.MetadataHostProperty;

public class BaseAssociation implements IAssociation
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function BaseAssociation(source:IDataPoint,
                                  destination:IDataPoint)
  {
    _source = source;
    _destination = destination;
  }


  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var _source:IDataPoint;
  private var _destination:IDataPoint;


  //--------------------------------------------------------------------------
  //
  //  IAssociation implementation
  //
  //--------------------------------------------------------------------------
  public function get source():IDataPoint { return _source; }

  public function get destination():IDataPoint { return _destination; }

  public function accept(watcher:IDataWatcher):void
  {
  }
}
}

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
import com.datamapper.core.IDataWatcher;
import com.datamapper.system.reflection.MetadataHostProperty;

public class BaseAssociation implements IAssociation
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function BaseAssociation(source:MetadataHostProperty,
                                  destination:MetadataHostProperty)
  {
    _source = source;
    _destination = destination;
  }


  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var _source:MetadataHostProperty;
  private var _destination:MetadataHostProperty;


  //--------------------------------------------------------------------------
  //
  //  IAssociation implementation
  //
  //--------------------------------------------------------------------------
  public function get source():MetadataHostProperty { return _source; }

  public function get destination():MetadataHostProperty { return _destination; }

  public function accept(watcher:IDataWatcher):void
  {
  }
}
}

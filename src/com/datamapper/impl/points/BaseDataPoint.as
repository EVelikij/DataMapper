/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 01.02.14
 * Time: 12:42
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.points
{
import com.datamapper.core.IDataPoint;
import com.datamapper.impl.DataMap;
import com.datamapper.system.reflection.MetadataHostProperty;

public class BaseDataPoint implements IDataPoint
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function BaseDataPoint(map:DataMap, property:MetadataHostProperty)
  {
    _map = map;
    _property = property;
    _destinationType = getDestinationType();
  }


  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  protected var _map:DataMap;
  protected var _property:MetadataHostProperty;
  protected var _destinationType:Class;


  //--------------------------------------------------------------------------
  //
  //  IDataPoint implementation
  //
  //--------------------------------------------------------------------------
  public function get property():MetadataHostProperty { return _property; }

  public function get sourceType():Class { return _property.type; }

  public function get destinationType():Class { return _destinationType; }

  public function get map():DataMap { return _map; }


  //--------------------------------------------------------------------------
  //
  //  Methods
  //
  //--------------------------------------------------------------------------
  protected function getDestinationType():Class
  {
    return null;
  }
}
}

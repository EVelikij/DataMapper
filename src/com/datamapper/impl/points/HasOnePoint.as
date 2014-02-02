/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 01.02.14
 * Time: 12:52
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.points
{
import com.datamapper.impl.DataMap;
import com.datamapper.system.reflection.MetadataHostProperty;

public class HasOnePoint extends BaseDataPoint
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function HasOnePoint(map:DataMap, property:MetadataHostProperty)
  {
    super(map, property);
  }


  //--------------------------------------------------------------------------
  //
  //  Overridden methods
  //
  //--------------------------------------------------------------------------
  override protected function getDestinationType():Class
  {
    return sourceType;
  }
}
}

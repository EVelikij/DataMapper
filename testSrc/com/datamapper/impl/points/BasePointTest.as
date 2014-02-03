/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 02.02.14
 * Time: 18:42
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.points
{
import com.datamapper.BaseMockTest;
import com.datamapper.impl.DataMap;
import com.datamapper.system.reflection.MetadataHostProperty;

import mockolate.make;

public class BasePointTest extends BaseMockTest
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function BasePointTest()
  {
    super([ [DataMap, DataMap], [MetadataHostProperty, MetadataHostProperty] ]);
  }


  //--------------------------------------------------------------------------
  //
  //  Initalization
  //
  //--------------------------------------------------------------------------
  [Before(order=1, async)]
  public function initParams():void
  {
    map = initMap();
    initProperty();
  }


  //--------------------------------------------------------------------------
  //
  //  Properties
  //
  //--------------------------------------------------------------------------
  public var map:DataMap;

  [Mock]
  public var property:MetadataHostProperty;


  //--------------------------------------------------------------------------
  //
  //  Params methods
  //
  //--------------------------------------------------------------------------
  protected function initMap():DataMap
  {
    return null;
  }

  protected function initProperty():void
  {

  }


}
}

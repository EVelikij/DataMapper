/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 02.02.14
 * Time: 16:10
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.points
{
import com.datamapper.core.IDataMap;
import com.datamapper.impl.DataMap;
import com.datamapper.impl.DataSource;
import com.datamapper.impl.support.TestDataType;
import com.datamapper.system.reflection.MetadataHostProperty;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.stub;

import mx.controls.Button;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

import spark.components.Button;

[RunWith("mockolate.runner.MockolateRunner")]
public class BelongsToPointTest extends BasePointTest
{
  //--------------------------------------------------------------------------
  //
  //  Initializarion
  //
  //--------------------------------------------------------------------------
  override protected function initMap():DataMap
  {
    return nice(DataMap, "name", [type, new DataSource()]);
  }

  override protected function initProperty():void
  {
    stub(property).getter("type").returns(type);
  }

  [Before(order=2, async)]
  public function setUp():void
  {
    point = new BelongsToPoint(map, property)
  }

  [After]
  public function tearDown():void
  {
    point = null;
  }


  //--------------------------------------------------------------------------
  //
  //  Test methods
  //
  //--------------------------------------------------------------------------
  [Test]
  public function testGetDestinationType():void
  {
    assertThat("For BelongsToPoint getters sourceType and destinationType must return the same value",
            point.sourceType, equalTo(point.destinationType));
  }


  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var point:BelongsToPoint;
  private var type:Class =  TestDataType;


}
}

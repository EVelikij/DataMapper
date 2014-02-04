/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 02.02.14
 * Time: 21:59
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.points
{

import com.datamapper.impl.DataMap;
import com.datamapper.impl.DataSource;
import com.datamapper.impl.support.TestDataType;

import mockolate.nice;
import mockolate.stub;

import org.hamcrest.assertThat;

import org.hamcrest.object.equalTo;

[RunWith("mockolate.runner.MockolateRunner")]
public class HasOneTest extends BasePointTest
{
  //--------------------------------------------------------------------------
  //
  //  Initialization
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
    point = new HasOnePoint(map, property)
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
    assertThat("For HasOnePoint getters sourceType and destinationType must return the same value",
            point.sourceType, equalTo(point.destinationType));
  }


  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var point:HasOnePoint;
  private var type:Class = TestDataType;
}
}

/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 03.02.14
 * Time: 23:19
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.points
{
import com.datamapper.errors.DataPointError;
import com.datamapper.impl.DataMap;
import com.datamapper.impl.support.TestDataType;
import com.datamapper.system.MetadataTagArguments;
import com.datamapper.system.reflection.IMetadataTag;
import com.datamapper.system.reflection.MetadataArgument;
import com.datamapper.system.reflection.MetadataTag;

import mockolate.nice;
import mockolate.stub;

import org.hamcrest.assertThat;
import org.hamcrest.core.throws;
import org.hamcrest.object.equalTo;

import spark.components.Button;

[RunWith("mockolate.runner.MockolateRunner")]
public class HasAndBelongsToManyPointTest extends BasePointTest
{
  //--------------------------------------------------------------------------
  //
  //  Initialization
  //
  //--------------------------------------------------------------------------
  override protected function initMap():DataMap
  {
    return nice(DataMap, "name", [type]);
  }

  override protected function initProperty():void
  {
    hasManyTag = new MetadataTag();
    hasManyTag.args = [new MetadataArgument(MetadataTagArguments.TYPE, "spark.components.Button")];

    stub(property).method("getMetadataTag").returns(hasManyTag);
  }

  [Before(order=2, async)]
  public function setUp():void
  {
    point = new HasAndBelongsToManyPoint(map, property)
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
    assertThat("For HasManyPoint getters destinationType must return spark.components.Button",
            point.destinationType, equalTo(Button));
  }

  [Test]
  public function testGetDestinationTypeWithoutTypeArgument():void
  {
    hasManyTag.args = [];

    assertThat("Type argument for HasManyPoint must be specified.",
            function():void { new HasManyPoint(map, property); }, throws(DataPointError));
  }


  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var point:HasAndBelongsToManyPoint;
  private var hasManyTag:IMetadataTag;
  private var type:Class = TestDataType;
}
}

/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 26.01.14
 * Time: 15:27
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl
{
import avmplus.INCLUDE_BASES;

import com.datamapper.errors.DataMapError;
import com.datamapper.impl.support.FakeDataEntity;
import com.datamapper.impl.support.TestDataType;

import org.hamcrest.Matcher;

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.core.anyOf;
import org.hamcrest.core.not;
import org.hamcrest.core.throws;
import org.hamcrest.object.instanceOf;

public class DataMapTest
{
  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var map:DataMap;


  //--------------------------------------------------------------------------
  //
  //  Initialization
  //
  //--------------------------------------------------------------------------
  [Before]
  public function setUp():void
  {
    map = new DataMap(TestDataType);
  }



  //--------------------------------------------------------------------------
  //
  //  Test methods
  //
  //--------------------------------------------------------------------------
  [Test]
  public function testInitWithoutInnerKey():void
  {
    var fakeMap:DataMap = new DataMap(FakeDataEntity);
    assertThatInit(fakeMap, throws(DataMapError));
  }

  [Test]
  public function testInit():void
  {
    assertThatInit(map, not(throws(DataMapError)));
  }


  [Test]
  public function testGetForeignKeyFor():void
  {
  }


  //--------------------------------------------------------------------------
  //
  //  Utils
  //
  //--------------------------------------------------------------------------
  private function assertThatInit(map:DataMap, matcher:Matcher):void
  {
    assertThat(function():void { map.init(); }, matcher);
  }
}
}

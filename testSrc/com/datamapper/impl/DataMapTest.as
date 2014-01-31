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
import avmplus.getQualifiedClassName;

import com.datamapper.errors.DataMapError;
import com.datamapper.impl.support.fake.ManyForeignKeysTypeEntity;
import com.datamapper.impl.support.fake.WithoutForeignKeyTypeEntity;
import com.datamapper.impl.support.fake.WithoutInnerKeyEntity;
import com.datamapper.impl.support.TestDataType;
import com.datamapper.impl.support.fake.ManyInnerKeyEntity;

import org.hamcrest.Matcher;

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.core.anyOf;
import org.hamcrest.core.not;
import org.hamcrest.core.throws;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.notNullValue;
import org.hamcrest.object.nullValue;

import spark.components.Button;
import spark.components.CheckBox;

[RunWith("org.flexunit.runners.Parameterized")]
public class DataMapTest
{
  //--------------------------------------------------------------------------
  //
  //  Parameters
  //
  //--------------------------------------------------------------------------
  public static function fakeTypes():Array
  {
    return [ [WithoutInnerKeyEntity],
             [ManyInnerKeyEntity],
             [WithoutForeignKeyTypeEntity],
             [ManyForeignKeysTypeEntity] ];
  }

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
  [Test(dataProvider="fakeTypes")]
  /**
   * Тестируем тип без внутреннего ключа
   */
  public function testFakeTypes(type:Class):void
  {
    var fakeMap:DataMap = new DataMap(type);
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
    map.init();

    // get foreign key by type
    assertThat(map.getForeignKeyFor(Button), notNullValue());
    // get foreign key by instance
    assertThat(map.getForeignKeyFor(new Button()), notNullValue());
    // get foreign key for wrong type
    assertThat(map.getForeignKeyFor(CheckBox), nullValue());
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

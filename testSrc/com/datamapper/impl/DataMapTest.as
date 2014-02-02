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

import org.flexunit.asserts.assertEquals;

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
    map.init();
  }


  //--------------------------------------------------------------------------
  //
  //  Test methods
  //
  //--------------------------------------------------------------------------
  [Test]
  public function testInit():void
  {
    assertThatInit(map, not(throws(DataMapError)));
  }

  [Test]
  public function testGetForeignKeyFor():void
  {
    // get foreign key by type
    assertThat(map.getForeignKeyFor(Button), notNullValue());
    // get foreign key by instance
    assertThat(map.getForeignKeyFor(new Button()), notNullValue());
    // get foreign key for wrong type
    assertThat(map.getForeignKeyFor(CheckBox), nullValue());
  }

  [Test]
  public function testRepositoryType():void
  {
    assertEquals(map.repositoryType, TestDataType);
  }


  //--------------------------------------------------------------------------
  //
  //  Utils
  //
  //--------------------------------------------------------------------------
  public static function assertThatInit(map:DataMap, matcher:Matcher):void
  {
    assertThat(function():void { map.init(); }, matcher);
  }
}
}

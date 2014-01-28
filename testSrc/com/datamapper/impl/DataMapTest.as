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
  //  Test fake data
  //
  //--------------------------------------------------------------------------
  [Test]
  /**
   * Тестируем тип без внутреннего ключа
   */
  public function testInitWithoutInnerKey():void
  {
    var fakeMap:DataMap = new DataMap(WithoutInnerKeyEntity);
    assertThatInit(fakeMap, throws(DataMapError));
  }

  [Test]
  /**
   * Тестируем тип с нескольким внутренними ключами
   */
  public function testInitManyInnerKey():void
  {
    var fakeMap:DataMap = new DataMap(ManyInnerKeyEntity);
    assertThatInit(fakeMap, throws(DataMapError));
  }

  [Test]
  /**
   * Тестируем тип без свойства <code>type</code> для внешнего ключа
   */
  public function testWithoutForeignKeyType():void
  {
    var fakeMap:DataMap = new DataMap(WithoutForeignKeyTypeEntity);
    assertThatInit(fakeMap, throws(DataMapError));
  }

  [Test]
  /**
   * Тестируем тип с одинаковыми свойствами <code>type</code> для
   * разных внешнех ключей
   */
  public function testManyForeignKesyType():void
  {
    var fakeMap:DataMap = new DataMap(ManyForeignKeysTypeEntity);
    assertThatInit(fakeMap, throws(DataMapError));
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

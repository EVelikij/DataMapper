/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 02.02.14
 * Time: 13:29
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl
{
import com.datamapper.errors.DataMapError;
import com.datamapper.impl.support.fake.ManyForeignKeysTypeEntity;
import com.datamapper.impl.support.fake.ManyInnerKeyEntity;
import com.datamapper.impl.support.fake.WithoutForeignKeyTypeEntity;
import com.datamapper.impl.support.fake.WithoutInnerKeyEntity;

import org.hamcrest.core.throws;

[RunWith("org.flexunit.runners.Parameterized")]
public class DataMapFakeTest
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
  //  Test methods
  //
  //--------------------------------------------------------------------------
  [Test(dataProvider="fakeTypes")]
  /**
   * Тестируем тип без внутреннего ключа
   */
  public function testFakeTypes(type:Class):void
  {
    var fakeMap:DataMap = new DataMap(type, new DataSource());
    DataMapTest.assertThatInit(fakeMap, throws(DataMapError));
  }
}
}

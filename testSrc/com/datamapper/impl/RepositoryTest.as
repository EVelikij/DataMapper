/**
 * Created by User on 11.02.14.
 */
package com.datamapper.impl
{
import com.datamapper.core.IDataSource;
import com.datamapper.core.IRepository;
import com.datamapper.errors.RepositoryError;
import com.datamapper.impl.support.GroupDTO;
import com.datamapper.impl.support.StudentDTO;

import flash.events.Event;

import mockolate.prepare;

import mx.collections.ArrayCollection;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.core.throws;

[RunWith("mockolate.runner.MockolateRunner")]
public class RepositoryTest
{
  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var repository:IRepository;
  private var groups:ArrayCollection;

  [Mock]
  public var ds:IDataSource;


  //--------------------------------------------------------------------------
  //
  //  Initialization
  //
  //--------------------------------------------------------------------------
  [Before(async, order=0)]
  public function prepareMockolates():void
  {
    Async.proceedOnEvent(this, prepare(IDataSource, DataSource), Event.COMPLETE );
  }

  [Before]
  public function setUp():void
  {
    groups = new ArrayCollection();
    repository = new Repository(groups, GroupDTO, ds);
  }


  //--------------------------------------------------------------------------
  //
  //  Test methods
  //
  //--------------------------------------------------------------------------
  [Test]
  public function testAddWrongType():void
  {
    // пока не ясно как протестировать добавленеи неверного типа
    // т.к. бросание исключения происходит в репозитории в source_collectionChangeHandler
    // а мы его явно не вызываем. Должно быть что-то вроде этого
    // assertThat(function():void { groups.addItem(new StudentDTO())); }, throws(RepositoryError));
  }


}
}

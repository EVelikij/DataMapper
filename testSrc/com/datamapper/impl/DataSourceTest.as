/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 04.02.14
 * Time: 0:08
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl
{
import com.datamapper.core.IRepository;
import com.datamapper.errors.RepositoryError;
import com.datamapper.events.RepositoryEvent;
import com.datamapper.impl.support.GroupDTO;
import com.datamapper.impl.support.StudentDTO;
import com.datamapper.impl.support.inheritance.BaseEntity;
import com.datamapper.impl.support.inheritance.RefinedEntity;
import com.datamapper.impl.support.inheritance.RefinedEntity2;

import mx.collections.ArrayCollection;

import org.flexunit.asserts.assertFalse;

import org.flexunit.asserts.assertTrue;

import org.hamcrest.assertThat;
import org.hamcrest.core.throws;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.notNullValue;

import spark.components.Button;
import spark.components.Label;

public class DataSourceTest
{
  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var ds:DataSource;


  //--------------------------------------------------------------------------
  //
  //  Initalization
  //
  //--------------------------------------------------------------------------
  [Before]
  public function setUp():void
  {
    ds = new DataSource();
    ds.addRepository(new ArrayCollection(), GroupDTO);
    ds.addRepository(new ArrayCollection(), StudentDTO);
  }

  [After]
  public function tearDown():void
  {
    ds = null;
  }


  //--------------------------------------------------------------------------
  //
  //  Test methods
  //
  //--------------------------------------------------------------------------
  [Test]
  public function testAddRepository():void
  {
    assertThat("DataSource must contains items when they were added.", ds.length, equalTo(2));
  }

  [Test]
  public function testAddExistRepositoryType():void
  {
    assertThat("DataSource can contain only one repository for the specified type.",
      function():void { ds.addRepository(new ArrayCollection(), GroupDTO); }, throws(RepositoryError) );
  }

  [Test]
  public function testHasRepositoryFor():void
  {
    assertTrue("Data source doesn't have repository for registered type by instance.",
            ds.hasRepositoryFor(new GroupDTO()));

    assertTrue("Data source doesn't have repository for registered type by type.",
            ds.hasRepositoryFor(GroupDTO));
  }

  [Test]
  public function testRemoveAllRepositories():void
  {
    var counter:int = 0;

    ds.addEventListener(RepositoryEvent.REMOVED, function(event:RepositoryEvent):void
    {
      counter++;
    });

    ds.removeAllRepositories();

    assertThat("DataSource doesn't dispatch RepositoryEvent.REMOVED event when call removeAllRepositories()",
            counter, equalTo(2));
    assertThat("DataSource doesn't remove repository.", ds.length, equalTo(0));
  }

  [Test]
  public function testRemoveRepository():void
  {
    // remove repository
    ds.removeRepository(GroupDTO);

    assertThat("DataSource doesn't remove repository.", ds.length, equalTo(1));
    assertFalse("After remove repository getRepositoryFor method still return repository.", ds.hasRepositoryFor(GroupDTO));
  }

  [Test]
  public function testGetRepositoryFor():void
  {
    // test by instance
    assertThat("Data source doesn't return repository for registered type by instance.",
            ds.getRepositoryFor(new GroupDTO()), notNullValue());

    // test by type
    assertThat("Data source doesn't return repository for registered type by type.",
            ds.getRepositoryFor(GroupDTO), notNullValue());
  }

  [Test]
  public function testAddRemoveEvents():void
  {
    var ds:DataSource = new DataSource();
    var counter:int = 0;

    ds.addEventListener(RepositoryEvent.ADDED, function(event:RepositoryEvent):void
    {
       counter++;
    });

    ds.addEventListener(RepositoryEvent.REMOVED, function(event:RepositoryEvent):void
    {
       counter--;
    });


    // register two new repositories
    ds.addRepository(new ArrayCollection(), GroupDTO);
    ds.addRepository(new ArrayCollection(), StudentDTO);

    assertThat(counter, equalTo(2));

    ds.removeRepository(GroupDTO);
    ds.removeRepository(StudentDTO);

    assertThat(counter, equalTo(0));
  }

  [Test]
  public function testGetRepositoryForByAbstractType():void
  {
    // register new repository
    var rep:IRepository = ds.addRepository(new ArrayCollection(), RefinedEntity);

    assertThat(rep, equalTo(ds.getRepositoryFor(BaseEntity)));
    assertThat(rep, equalTo(ds.getRepositoryFor(new BaseEntity())));
  }

  [Test]
  /**
   * try to get repository by abstract data type when we have some
   * repositories with extends this tyoe
   */
  public function testGetRepositoryForByAbstractType2():void
  {
    // register new repository
    var rep:IRepository = ds.addRepository(new ArrayCollection(), RefinedEntity);
    var rep2:IRepository = ds.addRepository(new ArrayCollection(), RefinedEntity2);

    assertThat(function():void { equalTo(ds.getRepositoryFor(BaseEntity));}, throws(RepositoryError));
  }

}
}

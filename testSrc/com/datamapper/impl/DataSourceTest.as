/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 04.02.14
 * Time: 0:08
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl
{
import com.datamapper.errors.RepositoryError;

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
    ds.addRepository(new ArrayCollection(), Button);
    ds.addRepository(new ArrayCollection(), Label);
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
      function():void { ds.addRepository(new ArrayCollection(), Button); }, throws(RepositoryError) );
  }

  [Test]
  public function testHasRepositoryFor():void
  {
    assertTrue("Data source doesn't have repository for registered type by instance.",
            ds.hasRepositoryFor(new Button()));

    assertTrue("Data source doesn't have repository for registered type by type.",
            ds.hasRepositoryFor(Button));
  }

  [Test]
  public function testRemoveAllRepositories():void
  {
    // remove repository
    ds.removeRepository(Button);
    assertThat("DataSource doesn't remove repository.", ds.length, equalTo(1));

    assertFalse("After remove repository getRepositoryFor method still return repository.", ds.hasRepositoryFor(Button));
  }

  [Test]
  public function testRemoveRepository():void
  {
    ds.removeAllRepositories();

    assertThat("DataSource doesn't remove repository.", ds.length, equalTo(0));
  }

  [Test]
  public function testGetRepositoryFor():void
  {
    // test by instance
    assertThat("Data source doesn't return repository for registered type by instance.",
            ds.getRepositoryFor(new Button()), notNullValue());

    // test by type
    assertThat("Data source doesn't return repository for registered type by type.",
            ds.getRepositoryFor(Button), notNullValue());
  }
}
}

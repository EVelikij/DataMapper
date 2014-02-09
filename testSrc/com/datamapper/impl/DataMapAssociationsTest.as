/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 09.02.14
 * Time: 12:28
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl
{
import com.datamapper.core.IDataMap;
import com.datamapper.core.IDataSource;
import com.datamapper.core.IRepository;
import com.datamapper.impl.support.GroupDTO;
import com.datamapper.impl.support.StudentDTO;

import mx.collections.ArrayCollection;

import org.hamcrest.assertThat;
import org.hamcrest.collection.arrayWithSize;
import org.hamcrest.collection.hasItem;

public class DataMapAssociationsTest
{
  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var ds:IDataSource;
  private var students:ArrayCollection;
  private var groups:ArrayCollection;


  //--------------------------------------------------------------------------
  //
  //  Initialization
  //
  //--------------------------------------------------------------------------
  [Before]
  public function setUp():void
  {
    ds = new DataSource();
    students = new ArrayCollection();
    groups = new ArrayCollection();
  }

  [After]
  public function tearDown():void
  {
    ds = null;
    students = null;
    groups = null;
  }


  //--------------------------------------------------------------------------
  //
  //  Test methods
  //
  //--------------------------------------------------------------------------
  [Test]
  public function lazyInitializationTest():void
  {
    var studentsRepository:IRepository = ds.addRepository(students, StudentDTO);
    var groupsRepository:IRepository = ds.addRepository(groups, GroupDTO);

    var studentMap:IDataMap = studentsRepository.map;
    var groupMap:IDataMap = groupsRepository.map;

    assertThat(studentMap.associations, arrayWithSize(1));
    assertThat(groupMap.associations, arrayWithSize(1));
  }


}
}

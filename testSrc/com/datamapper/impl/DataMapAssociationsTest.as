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
import com.datamapper.impl.support.EntityFactory;
import com.datamapper.impl.support.GroupDTO;
import com.datamapper.impl.support.ProfileDTO;
import com.datamapper.impl.support.Storage;
import com.datamapper.impl.support.StudentDTO;
import com.datamapper.impl.support.TeacherDTO;

import mx.collections.ArrayCollection;

import org.hamcrest.assertThat;
import org.hamcrest.collection.arrayWithSize;
import org.hamcrest.collection.hasItem;

import spark.components.Group;

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
  private var profiles:ArrayCollection;
  private var teachers:ArrayCollection;

  private var studentsRepository:IRepository;
  private var groupsRepository:IRepository;
  private var profileRepository:IRepository;
  private var teachersRepository:IRepository;


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
    profiles = new ArrayCollection();
    teachers = new ArrayCollection();

    studentsRepository = ds.addRepository(students, StudentDTO);
    groupsRepository = ds.addRepository(groups, GroupDTO);
    profileRepository = ds.addRepository(profiles, ProfileDTO);
    teachersRepository = ds.addRepository(teachers, TeacherDTO);
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
    var studentMap:IDataMap = studentsRepository.map;
    var groupMap:IDataMap = groupsRepository.map;

    assertThat(studentMap.associations, arrayWithSize(3));
    assertThat(groupMap.associations, arrayWithSize(1));
  }

  [Test]
  public function removeRepositoryTest():void
  {
    ds.removeRepository(StudentDTO);

    assertThat(groupsRepository.map.associations, arrayWithSize(0));
  }

  [Test]
  public function testInsert():void
  {
    teachers.addAll(EntityFactory.createTeachers(Storage.DATA));
    groups.addAll(EntityFactory.createGroups(Storage.DATA));
    students.addAll(EntityFactory.createStudents(Storage.DATA));
    profiles.addAll(EntityFactory.createProfiles(Storage.DATA));


    trace();
  }





}
}

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
import com.datamapper.impl.support.Profile;
import com.datamapper.impl.support.StudentDTO;

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

  private var studentsRepository:IRepository;
  private var groupsRepository:IRepository;
  private var profileRepository:IRepository;


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

    studentsRepository = ds.addRepository(students, StudentDTO);
    groupsRepository = ds.addRepository(groups, GroupDTO);
    profileRepository = ds.addRepository(profiles, Profile);
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

    assertThat(studentMap.associations, arrayWithSize(2));
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
    var profile:Profile = new Profile();
    profile.studentId = 2;
    profile.email = "alice@gmail.com";
    profile.password = "password";

    var student1:StudentDTO = new StudentDTO();
    student1.id = 1;
    student1.name = "Alice";
    student1.groupId = 1;

    var student2:StudentDTO = new StudentDTO();
    student2.id = 2;
    student2.name = "Bob";
    student2.groupId = 1;

    var student3:StudentDTO = new StudentDTO();
    student3.id = 3;
    student3.name = "Dave";
    student3.groupId = 2;

    var group1:GroupDTO = new GroupDTO();
    group1.id = 1;
    group1.name = "My First group";
    var group2:GroupDTO = new GroupDTO();
    group2.id = 2;
    group2.name = "Second group";



    groups.addItem(group1);
    groups.addItem(group2);

    students.addItem(student1);
    students.addItem(student2);
    students.addItem(student3);

    profiles.addItem(profile);

    trace();
  }





}
}

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
import org.hamcrest.object.equalTo;

import spark.components.Group;

[RunWith("org.flexunit.runners.Parameterized")]
public class DataMapAssociationsTest
{
  //--------------------------------------------------------------------------
  //
  //  Parameters
  //
  //--------------------------------------------------------------------------
  public static function initGroupParams():Array
  {
    // groupId | studentsCount
    return [ [1, 2],
             [2, 3] ];
  }

  public static function initStudentsParams():Array
  {
    // studentId | groupId | profileId | teachersCount
    return [ [1, 1, 1, 1],
             [2, 1, 0, 2],
             [3, 2, 0, 1],
             [4, 2, 0, 1],
             [5, 2, 0, 0]];
  }

  public static function initProfilesParams():Array
  {
    // profileId | studentId
    return [ [1, 1] ];
  }

  public static function initTeachersParams():Array
  {
    // profileId | studentsCount
    return [ [1, 3],
             [2, 2]];
  }


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
    students.removeAll();
    groups.removeAll();
    profiles.removeAll();
    teachers.removeAll();
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

  [Test(dataProvider="initGroupParams")]
  public function testInitGroup(groupId:int, studentsCount:int):void
  {
    initData();

    var group:GroupDTO = groupsRepository.getItemById(groupId);

    assertThat("[HasMany] association for GroupDTO doesn't work correctly",
      group.students.length, equalTo(studentsCount))
  }

  [Test(dataProvider="initStudentsParams")]
  public function testInitStudents(studentId:int, groupId:int, profileId:int, teachersCount:int):void
  {
    initData();

    var student:StudentDTO = studentsRepository.getItemById(studentId);
    var group:GroupDTO = groupsRepository.getItemById(groupId);
    var profile:ProfileDTO = profileRepository.getItemById(profileId);

    assertThat("[HasOne] association for StudentDTO doesn't work correctly",
      student.group, equalTo(group));

    assertThat("[BelongsTo] association for StudentDTO doesn't work correctly",
      student.profile, equalTo(profile));

    assertThat("[HasAndBelongsToMany] association for StudentDTO doesn't work correctly",
      student.teachers.length, equalTo(teachersCount));
  }

  [Test(dataProvider="initProfilesParams")]
  public function testInitProfiles(profileId:int, studentId:int):void
  {
    initData();

    var profile:ProfileDTO = profileRepository.getItemById(profileId);
    var student:StudentDTO = studentsRepository.getItemById(studentId);

    assertThat("[BelongsTo] association for ProfileDTO doesn't work correctly",
      profile.student, equalTo(student));
  }

  [Test(dataProvider="initTeachersParams")]
  public function testInitTeachers(teacherId:int, studentsCount:int):void
  {
    initData();

    var teacher:TeacherDTO = teachersRepository.getItemById(teacherId);

    assertThat("[HasAndBelongsToMany] association for TeacherDTO doesn't work correctly",
        teacher.students.length, equalTo(studentsCount));
  }


  //--------------------------------------------------------------------------
  //
  //  Utils
  //
  //--------------------------------------------------------------------------
  private function initData():void
  {
    // insert data to repository
    teachers.addAll(EntityFactory.createTeachers(Storage.DATA));
    groups.addAll(EntityFactory.createGroups(Storage.DATA));
    students.addAll(EntityFactory.createStudents(Storage.DATA));
    profiles.addAll(EntityFactory.createProfiles(Storage.DATA));
  }

}
}

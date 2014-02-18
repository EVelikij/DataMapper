/**
 * Created by User on 11.02.14.
 */
package com.datamapper.impl.support
{
import com.datamapper.impl.support.TeacherDTO;

import mx.collections.ArrayCollection;

import spark.components.Group;

public class EntityFactory
{
  //--------------------------------------------------------------------------
  //
  //  Class methods
  //
  //--------------------------------------------------------------------------
  public static function createGroups(data:XML):ArrayCollection
  {
    var result:ArrayCollection = new ArrayCollection();
    var xmlGroups:XMLList = data..group;

    for each (var node:XML in xmlGroups)
      result.addItem(createGroup(node.@id, node.@name));

    return result;
  }

  public static function createStudents(data:XML):ArrayCollection
  {
    var result:ArrayCollection = new ArrayCollection();
    var xmlStudents:XMLList = data..student;

    for each (var node:XML in xmlStudents)
      result.addItem(createStudent(node.@id, node.@name, node.@groupId));

    return result;
  }

  public static function createProfiles(data:XML):ArrayCollection
  {
    var result:ArrayCollection = new ArrayCollection();
    var xmlProfile:XMLList = data..profile;

    for each (var node:XML in xmlProfile)
      result.addItem(createProfile(node.@id, node.@email, node.@password, node.@studentId));

    return result;
  }

  public static function createTeachers(data:XML):ArrayCollection
  {
    var result:ArrayCollection = new ArrayCollection();
    var xmlTechers:XMLList = data..teacher;

    for each (var node:XML in xmlTechers)
      result.addItem(createTeacher(node.@id, node.@name, String(node.@studentsId)));

    return result;
  }

  public static function createGroup(id:int, name:String):GroupDTO
  {
    var group:GroupDTO = new GroupDTO();
    group.id = id;
    group.name = name;

    return group;
  }

  public static function createStudent(id:int, name:String, groupId:int):StudentDTO
  {
    var student:StudentDTO = new StudentDTO();

    student.id = id;
    student.name = name;
    student.groupId = groupId;

    return student;
  }

  public static function createProfile(id:int, email:String, password:String, studentId:int):ProfileDTO
  {
    var profile:ProfileDTO = new ProfileDTO();

    profile.id = id;
    profile.email = email;
    profile.password = password;
    profile.studentId = studentId;

    return profile;
  }

  public static function createTeacher(id:int, name:String, studentsId:*):TeacherDTO
  {
    var teacher:TeacherDTO = new TeacherDTO();
    var temp:Array = [];

    teacher.id = id;
    teacher.name = name;

    if (studentsId is String)
    {
      var idAsString:Array = String(studentsId).split(/\s*,\s*/);

      for each (var studId:String in idAsString)
        temp.push(int(studId));
    }
    else if (studentsId is Array)
      temp = studentsId;

    teacher.studentsId = temp;

    return teacher;
  }
}
}

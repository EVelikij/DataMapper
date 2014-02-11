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
    {
      var group:GroupDTO = new GroupDTO();

      group.id = node.@id;
      group.name = node.@name;

      result.addItem(group);
    }

    return result;
  }

  public static function createStudents(data:XML):ArrayCollection
  {
    var result:ArrayCollection = new ArrayCollection();
    var xmlStudents:XMLList = data..student;

    for each (var node:XML in xmlStudents)
    {
      var student:StudentDTO = new StudentDTO();

      student.id = node.@id;
      student.name = node.@name;
      student.groupId = node.@groupId;

      result.addItem(student);
    }

    return result;
  }

  public static function createProfiles(data:XML):ArrayCollection
  {
    var result:ArrayCollection = new ArrayCollection();
    var xmlProfile:XMLList = data..profile;

    for each (var node:XML in xmlProfile)
    {
      var profile:ProfileDTO = new ProfileDTO();

      profile.id = node.@id;
      profile.email = node.@email;
      profile.password = node.@password;
      profile.studentId = node.@studentId;

      result.addItem(profile);
    }

    return result;
  }

  public static function createTeachers(data:XML):ArrayCollection
  {
    var result:ArrayCollection = new ArrayCollection();
    var xmlTechers:XMLList = data..teacher;

    for each (var node:XML in xmlTechers)
    {
      var teacher:TeacherDTO = new TeacherDTO();
      var studentsId:Array = String(node.@studentsId).split(/\s*,\s*/);

      teacher.id = node.@id;
      teacher.studentsId = [];

      for each (var id:String in studentsId)
        teacher.studentsId.push(int(id));

      result.addItem(teacher);
    }

    return result;
  }
}
}

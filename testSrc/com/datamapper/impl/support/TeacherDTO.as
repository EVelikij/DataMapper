/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 11.02.14
 * Time: 22:48
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.support
{
public class TeacherDTO
{
  [Id]
  public var id:int;

  public var name:String;

  [ForeignKey(type="com.datamapper.impl.support.StudentDTO")]
  public var studentsId:Array;

  [HasAndBelongsToMany(type="com.datamapper.impl.support.StudentDTO")]
  public var students:Array;
}
}

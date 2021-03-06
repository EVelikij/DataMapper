/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 09.02.14
 * Time: 12:33
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.support
{
public class StudentDTO
{
  [Id]
  public var id:int;

  public var name:String;

  [ForeignKey(type="com.datamapper.impl.support.BaseGroupDTO")]
  public var groupId:int;

  [HasOne]
  public var group:BaseGroupDTO;

  [BelongsTo]
  public var profile:ProfileDTO;

  [HasAndBelongsToMany(type="com.datamapper.impl.support.TeacherDTO")]
  public var teachers:Array;
}
}

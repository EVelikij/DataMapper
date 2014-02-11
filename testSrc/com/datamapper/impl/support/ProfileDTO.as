/**
 * Created by User on 11.02.14.
 */
package com.datamapper.impl.support
{
public class ProfileDTO
{
  [Id]
  public var id:int;

  [ForeignKey(type="com.datamapper.impl.support.StudentDTO")]
  public var studentId:int;

  public var email:String;
  public var password:String;

  [HasOne]
  public var student:StudentDTO;
}
}

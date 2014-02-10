/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 09.02.14
 * Time: 12:32
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.support
{
import mx.collections.ArrayCollection;

public class GroupDTO
{
  [Id]
  public var id:int;

  public var name:String;

  [HasMany(type="com.datamapper.impl.support.StudentDTO")]
  public var students:ArrayCollection;
}
}

/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 29.01.14
 * Time: 0:18
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.support.fake
{

public class ManyForeignKeysTypeEntity
{
  [Id]
  public var id:String;

  [ForeignKey(type="spark.components.Button")]
  public var foreignKey:int;

  [ForeignKey(type="spark.components.Button")]
  public var foreignKey2:int;
}
}

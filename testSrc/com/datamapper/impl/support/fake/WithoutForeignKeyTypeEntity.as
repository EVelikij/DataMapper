/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 29.01.14
 * Time: 0:06
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.support.fake
{
public class WithoutForeignKeyTypeEntity
{
  [Id]
  public var id:String;

  [ForeignKey]
  public var foreignKey:int;

}
}

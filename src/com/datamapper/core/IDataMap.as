/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 18.01.14
 * Time: 14:44
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.core
{
import com.datamapper.system.reflection.MetadataHostProperty;

public interface IDataMap
{
  function get id():MetadataHostProperty;

  function getForeignKeyFor(type:Class):MetadataHostProperty;

  function get associations():Array;
}
}
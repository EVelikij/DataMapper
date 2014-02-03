/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 02.02.14
 * Time: 23:14
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.core
{
import mx.collections.ArrayCollection;

public interface IDataSource
{
  /**
   * Register new repository in central source
   *
   * @param col
   * @param type
   */
  function addRepository(col:ArrayCollection, type:Class):void;

  /**
   * Remove previously registered repository
   * @param col
   * @param type
   */
  function removeRepository(col:ArrayCollection, type:Class):void;
}
}

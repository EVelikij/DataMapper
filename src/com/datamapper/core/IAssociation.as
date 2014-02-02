/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 18.01.14
 * Time: 14:53
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.core
{
public interface IAssociation
{
  function get source():IDataPoint;

  function get destination():IDataPoint;

  function accept(watcher:IDataWatcher):void;
}
}

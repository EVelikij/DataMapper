/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 01.02.14
 * Time: 12:35
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.core
{
import com.datamapper.impl.DataMap;
import com.datamapper.system.reflection.MetadataHostProperty;

public interface IDataPoint
{
  /**
   * Описание свойсвта класа к соторому привязанна точка
   */
  function get property():MetadataHostProperty;

  /**
   * Тип с которым ассаоциирована точка
   */
  function get sourceType():Class;

  /**
   * Тип на который указывает точка
   */
  function get destinationType():Class;

  function get map():DataMap;

}
}

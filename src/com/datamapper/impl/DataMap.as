/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 18.01.14
 * Time: 21:22
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl
{
import com.datamapper.core.IDataMap;
import com.datamapper.errors.DataMapError;
import com.datamapper.system.MetadataNames;
import com.datamapper.system.reflection.DescribeType;
import com.datamapper.system.reflection.MetadataHostProperty;
import com.datamapper.system.reflection.MetadataTypeDescriptor;

public class DataMap implements IDataMap
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function DataMap(type:Class)
  {
    this.type = type;
  }

  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var type:Class;
  private var description:MetadataTypeDescriptor;

  /**
   * storage for the <code>Id<code> property
   */
  private var _id:MetadataHostProperty;

  /**
   * storage for the <code>ForeignKey</code> properties
   */
  private var foreignKeys:Array = [];


  //--------------------------------------------------------------------------
  //
  //  Initialization
  //
  //--------------------------------------------------------------------------
  public function init():void
  {
    description = DescribeType.getDescriptor(type);

    initId();
    initForeignKeys();
  }

  /**
   * Method extract id property
   */
  private function initId():void
  {
    var idHosts:Array = description.getMetadataHostsWithTags(MetadataNames.ID);

    // для указанного типа должно присутствовать только одно свойство
    // с мета тегом [Id]
    if (idHosts.length == 0)
      throw DataMapError.innerKeyExistError(type);
    else if (idHosts.length > 1)
      throw DataMapError.manyKeyError(type);

    // мы получили только одно свойство с мета тегом [Id]
    _id = idHosts[0];
  }

  /**
   * Method extract all foreign keys properties
   */
  private function initForeignKeys():void
  {
    foreignKeys = description.getMetadataHostsWithTags(MetadataNames.FOREIGN_KEY);
  }




  //--------------------------------------------------------------------------
  //
  //  IDataMap implementation
  //
  //--------------------------------------------------------------------------
  public function get id():MetadataHostProperty
  {
    return _id;
  }

  public function getForeignKeyFor(type:Class):MetadataHostProperty
  {
    return null;
  }

  public function get associations():Array
  {
    return null;
  }
}
}

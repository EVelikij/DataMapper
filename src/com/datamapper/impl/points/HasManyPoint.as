/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 01.02.14
 * Time: 12:53
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl.points
{
import com.datamapper.errors.DataPointError;
import com.datamapper.impl.DataMap;
import com.datamapper.system.MetadataTagArguments;
import com.datamapper.system.reflection.IMetadataArgument;
import com.datamapper.system.reflection.MetadataHostProperty;
import com.datamapper.system.reflection.MetadataTag;

import flash.utils.getDefinitionByName;

import flex.lang.reflect.metadata.MetaDataArgument;

public class HasManyPoint extends BaseDataPoint
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function HasManyPoint(map:DataMap, hasManyTag:MetadataTag)
  {
    tag = hasManyTag;

    super(map, tag.host as MetadataHostProperty);
  }


  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var tag:MetadataTag;


  //--------------------------------------------------------------------------
  //
  //  Overridden methods
  //
  //--------------------------------------------------------------------------
  override protected function getDestinationType():Class
  {
    var typeArg:IMetadataArgument = tag.getArg(MetadataTagArguments.TYPE);

    if (typeArg == null)
      throw DataPointError.noTypeForHasMany(map.repositoryType);

    return getDefinitionByName(typeArg.value) as Class;
  }
}
}

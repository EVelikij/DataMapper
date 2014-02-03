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
import com.datamapper.system.MetadataNames;
import com.datamapper.system.MetadataTagArguments;
import com.datamapper.system.reflection.IMetadataArgument;
import com.datamapper.system.reflection.IMetadataTag;
import com.datamapper.system.reflection.MetadataHostProperty;

import flash.utils.getDefinitionByName;

public class HasManyPoint extends BaseDataPoint
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function HasManyPoint(map:DataMap, property:MetadataHostProperty)
  {
    super(map, property);
  }


  //--------------------------------------------------------------------------
  //
  //  Overridden methods
  //
  //--------------------------------------------------------------------------
  override protected function getDestinationType():Class
  {
    var tag:IMetadataTag = property.getMetadataTag(MetadataNames.HAS_MANY);

    // check for exist HasMany tag
    if (tag == null)
      throw DataPointError.missingMetadataTag(MetadataNames.HAS_MANY, property.name, map.repositoryType);

    var typeArg:IMetadataArgument = tag.getArg(MetadataTagArguments.TYPE);

    // check fot exist type argument
    if (typeArg == null)
      throw DataPointError.noTypeForHasMany(map.repositoryType);

    return getDefinitionByName(typeArg.value) as Class;
  }
}
}

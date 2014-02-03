/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 02.02.14
 * Time: 13:17
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

public class HasAndBelongsToManyPoint extends BaseDataPoint
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function HasAndBelongsToManyPoint(map:DataMap, property:MetadataHostProperty)
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
    var tag:IMetadataTag = property.getMetadataTag(MetadataNames.HAS_AND_BELONGS_TO_MANY);

    // check for exist HasAndBelongsToMany tag
    if (tag == null)
      throw DataPointError.missingMetadataTag(MetadataNames.HAS_AND_BELONGS_TO_MANY, property.name, map.repositoryType);

    var typeArg:IMetadataArgument = tag.getArg(MetadataTagArguments.TYPE);

    if (typeArg == null)
      throw DataPointError.noTypeForHasAndBelongsToMany(map.repositoryType);

    return getDefinitionByName(typeArg.value) as Class;
  }
}
}

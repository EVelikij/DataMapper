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
import com.datamapper.system.MetadataTagArguments;
import com.datamapper.system.reflection.IMetadataArgument;
import com.datamapper.system.reflection.MetadataHostProperty;
import com.datamapper.system.reflection.MetadataTag;

import flash.utils.getDefinitionByName;

public class HasAndBelongsToManyPoint extends BaseDataPoint
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function HasAndBelongsToManyPoint(map:DataMap, tag:MetadataTag)
  {
    this.tag = tag;

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
      throw DataPointError.noTypeForHasAndBelongsToMany(map.repositoryType);

    return getDefinitionByName(typeArg.value) as Class;
  }
}
}

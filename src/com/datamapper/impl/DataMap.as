/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 18.01.14
 * Time: 21:22
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper.impl
{
import com.datamapper.core.IAssociation;
import com.datamapper.core.IDataMap;
import com.datamapper.core.IDataPoint;
import com.datamapper.core.IDataSource;
import com.datamapper.core.IRepository;
import com.datamapper.errors.DataMapError;
import com.datamapper.events.RepositoryEvent;
import com.datamapper.impl.associations.BelongsTo;
import com.datamapper.impl.associations.HasAndBelongsToMany;
import com.datamapper.impl.associations.HasMany;
import com.datamapper.impl.associations.HasOne;
import com.datamapper.impl.points.BelongsToPoint;
import com.datamapper.impl.points.HasAndBelongsToManyPoint;
import com.datamapper.impl.points.HasManyPoint;
import com.datamapper.impl.points.HasOnePoint;
import com.datamapper.system.MetadataNames;
import com.datamapper.system.MetadataTagArguments;
import com.datamapper.system.reflection.DescribeType;
import com.datamapper.system.reflection.MetadataHostProperty;
import com.datamapper.system.reflection.MetadataTag;
import com.datamapper.system.reflection.MetadataTypeDescriptor;

import flash.utils.getQualifiedClassName;

public class DataMap implements IDataMap
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function DataMap(type:Class, ds:IDataSource)
  {
    this.type = type;
    this.ds = ds;

    ds.addEventListener(RepositoryEvent.ADDED, ds_repositoryAddedHandler);
    ds.addEventListener(RepositoryEvent.REMOVED, ds_repositoryRemovedHandler);
  }


  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var type:Class;
  private var ds:IDataSource;

  private var description:MetadataTypeDescriptor;

  /**
   * storage for the <code>Id<code> property
   */
  private var _id:MetadataHostProperty;

  /**
   * storage for the <code>ForeignKey</code> properties
   */
  private var foreignKeys:Array = [];

  private var foreignKeysTags:Array = [];

  private var _associations:Array = [];

  /**
   * Коллекция объектов PendingAssociation
   */
  private var pendingAssociations:Array = [];

  private var _points:Array = [];

  /**
   * storage for the [HasOne] points
   */
  private var _hasOnePoints:Array = [];

  /**
   * storage fot the [BelongsTo] points
   */
  private var _belongsToPoints:Array = [];

  /**
   * storage fot the [HasMany] points
   */
  private var _hasManyPoints:Array = [];

  /**
   * storage fot the [HasAndBelongsToMany] points
   */
  private var _hasAndBelongsToManyPoints:Array = [];


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
    initPoints();
    initAssociations();
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
      throw DataMapError.innerKeyExist(type);
    else if (idHosts.length > 1)
      throw DataMapError.manyInnerKey(type);

    // мы получили только одно свойство с мета тегом [Id]
    _id = idHosts[0];
  }

  /**
   * Method extract all foreign keys properties
   */
  private function initForeignKeys():void
  {
    foreignKeysTags = description.getMetadataTagsByName(MetadataNames.FOREIGN_KEY);

    // проверка что на один тип есть ТОЛЬКО один ключ
    var fkTypes:Array = [];
    for each (var key:MetadataTag in foreignKeysTags)
    {
      // для внешнего ключа отсутсвует тип
      if (!key.hasArg(MetadataTagArguments.TYPE))
        throw DataMapError.foreignKeyType(key.host.name, type);

      var t:String = key.getArg(MetadataTagArguments.TYPE).value;

      if (fkTypes.indexOf(t) != -1)
        throw DataMapError.manyForeignKeys(t, type);

      foreignKeys.push(key.host);
      fkTypes.push(t);
    }
  }

  private function initPoints():void
  {
    var self:DataMap = this;
    // internal method that helps to collect points
    var collectPoints:Function = function(pointType:String, pointFactory:Class):Array
    {
      var result:Array = [];
      var tags:Array = description.getMetadataTagsByName(pointType);

      for each (var tag:MetadataTag in tags)
        result.push(new pointFactory(self, tag.host))

      return result;
    };

    // step 1: collect [HasOne] points
    _hasOnePoints = collectPoints(MetadataNames.HAS_ONE, HasOnePoint);

    // step 2: collect [BelongsTo] points
    _belongsToPoints = collectPoints(MetadataNames.BELONGS_TO, BelongsToPoint);

    // step 3: collect [HasMany] points
    _hasManyPoints = collectPoints(MetadataNames.HAS_MANY, HasManyPoint);

    // step 4: collect [HasAndBelongsToMany] points
    _hasAndBelongsToManyPoints = collectPoints(MetadataNames.HAS_AND_BELONGS_TO_MANY, HasAndBelongsToManyPoint);
  }

  private function initAssociations():void
  {
    var self:DataMap = this;
    // internal method that allows create associations
    var collectAssociations:Function = function(points:Array, associationFactory:Class):Array
    {
      var result:Array = [];

      for each (var pt:IDataPoint in points)
      {
        var rep:IRepository = ds.getRepositoryFor(pt.destinationType);

        if (rep)
          result.push(new associationFactory(pt, rep));
        else
          self.pendingAssociations.push(new PendingAssociation(pt, associationFactory));
      }

      return result;
    };

    _associations = [];

    // step 1: creates HasOne associations
    _associations = collectAssociations(_hasOnePoints, HasOne);

    // step 2: creates BelongsTo associations
    _associations = _associations.concat(collectAssociations(_belongsToPoints, BelongsTo));

    // step 3: creates HasMany associations
    _associations = _associations.concat(collectAssociations(_hasManyPoints, HasMany));

    // step 4: creates HasAndBelongsToMany associations
    _associations = _associations.concat(collectAssociations(_hasAndBelongsToManyPoints, HasAndBelongsToMany));
  }

  //--------------------------------------------------------------------------
  //
  //  Events handlers
  //
  //--------------------------------------------------------------------------
  protected function ds_repositoryAddedHandler(event:RepositoryEvent):void
  {
    var i:int = 0;

    while (i < pendingAssociations.length)
    {
      var pending:PendingAssociation = pendingAssociations[i];
      var association:IAssociation = pending.repositoryAdded(ds, event.repository);

      if (association)
      {
        _associations.push(association);
        pendingAssociations.splice(i, 1);
      }
      else
        i++;
    }
  }

  protected function ds_repositoryRemovedHandler(event:RepositoryEvent):void
  {
    var i:int = 0;

    // remove associations that belongs to removed repository
    while (i < _associations.length)
    {
      var assoc:IAssociation = _associations[i];

      if (assoc.destination == event.repository)
        _associations.splice(i,  1);
      else
        i++;
    }

    // remove pending associations
    i = 0;
    while (i < pendingAssociations.length)
    {
      var pending:PendingAssociation = pendingAssociations[i];

      if (pending.destinationType == event.repository.type)
        pendingAssociations.splice(i, 1);
      else
        i++;
    }
  }


  //--------------------------------------------------------------------------
  //
  //  IDataMap implementation
  //
  //--------------------------------------------------------------------------
  public function get id():MetadataHostProperty { return _id; }

  public function get repositoryType():Class { return type; }

  public function getForeignKeyFor(value:*):MetadataHostProperty
  {
    // class to string
    var className:String = getQualifiedClassName(value).replace("::", ".");

    for each (var key:MetadataTag in foreignKeysTags)
    {
      var foreignKeyType:String = key.getArg(MetadataTagArguments.TYPE).value;

      if (foreignKeyType == className)
        return key.host as MetadataHostProperty;
    }

    return null;
  }

  public function get associations():Array { return _associations; }

  public function get points():Array { return _points; }

  public function get hasOnePoints():Array { return _hasOnePoints; }

  public function get belongsToPoints():Array { return _belongsToPoints; }

  public function get hasManyPoints():Array { return _hasManyPoints; }

  public function get hasAndBelongsToManyPoints():Array { return _hasAndBelongsToManyPoints; }


  public function clean():void
  {
    ds.removeEventListener(RepositoryEvent.ADDED, ds_repositoryAddedHandler);
    ds.removeEventListener(RepositoryEvent.REMOVED, ds_repositoryRemovedHandler);
  }
}
}

import com.datamapper.core.IAssociation;
import com.datamapper.core.IDataPoint;
import com.datamapper.core.IDataSource;
import com.datamapper.core.IRepository;

class PendingAssociation
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function PendingAssociation(point:IDataPoint, factory:Class)
  {
    this.point = point;
    this.factory = factory;
  }


  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  private var point:IDataPoint;
  private var factory:Class;


  //--------------------------------------------------------------------------
  //
  //  Properties
  //
  //--------------------------------------------------------------------------
  public function get destinationType():Class { return point.destinationType; }


  //--------------------------------------------------------------------------
  //
  //  Methods
  //
  //--------------------------------------------------------------------------
  public function repositoryAdded(ds:IDataSource, rep:IRepository):IAssociation
  {
    if (ds.getRepositoryFor(point.destinationType) == null)
      return null;

    return new factory(point, rep);
  }
}

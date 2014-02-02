/**
 * Created with IntelliJ IDEA.
 * User: evgenii
 * Date: 02.02.14
 * Time: 18:45
 * To change this template use File | Settings | File Templates.
 */
package com.datamapper
{
import flash.events.Event;

import mockolate.prepare;

import org.flexunit.async.Async;

public class BaseMockTest
{
  //--------------------------------------------------------------------------
  //
  //  Constructor
  //
  //--------------------------------------------------------------------------
  public function BaseMockTest(...rest)
  {
    this.rest = rest;
  }


  //--------------------------------------------------------------------------
  //
  //  Variables
  //
  //--------------------------------------------------------------------------
  protected var rest:*;


  //--------------------------------------------------------------------------
  //
  //  Initialization
  //
  //--------------------------------------------------------------------------
  [Before(order=0, async)]
  public function prepateMocolates():void
  {
    Async.proceedOnEvent(this, prepare(rest), Event.COMPLETE)
  }
}
}

/**
 * Created by User on 11.02.14.
 */
package com.datamapper.impl.support
{
public class Storage
{
  public static const DATA:XML = <storage>
    <groups>
      <group id="1" name="My First group" />
      <group id="2" name="Second group" />
    </groups>

    <students>
      <student id="1" name="Alice" groupId="1" />
      <student id="2" name="Bob" groupId="1" />
      <student id="3" name="Dave" groupId="2" />
    </students>

    <profiles>
      <profile id="1" email="alice@gmail.com" password="password" studentId="3" />
    </profiles>
  </storage>;
}
}

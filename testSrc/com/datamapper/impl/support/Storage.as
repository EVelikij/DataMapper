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
      <student id="4" name="Walter" groupId="2" />
    </students>

    <profiles>
      <profile id="1" email="alice@gmail.com" password="password" studentId="1" />
    </profiles>

    <teachers>
      <teacher id="1" name="Gary" studentsId="1, 3, 2" />
      <teacher id="2" name="Dave" studentsId="2, 4" />
    </teachers>
  </storage>;
}
}

/*
 * http://blog.csdn.net/sinat_26342009/article/details/45072491
  http://lib.csdn.net/article/oracle/24371
 */

 create tablespace cuizy datafile
    'F:\temp\cuizy.dbf'
    size 3G
    autoextend off
    default storage(initial 100m next 1m)
    permanent
    online
    logging;


drop tablespace cuizy including contents and datafiles;

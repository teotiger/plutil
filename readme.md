# PLUtil

## Introduction
PLUtil package is a collection of procedures, functions, and (sub)types for use in SQL and PL/SQL.

## Installation
Simply run the install script from the setup folder inside SQL*Plus.

## Documentation

The documentation of all subprograms in the package can be found on [ReadTheDocs](https://plutil.readthedocs.io/en/latest/index.html).

## License

PLUtil is released under the [MIT license](https://github.com/teotiger/plutil/blob/master/license.txt).

## Quality
PLUtil use [utPLSQL](https://github.com/utPLSQL) for UnitTests. The results and some static analysis of the source code can be found on [SonarCloud.io](https://sonarcloud.io/dashboard?id=teotiger_plutil).

## Version History
Version 0.5 – March 30, 2020

- new functions added (split_to_list, split_tt, replace_multi, prn)
- more unit tests and better code coverage

Version 0.4 – June 8, 2019

- new functions added (date_to_unix_timestamp, unix_timestamp_to_date, format_bytes_binary, format_bytes_decimal, hex_to_rgb, rgb_to_hex)

Version 0.3 – March 10, 2018

* new functions added (cpad, days_in_month, format_seconds)

Version 0.2 – June 27, 2017
* Complete refactoring

Version 0.1 – April 5, 2017
* Initial release

/*##############################################################################

    Copyright (C) 2011 HPCC Systems.

    All rights reserved. This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
############################################################################## */

ds := DATASET('tmp::29186027::0',
 RECORD
  unsigned integer2 per_birth_date;
  unsigned integer8 _holepos;
  integer8 Age;
  unsigned integer8 holepos{virtual(fileposition)}
 END, THOR);

count(ds);

x := ds : persist('z');

count(x);

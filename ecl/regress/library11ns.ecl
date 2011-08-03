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

#option ('targetClusterType', 'roxie');

namesRecord :=
            RECORD
string20        surname;
string10        forename;
integer2        age := 25;
            END;


FilterLibrary(dataset(namesRecord) ds, string search, boolean onlyOldies) := interface,__noStreaming__
    export dataset(namesRecord) included;
    export dataset(namesRecord) excluded;
end;

impFilterLibrary(dataset(namesRecord) ds, string search, boolean onlyOldies) := module,library(FilterLibrary)
    f := ds;
    shared g := if (onlyOldies, f(age >= 65), f);
    export included := g(surname != search);
    export excluded := g(surname = search);
end;

filterDataset(dataset(namesRecord) ds, string search, boolean onlyOldies) := library(INTERNAL(impFilterLibrary), FilterLibrary(ds, search, onlyOldies));

//namesTable := dataset('x',namesRecord,FLAT);
namesTable := dataset([
        {'Hawthorn','Gavin',31},
        {'Hawthorn','Mia',30},
        {'Smithe','Pru',10},
        {'X','Z'}], namesRecord);
pr := dedup(namesTable, surname);
s := sort(pr, surname, forename, age);

filtered := filterDataset(pr, 'Smith', false);
output(filtered.included,,named('Included'));

filtered2 := filterDataset(pr, 'Hawthorn', false);
output(filtered2.excluded,,named('Excluded'));



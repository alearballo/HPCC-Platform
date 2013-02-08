#option ('targetClusterType', 'roxie');
resistorCodes := dataset([{0, 'Black'},
                          {1, 'Brown'},
                          {2, 'Red'},
                          {3, 'Orange'},
                          {4, 'Yellow'},
                          {5, 'Green'},
                          {6, 'Blue'},
                          {7, 'Violet'},
                          {8, 'Grey'},
                          {9, 'White'}], {unsigned1 value, string color}) : stored('colorMap');

color2code := DICTIONARY(resistorCodes, { color => value});

bands := DATASET([{'Red'},{'Yellow'},{'Blue'}], {string band}) : STORED('bands');

valrec := RECORD
            unsigned1 value;
          END;

//valrec getValue(bands L, dictionary(recordof(color2code)) mapping) := TRANSFORM
valrec getValue(bands L, dictionary(recordof(dataset(color2code))) mapping) := TRANSFORM
  SELF.value := mapping[L.band].value;
END;

results := allnodes(PROJECT(bands, getValue(LEFT, THISNODE(color2code))));

ave(results, value);  // Should remain the same regardless of how many slaves there are


IN: examples.sequences.tests
USING: examples.sequences tools.test math ;

! Test searching for the first even number in a list
{ 4 } [ { 1 3 4 7 8 } [ even? ] find-first ] unit-test
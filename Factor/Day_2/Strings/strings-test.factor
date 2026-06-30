IN: examples.strings.tests
USING: examples.strings tools.test ;

! [ expected-output ] [ code-to-test ] unit-test

{ t } [ "racecar" palindrome? ] unit-test
{ f } [ "apple" palindrome? ] unit-test
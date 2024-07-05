import 'dart:developer';

String testName = '';
int testCount = 0;
int testCountSuccess = 0;
int testCountFailed = 0;

isTrue(bool re, String message) {
  testCount++;
  if (re) {
    testCountSuccess++;
    log(message, name: '🟢');
  } else {
    testCountFailed++;
    log(message, name: '❌');
  }
}

testStart(String name) {
  testName = name;
  testCount = 0;
  testCountSuccess = 0;
  testCountFailed = 0;
}

testReport() {
  log('-- Test Name : $testName --', name: '');
  log('Test Count: $testCount', name: '📊');
  log('Test Success: $testCountSuccess', name: '🟢');
  log('Test Failed: $testCountFailed', name: '❌');
}

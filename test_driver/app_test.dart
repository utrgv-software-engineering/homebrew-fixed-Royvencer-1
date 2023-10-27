// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  group('Happy Paths', () {
    test("should give recommendation for Drip Machine", () async {
      // Start from the initial Coffee Device Selection Screen

      // Find and tap the "Drip Machine" button
      await driver.tap(find.text("French Press"));

      // Find and tap the "Continue" button
      await driver.tap(find.text("Continue"));

      // Find the input field for the number of cups and enter "5"
      await driver.tap(find.byValueKey('cupsTextField'));
      await driver.enterText("5");

      // Find and tap the "Continue" button
      await driver.tap(find.text("Continue"));

      // Wait for the recommended ground coffee and water values to appear
      final recommendedCoffeeText =
          await driver.getText(find.byValueKey("recommendedCoffeeText"));
      final recommendedWaterText =
          await driver.getText(find.byValueKey("recommendedWaterText"));

      // Verify that the recommended ground coffee text is as expected
      expect(recommendedCoffeeText, contains("61g - course ground coffee"));

      // Verify that the recommended water text is as expected
      expect(recommendedWaterText, contains("851g - water"));
      await driver.tap(find.text("Done"));
    });

    // Write similar tests for other happy paths

    // Add more test cases for different happy paths as needed

    /*
      Given I am on the Coffee Device Selection Screen
      When I tap "Drip Machine"
      And I tap "Continue"
      And I enter "5"
      And I tap "Continue"
      Then I should see "51g - medium ground coffee"
      And I should see "851g - water"
    */
    test("should give recommendation for Drip Machine", () async {
      // Start from the initial Coffee Device Selection Screen

      // Find and tap the "Drip Machine" button
      await driver.tap(find.text("Drip Machine"));

      // Find and tap the "Continue" button
      await driver.tap(find.text("Continue"));

      // Find the input field for the number of cups and enter "5"
      await driver.tap(find.byValueKey('cupsTextField'));
      await driver.enterText("5");

      // Find and tap the "Continue" button
      await driver.tap(find.text("Continue"));

      // Wait for the recommended ground coffee and water values to appear
      final recommendedCoffeeText =
          await driver.getText(find.byValueKey("recommendedCoffeeText"));
      final recommendedWaterText =
          await driver.getText(find.byValueKey("recommendedWaterText"));

      // Verify that the recommended ground coffee text is as expected
      expect(recommendedCoffeeText, contains("51g - medium ground coffee"));

      // Verify that the recommended water text is as expected
      expect(recommendedWaterText, contains("851g - water"));
      await driver.tap(find.text("Done"));
    });
  });
  group('Sad Paths', () {
    /*
      Given I am on the Coffee Device Selection Screen
      When I press "Continue"
      Then I expect to still be on the Coffee Device Selection Screen
    */

    test("should not advance from Choose Device Screen without a selection",
        () async {
      // Given I am on the Choose Device Screen

      // When I press "Continue"
      await driver.tap(find.byValueKey('continueButton'));

      // Delay to allow for any potential navigation (you can adjust the duration)
      await Future.delayed(Duration(seconds: 1));

      // Then I expect to still be on the Choose Device Screen
      await driver.waitFor(find.byValueKey('chooseDeviceAppBar'));
    });

    /*
      Given I chose "French Press" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen without cups", () async {
      // Start from the initial Coffee Device Selection Screen and navigate to Choose Cups Screen

      // Find and tap the "French Press" button (assuming you've navigated from the previous screen)
      await driver.tap(find.text("French Press"));

      // Find and tap the "Continue" button on the Choose Cups Screen
      await driver.tap(find.text("Continue"));

      // At this point, you should be on the Choose Cups Screen

      // Find and tap the "Continue" button again without selecting cups
      await driver.tap(find.text("Continue"));

      // You should still be on the Choose Cups Screen, so verify it
      final currentScreenText =
          await driver.getText(find.text("How Many Cups You Would Like?"));

      // Verify that the current screen text is as expected
      expect(currentScreenText, contains("How Many Cups You Would Like?"));

      // Optionally, you can also check for the presence of the "Number of cups" input field
      final cupsTextField = find.byValueKey('cupsTextField');
      expect(await driver.getText(cupsTextField), isEmpty);
      await driver.tap(find.byValueKey('cupsTextField'));
      await driver.enterText("5");

      // Find and tap the "Continue" button
      await driver.tap(find.text("Continue"));

      // Wait for the recommended ground coffee and water values to appear
      final recommendedCoffeeText =
          await driver.getText(find.byValueKey("recommendedCoffeeText"));
      final recommendedWaterText =
          await driver.getText(find.byValueKey("recommendedWaterText"));

      // Verify that the recommended ground coffee text is as expected
      expect(recommendedCoffeeText, contains("61g - course ground coffee"));

      // Verify that the recommended water text is as expected
      expect(recommendedWaterText, contains("851g - water"));
      await driver.tap(find.text("Done"));
    });

    /*
      Given I chose "French Press" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I enter "-1"
      And I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen with negative cup amount",
        () async {
      // Start from the initial Coffee Device Selection Screen and navigate to Choose Cups Screen

      // Find and tap the "French Press" button (assuming you've navigated from the previous screen)
      await driver.tap(find.text("French Press"));

      // Find and tap the "Continue" button on the Choose Cups Screen
      await driver.tap(find.text("Continue"));

      // At this point, you should be on the Choose Cups Screen

      // Find the input field for the number of cups and enter "-1"
      await driver.tap(find.byValueKey('cupsTextField'));
      await driver.enterText("-1");

      // Find and tap the "Continue" button again with a negative cup amount
      await driver.tap(find.text("Continue"));

      // You should still be on the Choose Cups Screen, so verify it
      final currentScreenText =
          await driver.getText(find.text("How Many Cups You Would Like?"));

      // Verify that the current screen text is as expected
      expect(currentScreenText, contains("How Many Cups You Would Like?"));
      await driver.tap(find.byValueKey('cupsTextField'));
      await driver.enterText("5");

      // Find and tap the "Continue" button
      await driver.tap(find.text("Continue"));

      // Wait for the recommended ground coffee and water values to appear
      final recommendedCoffeeText =
          await driver.getText(find.byValueKey("recommendedCoffeeText"));
      final recommendedWaterText =
          await driver.getText(find.byValueKey("recommendedWaterText"));

      // Verify that the recommended ground coffee text is as expected
      expect(recommendedCoffeeText, contains("61g - course ground coffee"));

      // Verify that the recommended water text is as expected
      expect(recommendedWaterText, contains("851g - water"));
      await driver.tap(find.text("Done"));
    });

    /*
      Given I chose "French Press" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I enter "a"
      And I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen with invalid cup amount",
        () async {
      // Start from the initial Coffee Device Selection Screen and navigate to Choose Cups Screen

      // Find and tap the "French Press" button (assuming you've navigated from the previous screen)
      await driver.tap(find.text("French Press"));

      // Find and tap the "Continue" button on the Choose Cups Screen
      await driver.tap(find.text("Continue"));

      // At this point, you should be on the Choose Cups Screen

      // Find the input field for the number of cups and enter "-1"
      await driver.tap(find.byValueKey('cupsTextField'));
      await driver.enterText("a");

      // Find and tap the "Continue" button again with a negative cup amount
      await driver.tap(find.text("Continue"));

      // You should still be on the Choose Cups Screen, so verify it
      final currentScreenText =
          await driver.getText(find.text("How Many Cups You Would Like?"));

      // Verify that the current screen text is as expected
      expect(currentScreenText, contains("How Many Cups You Would Like?"));
      await driver.tap(find.byValueKey('cupsTextField'));
      await driver.enterText("5");

      // Find and tap the "Continue" button
      await driver.tap(find.text("Continue"));

      // Wait for the recommended ground coffee and water values to appear
      final recommendedCoffeeText =
          await driver.getText(find.byValueKey("recommendedCoffeeText"));
      final recommendedWaterText =
          await driver.getText(find.byValueKey("recommendedWaterText"));

      // Verify that the recommended ground coffee text is as expected
      expect(recommendedCoffeeText, contains("61g - course ground coffee"));

      // Verify that the recommended water text is as expected
      expect(recommendedWaterText, contains("851g - water"));
      await driver.tap(find.text("Done"));
    });

    /*
      Given I chose "Drip Machine" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen without cups", () async {
      // Start from the initial Coffee Device Selection Screen and navigate to Choose Cups Screen

      // Find and tap the "Drip Machine" button (assuming you've navigated from the previous screen)
      await driver.tap(find.text("Drip Machine"));

      // Find and tap the "Continue" button on the Choose Cups Screen
      await driver.tap(find.text("Continue"));

      // At this point, you should be on the Choose Cups Screen

      // Find and tap the "Continue" button again without selecting cups
      await driver.tap(find.text("Continue"));

      // You should still be on the Choose Cups Screen, so verify it
      final currentScreenText =
          await driver.getText(find.text("How Many Cups You Would Like?"));

      // Verify that the current screen text is as expected
      expect(currentScreenText, contains("How Many Cups You Would Like?"));

      final cupsTextField = find.byValueKey('cupsTextField');
      expect(await driver.getText(cupsTextField), isEmpty);
      await driver.tap(find.byValueKey('cupsTextField'));
      await driver.enterText("5");

      // Find and tap the "Continue" button
      await driver.tap(find.text("Continue"));

      // Wait for the recommended ground coffee and water values to appear
      final recommendedCoffeeText =
          await driver.getText(find.byValueKey("recommendedCoffeeText"));
      final recommendedWaterText =
          await driver.getText(find.byValueKey("recommendedWaterText"));

      // Verify that the recommended ground coffee text is as expected
      expect(recommendedCoffeeText, contains("51g - medium ground coffee"));

      // Verify that the recommended water text is as expected
      expect(recommendedWaterText, contains("851g - water"));
      await driver.tap(find.text("Done"));
    });

    /*
      Given I chose "Drip Machine" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I enter "-1"
      And I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen with negative cup amount",
        () async {
      // Start from the initial Coffee Device Selection Screen and navigate to Choose Cups Screen

      // Find and tap the "French Press" button (assuming you've navigated from the previous screen)
      await driver.tap(find.text("Drip Machine"));

      // Find and tap the "Continue" button on the Choose Cups Screen
      await driver.tap(find.text("Continue"));

      // At this point, you should be on the Choose Cups Screen

      // Find the input field for the number of cups and enter "-1"
      await driver.tap(find.byValueKey('cupsTextField'));
      await driver.enterText("-1");

      // Find and tap the "Continue" button again with a negative cup amount
      await driver.tap(find.text("Continue"));

      // You should still be on the Choose Cups Screen, so verify it
      final currentScreenText =
          await driver.getText(find.text("How Many Cups You Would Like?"));

      // Verify that the current screen text is as expected
      expect(currentScreenText, contains("How Many Cups You Would Like?"));
      await driver.tap(find.byValueKey('cupsTextField'));
      await driver.enterText("5");

      // Find and tap the "Continue" button
      await driver.tap(find.text("Continue"));

      // Wait for the recommended ground coffee and water values to appear
      final recommendedCoffeeText =
          await driver.getText(find.byValueKey("recommendedCoffeeText"));
      final recommendedWaterText =
          await driver.getText(find.byValueKey("recommendedWaterText"));

      // Verify that the recommended ground coffee text is as expected
      expect(recommendedCoffeeText, contains("51g - medium ground coffee"));

      // Verify that the recommended water text is as expected
      expect(recommendedWaterText, contains("851g - water"));
      await driver.tap(find.text("Done"));
    });

    /*
      Given I chose "Drip Machine" on the Coffee Device Selection Screen
      And I advanced to the Choose Cups Screen
      When I enter "a"
      And I press "Continue"
      Then I expect to still be on the Choose Cups Screen
    */
    test("should not advance from Choose Cups Screen with invalid cup amount",
        () async {
      // Start from the initial Coffee Device Selection Screen and navigate to Choose Cups Screen

      // Find and tap the "French Press" button (assuming you've navigated from the previous screen)
      await driver.tap(find.text("Drip Machine"));

      // Find and tap the "Continue" button on the Choose Cups Screen
      await driver.tap(find.text("Continue"));

      // At this point, you should be on the Choose Cups Screen

      // Find the input field for the number of cups and enter "-1"
      await driver.tap(find.byValueKey('cupsTextField'));
      await driver.enterText("a");

      // Find and tap the "Continue" button again with a negative cup amount
      await driver.tap(find.text("Continue"));

      // You should still be on the Choose Cups Screen, so verify it
      final currentScreenText =
          await driver.getText(find.text("How Many Cups You Would Like?"));

      // Verify that the current screen text is as expected
      expect(currentScreenText, contains("How Many Cups You Would Like?"));
      await driver.tap(find.byValueKey('cupsTextField'));
      await driver.enterText("5");

      // Find and tap the "Continue" button
      await driver.tap(find.text("Continue"));

      // Wait for the recommended ground coffee and water values to appear
      final recommendedCoffeeText =
          await driver.getText(find.byValueKey("recommendedCoffeeText"));
      final recommendedWaterText =
          await driver.getText(find.byValueKey("recommendedWaterText"));

      // Verify that the recommended ground coffee text is as expected
      expect(recommendedCoffeeText, contains("51g - medium ground coffee"));

      // Verify that the recommended water text is as expected
      expect(recommendedWaterText, contains("851g - water"));
      await driver.tap(find.text("Done"));
    });
  });

  group('Back Button', () {
    // Skip all tests related to the back button
    test("should go back to the previous screen", () async {
  // Start from the initial Coffee Device Selection Screen

  // Find and tap the "Drip Machine" button (assuming you've navigated from the previous screen)
  await driver.tap(find.text("Drip Machine"));

  // Find and tap the "Continue" button on the Choose Cups Screen
  await driver.tap(find.text("Continue"));

  // At this point, you should be on the Choose Cups Screen

  // Find the input field for the number of cups and enter "5"
  await driver.tap(find.byValueKey('cupsTextField'));
  await driver.enterText("5");

  // Find and tap the "Continue" button
  await driver.tap(find.text("Continue"));

  // Wait for the recommended ground coffee and water values to appear
  final recommendedCoffeeText = await driver.getText(find.byValueKey("recommendedCoffeeText"));
  final recommendedWaterText = await driver.getText(find.byValueKey("recommendedWaterText"));

  // Verify that the recommended ground coffee text is as expected
  expect(recommendedCoffeeText, contains("51g - medium ground coffee"));

  // Verify that the recommended water text is as expected
  expect(recommendedWaterText, contains("851g - water"));

  // Find and tap the AppBar's back button by its tooltip
  await driver.tap(find.byTooltip('Back'));

  // You should be back on the Coffee Device Selection Screen. Verify it by finding an element on that screen.
  final coffeeDeviceSelectionText = await driver.getText(find.text("Drip Machine"));

  // Verify that you are on the Coffee Device Selection Screen
  expect(coffeeDeviceSelectionText, contains("Drip Machine"));
});
  });
}

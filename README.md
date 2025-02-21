# MobileBank - Open Source iOS Banking App

Welcome to MobileBank, an open-source iOS application designed to provide a realistic, end-to-end banking experience for testing and learning purposes. Unlike many demo apps that focus on isolated features, MobileBank aims to simulate a cohesive, real-world banking flow, making it ideal for practicing automated testing with tools like Appium and XCUITest.

## Project Goals

* **Real-World Scenarios:** Create a functional banking app with realistic user flows (login, balance check, transfers, etc.).
* **Testing Focus:** Provide a platform for developers and QA engineers to practice automated testing in a meaningful context.
* **Community Contribution:** Encourage contributions to expand features and improve the app.
* **Educational Resource:** Serve as a learning tool for iOS development and test automation.

## Features (Initial Release)

* **Account Summary:** Display account balance and transaction history.
* **Funds Transfer:** Initiate transfers between accounts.
* **Simple UI:** Clean and intuitive interface for ease of use.

## Getting Started

### Prerequisites

* Xcode (latest version)
* iOS Simulator or a physical iOS device
* Sauce Labs account with access to the Real Device Cloud and Mobile App Distribution features

### Installation

1.  **Clone the repository:**

    ```bash
    git clone git@github.com:StuMinch/MobileBank.git
    cd MobileBank
    ```

2.  **Open the project in Xcode:**

    Open `MobileBank.xcodeproj` in Xcode.

3.  **Build and run the app locally:**

    Select your target simulator or device and run the app.

4.  **Upload the app to Sauce Labs for testing on the Real Device Cloud:**

    Uploading to Sauce Labs App Storage allows you to test your app across a wide variety of iOS devices in the Real Device Cloud.

    curl -u "$SAUCE_USERNAME:$SAUCE_ACCESS_KEY" --location \
    --request POST 'https://api.us-west-1.saucelabs.com/v1/storage/upload' \
    --form 'payload=@"./MobileBank.ipa"' \
    --form 'name="MobileBank.ipa"' \
    --form 'description="Mobile Bank App"'

5.  **Distribute via Sauce Mobile App Distribution:**

    When your automation testing has validated that everything is functioning it is time to distribute your app to your beta tester users to identify how your app performs in the real-world before you publish it to the Apple App Store.

    The following command uploads the app, creates a folder named "iOS" and a beta tester group named "MobileBank-Beta":
    ```bash
    curl https://upload.testfairy.com/api/upload \
    -F api_key=$TF_ACCESS_KEY \
    -F file=@MobileBank.ipa \
    -F metadata.branch=master \
    -F metadata.locale=us-en \
    -F folder_name=iOS \
    -F group=MobileBank-Beta
    ```

    Now invite your beta tester users to start using your app!
    ```bash
    curl POST -u "$TF_USERNAME:$TF_ACCESS_KEY" https://api.testfairy.com/api/1/testers/ \
     -F email="betatester@domain.com" \
    -F group=MobileBank-Beta \
    -F notify=on | jq
    ```

    

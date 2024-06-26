# paynote_app

# this is [Stacked Architecture](https://pub.dev/packages/stacked)

## [Services](https://pub.dev/packages/stacked_services)


# Add new screens and services:

## Automatically:

Use [Stacked CLI Automation tool](https://pub.dev/packages/stacked_cli)

## Usage
### How to add view:
use
this alias in your stacked architecture project.

    $ st_cli view name-in-small-words
For example:

    $ st_cli view login
It will generate some files and folders (if not exist) in your lib folder with some starting code.

### How to add service:
    $ st_cli service firestore
it will generate services folder and service file in it and it also injects that service in your app

## Manually:

### **Add new screen**
- create new folder in **ui/views** with respective name.

- create two files in that folder ending with **View** and **ViewModel** , e.g. **HomeView** and **HomeViewModel**.

- In **app/router.dart** add that route in an array.

- After that run this command in command line,

        flutter pub run build_runner build


### **Add new service**
- create new file in **services** folder with respect to your service, e.g FirestoreService.dart

- include that service in **Services.dart**

- After that run this command in command line,

         flutter pub run build_runner build

### **Add new translation**
- Click on link to view full configuration of translations [Easy Localization](https://pub.dev/packages/easy_localization).


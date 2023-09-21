# Progress Pal: The Task Manager in Flutter!

Elevate your productivity with Progress Pal, a meticulously crafted task manager application designed to streamline your journey towards achieving your goals. With its sleek design and intuitive user interface, Progress Pal redefines task management, making it an indispensable companion for both personal and professional endeavors.

## Progress Pal UI

<div style="display: flex; flex-wrap: wrap;">
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss0.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss1.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss2.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss3.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss4.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss5.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss6.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss7.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss8.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss9.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss10.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss11.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss12.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss13.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss14.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss15.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss16.png" width="200" height="400" />
    <img src="https://github.com/muj-i/progress_pal/blob/main/screenshots/ss17.png" width="200" height="400" />
</div>

## Features of Progress Pal

- **Seamless Onboarding:**
Embark on your productivity journey by creating your account through our user-friendly sign-up option. Forgot your password? No worries! Our secure log-in with password recovery feature ensures that you're always in control of your account.

- **Empowering Profile Updates:**
Customize your user experience and keep your information up-to-date effortlessly. The profile update option lets you modify your details and ensure your personal touch on the app.

- **Effortless Task Management:**
Add tasks effortlessly and embark on the path to success. The app initiates with a default category called "New," ensuring a swift start to your task list. With just a tap, transform your tasks into achievements.

- **Dynamic Task Status Updates:**
Progress Pal empowers you to manage your tasks dynamically. Move tasks between the "In Progress," "Completed," and "Cancelled" statuses effortlessly. A convenient bottom sheet pops up, allowing you to seamlessly shift tasks to the desired status.

- **Insightful Summary Card:**
Stay on top of your game with the Summary Card feature. It provides a quick snapshot of task distribution across the "In Progress," "Completed," and "Cancelled" categories. What's more? This handy card is accessible from any of the four main pages, keeping you informed at all times.

Progress Pal isn't just an app; it's a tool that adapts to your rhythm, empowering you to make progress every step of the way. Whether you're a busy professional, a dedicated student, or someone striving to manage daily tasks effectively, Progress Pal caters to your unique needs.

Experience the future of task management. Download Progress Pal today and unlock a world of organization, efficiency, and accomplishment. Your journey to success begins here.

## Getting Started

### Prerequisites

Ensure Flutter is installed on your machine. For installation instructions, refer to the official [Flutter website](https://flutter.dev/docs/get-started/install).

### Installation

Follow these steps to run the Progress Pal Application:

1. Clone this repository to your local machine:

```bash
git clone https://github.com/muj-i/progress_pal.git
```

2. Navigate to the project folder:

```bash
cd progress_pal
```

3. Install dependencies:

```bash
flutter pub get
```

### How to Run

Connect your device or emulator and run the app using the following command:

```bash
flutter run
```
## Used Packages

Progress Pal integrates the following packages to enhance functionality:

- `flutter_svg: ^2.0.7`: Display Scalable Vector Graphics (SVG) images.
- `pin_code_fields: ^8.0.1`: Easily implement secure PIN code input fields.
- `font_awesome_flutter: ^10.5.0`: Access a wide range of Font Awesome icons.
- `image_picker: ^1.0.1`: Enable users to select images from their devices.
- `http: ^1.1.0`: Perform HTTP requests and interact with APIs.
- `google_nav_bar: ^5.0.6`: Create sleek, customizable bottom navigation bars with Google's Material Design.
- `flutter_launcher_icons: ^0.13.1`: Simplify the process of generating launcher icons on various platforms.
- `get: ^4.6.5`: Implement state management and dependency injection with the GetX library.
- `get_storage: ^2.1.1`: Local data storage and retrieval tasks using the GetStorage.

## Project Directory Structure

The Progress Pal directory structure is organized as follows:

```
  progress_pal/
  ├── assets/
  │   ├── images/
  │   │   ├── logo3.svg
  │   │   ├── placeHolderPP.png
  │   │   ├── rainbow-vortex1.svg
  ├── lib/
  │   ├── data/
  │   │   ├── model/
  │   │   │   ├── login_model.dart
  │   │   │   ├── network_response.dart
  │   │   │   ├── summary_count_model.dart
  │   │   │   ├── tasks_list_model.dart
  │   │   ├── services/
  │   │   │   ├── network_caller.dart
  │   │   ├── utils/
  │   │   │   ├── auth_utils.dart
  │   │   │   ├── base64image.dart
  │   │   │   ├── urls.dart
  │   ├── ui/
  │   │   ├── getx_state_manager/
  │   │   │   ├── auth_controller/
  │   │   │   │   ├── email_verify_controller.dart
  │   │   │   │   ├── login_controller.dart
  │   │   │   │   ├── pin_verify_controller.dart
  │   │   │   │   ├── reset_password_controller.dart
  │   │   │   │   ├── signup_controller.dart
  │   │   │   ├── controller_bindings/
  │   │   │   │   ├── controller_bindings.dart
  │   │   │   ├── update_controller/
  │   │   │   │   ├── update_pass_controller.dart
  │   │   │   │   ├── update_profile_controller.dart
  │   │   │   ├── add_new_task_controller.dart
  │   │   │   ├── get_cancelled_task_controller.dart
  │   │   │   ├── get_completed_task_controller.dart
  │   │   │   ├── get_inprogress_task_controller.dart
  │   │   │   ├── get_new_task_controller.dart
  │   │   │   ├── summary_count_controller.dart
  │   │   ├── pages/
  │   │   │   ├── auth/
  │   │   │   │   ├── email_verify_page.dart
  │   │   │   │   ├── login_page.dart
  │   │   │   │   ├── pin_verify_page.dart
  │   │   │   │   ├── reset_password_page.dart
  │   │   │   │   ├── signup_page.dart
  │   │   │   ├── update/
  │   │   │   │   ├── update_pass.dart
  │   │   │   │   ├── update_profile_page.dart
  │   │   │   │   ├── update_task_status.dart
  │   │   │   │   ├── update_task.dart
  │   │   │   ├── about_page.dart
  │   │   │   ├── add_new_task_page.dart
  │   │   │   ├── bottom_nav_base_page.dart
  │   │   │   ├── cancelled_task_page.dart
  │   │   │   ├── completed_task_page.dart
  │   │   │   ├── inprogress_task_page.dart
  │   │   │   ├── new_task_page.dart
  │   │   │   ├── splash_screen.dart
  │   │   ├── utils/
  │   │   │   ├── assets_utils.dart
  │   │   ├── widgets/
  │   │   │   ├── constraints.dart
  │   │   │   ├── dialog_box.dart
  │   │   │   ├── image_picker_sheet.dart
  │   │   │   ├── profile_app_bar.dart
  │   │   │   ├── sceen_background.dart
  │   │   │   ├── task_list_tile.dart
  │   │   │   ├── task_summary_card.dart
  │   ├── app.dart
  │   ├── main.dart
```

## Contributors

- [Mujahedul Islam](https://github.com/muj-i)

## Special Thanks

### A heartfelt thanks to my mentors:

[Rabbil Hasan](https://github.com/rupomsoft) for his enlightening prerecorded class and [Md Rafat J. M.](https://github.com/RafatMeraz) for teaching me how to make UI like this and the API integration seamless.


### A heartfelt thanks to my classmate:

[Nabil Akhunjee](https://github.com/nbakh16) for his invaluable guidance on implementing upload profile picture to API & get the image from API using base64.

I am grateful for the contributions of all of these individuals to the development of Progress Pal. I could not have done it without them.

## License

This project is licensed under the MIT License. Refer to the [LICENSE](https://opensource.org/license/mit/) file for details.
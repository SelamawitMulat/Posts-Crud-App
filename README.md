Here is your fully updated, polished **`README.md`** file.

To keep the document clean, compact, and highly professional for your teacher, all your screenshots have been consolidated into a single **interactive dropdown menu** (using HTML `<details>` and `<summary>` tags). When your teacher clicks to expand a category, they will see a clean grid layout of your screenshots. Clicking on any individual image will open the full high-resolution destination file path instantly!

---

### 📄 `README.md`

```markdown
# Crud Posts App

## 👤 Student Information
* **Name:** Selamawit Mulat
* **Class ID:** UGR/1033/16
* **Section:** 1
* **GitHub ID:** [SelamawitMulat](https://github.com/SelamawitMulat)

A robust Flutter CRUD application built using **Clean Architecture** principles and the **BLoC (Business Logic Component)** pattern. The application features user profile management, dynamic theme toggling, search filtering, and localized error-handling systems.

---

## 🏗️ Architecture Blueprint

The project strictly follows Uncle Bob's Clean Architecture guidelines, ensuring the codebase is scalable, maintainable, and decoupled into three completely isolated layers:


```

```
              ┌─────────────────────────────────────────────────────────┐
              │                    PRESENTATION LAYER                   │
              │         Widgets ──► BLoC States ◄──► BLoC Events        │
              └────────────────────────────┬────────────────────────────┘
                                           │
                                   (Invokes Use Cases)
                                           │
                                           ▼
              ┌─────────────────────────────────────────────────────────┐
              │                      DOMAIN LAYER                       │
              │             Fetch/Create/Update/Delete UseCases         │
              │             Entities  ◄──► Repository Interfaces         │
              └────────────────────────────┬────────────────────────────┘
                                           │
                                (Implements Interfaces)
                                           │
                                           ▼
              ┌─────────────────────────────────────────────────────────┐
              │                       DATA LAYER                        │
              │       PostRepositoryImpl ◄──► PostRemoteDataSource      │
              │                     External HTTP (Dio)                 │
              └─────────────────────────────────────────────────────────┘

```

```

1. **Presentation Layer (`lib/features/posts/presentation/`):**
   * Manages UI state changes using the **BLoC** pattern.
   * Isolates widget builds via `BlocBuilder` to ensure high-performance UI rendering loops.
2. **Domain Layer (`lib/features/posts/domain/`):**
   * Encapsulates distinct business operations inside isolated Use Case classes (`FetchPostsUseCase`, `CreatePostUseCase`, `UpdatePostUseCase`, `DeletePostUseCase`).
   * Contains structural entity definitions and abstract repository blueprints.
3. **Data Layer (`lib/features/posts/data/`):**
   * Handles remote network communications through a dedicated `PostRemoteDataSource` consuming `Dio`.
   * Maps unmanaged remote payloads to strong domain structures.

---

## 📸 App Features & Screenshots Gallery

<details>
<summary><b>📐 Click here to expand the Application Screenshot Gallery</b></summary>
<br/>

*Click on any image screenshot to open its full high-resolution destination file.*

### 🏠 Core Navigation & Home View
<table width="100%">
  <tr>
    <td width="33.3%" align="center"><b>Main Feed Interface</b><br/><br/><a href="screenshots/Home%20Page.png"><img src="screenshots/Home%20Page.png" alt="Home Page" width="100%"/></a></td>
    <td width="33.3%" align="center"><b>Loading State Shimmer</b><br/><br/><a href="screenshots/loading%20posts.png"><img src="screenshots/loading%20posts.png" alt="Loading Posts" width="100%"/></a></td>
    <td width="33.3%" align="center"><b>Real-time Query Filtering</b><br/><br/><a href="screenshots/search%20bar.png"><img src="screenshots/search%20bar.png" alt="Search Bar" width="100%"/></a></td>
  </tr>
</table>

### 📝 Create, Read, Update, Delete (CRUD) Flows
<table width="100%">
  <tr>
    <td width="50%" align="center"><b>Post Creation Interface</b><br/><br/><a href="screenshots/add%20post%20form.png"><img src="screenshots/add%20post%20form.png" alt="Add Post Form" width="100%"/></a></td>
    <td width="50%" align="center"><b>Successful Feed Appending</b><br/><br/><a href="screenshots/after%20creating%20new%20post.png"><img src="screenshots/after%20creating%20new%20post.png" alt="After Creating New Post" width="100%"/></a></td>
  </tr>
  <tr>
    <td width="50%" align="center"><b>Post Editing Modal Interface</b><br/><br/><a href="screenshots/edit%20post%20form.png"><img src="screenshots/edit%20post%20form.png" alt="Edit Post Form" width="100%"/></a></td>
    <td width="50%" align="center"><b>Saved Feed Modifications</b><br/><br/><a href="screenshots/after%20editimg the%20post%20.png"><img src="screenshots/after%20editimg the%20post%20.png" alt="After Editing Post" width="100%"/></a></td>
  </tr>
  <tr>
    <td width="50%" align="center"><b>Destructive Warning Dialog</b><br/><br/><a href="screenshots/delete%20modal.png"><img src="screenshots/delete%20modal.png" alt="Delete Modal" width="100%"/></a></td>
    <td width="50%" align="center"><b>Post Removal Update</b><br/><br/><a href="screenshots/After%20deleting.png"><img src="screenshots/After%20deleting.png" alt="After Deleting" width="100%"/></a></td>
  </tr>
</table>

### 👤 Profile Management & Personalization
<table width="100%">
  <tr>
    <td width="50%" align="center"><b>Default Profile State</b><br/><br/><a href="screenshots/profile%20before%20edit%20.png"><img src="screenshots/profile%20before%20edit%20.png" alt="Profile Before Edit" width="100%"/></a></td>
    <td width="50%" align="center"><b>Updated User Preferences</b><br/><br/><a href="screenshots/profile%20after%20edit.png"><img src="screenshots/profile%20after%20edit.png" alt="Profile After Edit" width="100%"/></a></td>
  </tr>
</table>

### 🌗 System Theme Configurations
<table width="100%">
  <tr>
    <td width="50%" align="center"><b>Light Palette Configuration</b><br/><br/><a href="screenshots/light%20mode.png"><img src="screenshots/light%20mode.png" alt="Light Mode" width="100%"/></a></td>
    <td width="50%" align="center"><b>Dark Palette Configuration</b><br/><br/><a href="screenshots/dark%20mode.png"><img src="screenshots/dark%20mode.png" alt="Dark Mode" width="100%"/></a></td>
  </tr>
</table>

### 🛡️ Active Network Failure Interception
<table width="100%">
  <tr>
    <td width="100%" align="center"><b>Graceful Network Error View</b><br/><br/><a href="screenshots/error.png"><img src="screenshots/error.png" alt="Active Network Error Catch Interface" width="60%"/></a></td>
  </tr>
</table>

</details>

---

## 🛡️ Advanced Error Handling Mechanism

Instead of allowing raw network exceptions (`DioException`, socket drops) to bubble up and freeze or crash the user interface, this application implements a resilient, multi-tiered error-handling design:

### 1. Functional Data Domain Returns
Repository implementations wrap unsafe execution blocks and expose explicit, safe Dart record tuples containing the status information directly:
```dart
Future<(String? failure, List<Post>? posts)> getPosts();

```

* **Failure Route:** The data layer catches server or infrastructure drops and maps them into a readable error message, returning a populated `String` failure slot while setting the data slot to `null`.
* **Success Route:** The failure slot is set to `null` and the data array returns populated.

### 2. State-Preserving Interception

When an error token is extracted within `post_bloc.dart`, the component emits a specialized `PostError` state. Crucially, the system pipes the current state parameters forward:

```dart
emit(PostError(
  failure,
  isDarkMode: state.isDarkMode,
  userName: state.userName,
  userEmail: state.userEmail,
  userBio: state.userBio,
));

```

This ensures global configurations (like the user's selected Dark Mode or local profile settings) are completely preserved and do not clear out when a connection drops.

### 3. Graceful User Recovery View

The presentation layer detects `PostError` and flags the layout engine to swap standard content listings with `error_widget.dart` (visualized in the screenshot gallery dropdown).

* **Isolated Layout Scope:** The error condition is scoped solely to the center content viewport. Global navigation headers and user appbar avatars stay active.
* **Self-Healing UI Loop:** The UI includes a specialized action component (`Retry Execution`) allowing the user to cleanly trigger a renewed data retrieval attempt (`LoadPosts`) seamlessly after a network state is recovered.

---

## 🚀 Getting Started

### Prerequisites

* Flutter SDK (Targeting Channel Stable)
* Linux, Android, or iOS host runtime environment

### Installation & Run Cycles

1. Clone the repository and navigate to the project directory:
```bash
cd posts_crud_app

```


2. Reclaim target assets and fetch underlying framework packages:
```bash
flutter clean

```


```bash
flutter pub get

```


3. Run the complete application test suite to verify baseline configurations:
```bash
flutter test

```


4. Build and compile the runtime target environment:
```bash
flutter run

```



```

```
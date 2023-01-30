# SolidJSTauriMobile

This  is a streamlined `Tauri` project using `Vite` and `SolidJS`

This example includes:

- [Tauri](https://tauri.app/)
- [Tauri Mobile](https://next--tauri.netlify.app/blog/2022/12/09/tauri-mobile-alpha)
- [JSDoc](https://jsdoc.app/)
- [Prettier](https://prettier.io/)
- [ESLint](https://eslint.org/)
- [TailwindCSS](https://tailwindcss.com/)
- [Typescript](https://www.typescriptlang.org/)
- [Proper VSCode Workspace](./my-app/example.code-workspace)

## Usage

```bash
yarn # or pnpm install or npm install
```

### Learn more on the [Solid Website](https://solidjs.com) and come chat with us on our [Discord](https://discord.com/invite/solidjs)

## Available Scripts

In the project directory, you can run:

### `yarn tauri dev`

Runs the app in the development mode.<br>

An app should launch on your desktop.

Alternatively open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.<br>

### `yarn docs`

Uses `JSDoc` to build a documentation website based on the projects documentation.

### `yarn lint`

Runs `eslint` on all of the included files.

### `yarn format`

Uses `Prettier` and the above `yarn lint` command to lint and then format all included file types.

## Deployment

To build your app, run the following:

```bash
yarn tauri build
```

Builds the app for production to the `src-tauri/target` folder.<br>
It correctly bundles Solid in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.<br>
Your app is ready to be deployed!

### Mobile Deployment

#### Pre-requisites

Navigate to the [`setup`](/setup) folder and run the setup script for your OS and target.

If you prefer to use the `Android Studio` for Android development, you can skip the setup script and simply follow these [docs](https://next--tauri.netlify.app/next/mobile/development/configuration) and [here](https://next--tauri.netlify.app/next/guides/getting-started/prerequisites/windows).

No matter which method you choose, you will need to have the `Android SDK` installed and the `ANDROID_HOME` environment variable set.

You will also need to have `Xcode` installed for iOS development.

The following command is needed for android development:

```bash
rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android
```

> **Warning**: You need rust to be installed prior to running the above command.

Next run the following command to setup the mobile environment:

```bash
yarn tauri <target> init
```

Where `<target>` is one of the following:

- `ios`
- `android`

### Running your app

To run your app using the mobile server, run the following:

```bash
yarn tauri <target> dev
```
  
#### Running the app with `Android Studio`

```bash
yarn tauri android dev [--open]
```

The `--open` flag will open the project in `Android Studio` after the build is complete.

You can then select your emulator or device and run the app.

### Building your app

To build your app for mobile, run the following:

```bash
yarn tauri <target> build
```

What you will need
------------------

 * A Linux, Mac OS X, or Windows machine (note: to run and compile iOS specific parts you'll need access to a Mac OS X machine);
 * git (used for source version control, installation instruction can be found [here](https://git-scm.com/));
 * The Flutter SDK (installation instructions can be found [here](https://flutter.io/get-started/install/));
 * A personal GitHub account (if you don't have one, you can sign-up for free [here](https://github.com/))
 
 Setting up your development environment
---------------------------------------

 * Fork `https://github.com/nkshah2/flutter_awesome_button` into your own GitHub account. If you already have a fork and moving to a new computer, make sure you update you fork.
 * Clone your forked repo on your local development machine: `git clone <url-to-your-fork>`
 * Change into the `flutter_awesome_button` directory: `cd flutter_awesome_button`
 * Add an upstream to the original repo, so that fetch from the master repository and not your clone: `git remote add upstream https://github.com/nkshah2/flutter_awesome_button.git
 
 Running the example project
---------------------------

 * Change into the example directory: `cd example`
 * Run the App: `flutter run`
 
 Contribute
----------

We really appreciate contributions via GitHub pull requests. To contribute take the following steps:

 * Make sure you are up to date with the latest code on the master: 
   * `git fetch upstream`
   * `git checkout upstream/master -b <name_of_your_branch>`
 * Apply your changes
 * Verify your changes and fix potential warnings/ errors:
   * Check formatting: `flutter format .`
   * Run static analyses: `flutter analyze`
   * Run unit-tests(if any): `flutter test`
 * Add your changes to got: `git add --all`
 * Commit your changes: `git commit -m "<An informative commit message. Reference issues if you are fixing any with keywords>"`
 * Push changes to your fork: `git push origin <name_of_your_branch>`
 
 Send us your pull request:

 * Go to `https://github.com/nkshah2/flutter_awesome_button` and click the "Compare & pull request" button.

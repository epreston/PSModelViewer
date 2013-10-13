
# PSModelViewer

PSModelViewer is an iPad application that allows you to browse a Core Data model on the go.  Simply drop in a Core Data model and build.


## Example Data Model

This application includes a moderately complex Core Data model to demonstrate the usage of this tool.


## Status

PSModelViewer is a rough yet workable solution for instantly creating an interactive reference for Core Data development work.  It is meant to be quickly updated with minimum effort and rebuilt each time the data model changes.  Those looking for a reference counted implementation should look for a "Non ARC 1.0" branch.

This project follows the [SemVer](http://semver.org/) standard. The API may change in backwards-incompatible ways before the 1.0 release.

The goal of PSModelViewer is to build an application that consumes an unmodified Core Data model and presents browsable representation of its' structure.  This is intended to be a mobile / interactive reference during development.


## Documentation

You can generate documentation with [doxygen](http://www.doxygen.org). The example project includes a documentation build target to do this within Xcode.    For more details, see the [Documentation](https://github.com/epreston/PSModelViewer/wiki/Documentation) page in this projects wiki.


## Contribute

If you'd like to contribute to PSModelViewer, start by forking this repository on GitHub:

http://github.com/epreston/PSModelViewer

The best way to get your changes merged back into core is as follows:

1. Clone down your fork
1. Create a thoughtfully named topic branch to contain your change
1. Hack away
1. Add tests and make sure everything still passes
1. If you are adding new functionality, document it in the README
1. Do not change the version number, I will do that on my end
1. If necessary, rebase your commits into logical chunks, without errors
1. Push the branch up to GitHub
1. Send a pull request to the epreston/PSModelViewer project.


## Copyright and License

Copyright 2010 Preston Software.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this work except in compliance with the License.
   You may obtain a copy of the License in the LICENSE file, or at:

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

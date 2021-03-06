# Combo

**Combo** is a demo collection of various graph-algorithms and data-structures written in Ruby. A user can specify what demo task on what graph file he wants to run. Currently it only shows a demo of a **BFS** ( Breadth First Search) and **DFS** ( Depth First Search) graph traversal (demo task 1). The starting vertex can be set by the user as an input argument. Additional information about the file format in order to define a graph can be found in the following [WIKI](https://github.com/simplay/combo/wiki) page.
Combo is licensed under the [MIT License](http://opensource.org/licenses/MIT).

## Installation
Assuming you have successfully installed **ruby**, **rvm** and **ruby-gems** you only have to clone this repository, browse into its root directory and then simply run ````bundle````.

## Usage
In order to run this application, type ````./combo -t TASKNUMBER```` into your console prompt - while being in the application's root directory. **TASKNUMBER** is an integer indicating the demo task to run. E.g. using a TASKNUMBER equal to **1** will run the demo of a DFS and BFS graph traversal, starting at the first vertex defined in the graph file. An optional parameter to run Combo is **-f** which specifies the name of the grap file. Keep in mind that all graph files have to stored in the folder _data/_. Currently this program prints the corresponding traversal paths into the console plus the structure of the specified graph. Furthermore a user can specify a star vertex for traversals by using the paramter **-s LABEL_STARTING_VERTEX**. At the moment, only integer labels are supported for vertices. Please type ````./combo -h```` to see what other paramters are supported.

## Availabe task numbers:
+ **1** : BFS and DFS graph traversal demo.
+ **2** : Compute all shortest paths and the corresponding distances from any vertex to any other for given (weighted)(directred) Graph demo.

## Contributing
1. Fork this repository
2. Create your feature branch `git checkout -b my-new-feature`
3. Commit your changes `git commit -am "Add some feature"`
4. Push to the branch `git push origin my-new-feature`
5. Create new Pull Request (in your forked repository)

# idkgit

idkgit is a tool that allows users of macOS/Linux to conveniently do git actions to thier projects.

## Prerequisites

Before you begin, ensure you have met the following requirements:

* You have a `Linux/Mac` machine that is able to execute bash scripts
* You have read the instructions for using idkgit

## Installing idkgit

To install idkgit follow these steps:

Linux and macOS:
```
git clone https://github.com/deeeelin/idkgit.git <folder path>
<folder path>/start.bash
```

## Using idkgit

Enter `idk` to execute idkgit,and you will be in "select mode session".

In select mode session , you can enter:

`list` or `l` to see current project that idkgit is tracking

`create` or `cr` to make idkgit track a project your working

`delete` or `d` to cancel tracking a project

`push` or `ph` to push a project , `pull` or `pl` to pull a project:
 
   if your "proj name" is `all` then it will automaitcally push/pull all projects that idkgit is tracking,and 
   the commit message will be the time of committing in default.
 
`init` or `i` to initialize git to your project

`clone` or `cl` to clone repositories

`jump` or `j` to change to one of a directory that idkgit is tracking,and automatically close idkgit

`setcom` or `s` to set commit message for pushing

`out` or `o` to close idkgit (only works when you're in select mode session).

----inside all mode mentioned above ,enter `back` to jump back to "select mode session"-----

## Contributing to idkgit

To contribute to idkgit:

1. Fork this repository.
2. Create a branch
3. Make your changes and commit them
4. Push to the original branch
5. Create the pull request.
6. Send a message to me via email

## Contributors

* [@deeeelin](https://github.com/deeeelin) 

## Contact

If you want to contact me you can reach me at <dereklin100503@gmail.com>

## License

This project uses the following license: [MIT License](https://choosealicense.com/licenses/mit/#).

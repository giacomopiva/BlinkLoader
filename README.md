BlinkLoader
=====
A nice loader 

Installation
==========
To install the BlinkLoader in your App, drop in the BlinkLoader.swift file to your Xcode project. 
Make sure to check "Copy items if needed".

Usage
=======
To create a new loader just instantiate a BlinkLoader class:

    let loader = BlinkLoader(size: 100,
                            color: UIColor.lightGrayColor(),
                  backgroundColor: UIColor.whiteColor(),
                          toColor: UIColor.lightGrayColor(),
                          content: "A")

 - @size is the size of the loader contaier. All the graphics scales with this value.
 - @color is the primary color, the circle border color.
 - @backgroundColor is the starting color of the circle background.
 - @toColor is the color that animation fades to. 
 - @content is the letter inside the circle.

To start the animation, run start() method:

    loader.start(aView, animated: true)

 - @aView is the view which the loader will appear in the center.
 - @animated is an optional value (default is false) if set to true a nice fade in effect is applied.

To stop and remove the loader, run stop() method
 
    loader.stop()

Or 

    loader.stop(true)

  The stop method accept an optional (default is false) boolean parameter that adds a nice fade out effect.

That's all.  

About
=====
BlinkLoader was designed and coded by <a href="http://www.giacomopiva.com">Giacomo Piva</a> (<a href="https://twitter.com/giacomopiva">@giacomopiva</a>)

License
======
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Licenza Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />Quest'opera è distribuita con Licenza <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribuzione 4.0 Internazionale</a>.

![jupyter](https://i.imgur.com/S16l2Hw.png) ![IHaskell](https://i.imgur.com/qhXXFbA.png) [![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/DevonMorris/LearnYouAHaskell/master)

# Learn You a Haskell for Great Good
[Learn You a Haskell](http://learnyouahaskell.com/chapters) is an online guide to learning the Haskell programming language and learning about functional programming. Here are my efforts and insights from following this book.

My implementation is done in [jupyter notebooks](http://jupyter.org/) with the [IHaskell](https://github.com/gibiansky/IHaskell) kernel. You should be able to view and run my code by clicking the binder badge at the top of this readme.

## Binder
The binder notebook viewer builds a [Docker](https://www.docker.com/) image. This way that binder works, this will be built once for a specific `ref` (i.e. commit). Ideally, I will have already committed, pushed and built the image in binder. However, if the binder takes a ridiculous amount time to load, it is probably building the docker image for the commit for the first time. So, go get a drink and come back in 30 minutes or so and it'll be ready.

Alternatively, you can clone my repository and install IHaskell yourself and run the notebook that way.

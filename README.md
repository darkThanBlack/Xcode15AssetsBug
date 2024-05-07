# Xcode15AssetsBug
> Some transparent images become darker on Xcode 15.
>
> Created: 2024/05/07   by darkThanBlack.

 

#### Desc

You must read this [Thread](https://developer.apple.com/forums/thread/733455) first, I create this proj as a personal summary.

Very early on I created this [PR](https://github.com/dreampiggy/iOS17IndexedPNGDecodeBug/pull/1), you can find more desc in it.

![img](https://raw.githubusercontent.com/darkThanBlack/darkThanBlack.github.io/pictures/docs/assets/pictures/ios17_alpha_image_render.png)

![img](https://raw.githubusercontent.com/darkThanBlack/darkThanBlack.github.io/pictures/docs/assets/pictures/ios17_image_render_03.png)



#### Solution

* Packaged with Xcode 14.3.
    * Unrealistic. Apple required Xcode 15 now, [News](https://developer.apple.com/news/upcoming-requirements/?id=04292024a).
* Move all image from assets to bundle.
    * Unrealistic.
* Change: ``Assets - Image Set - Compression - Lossy, Basic``.
    * Works. But the problem is that there are so many pictures that you don't know which ones are actually render wrong.
* Change: ``Assets - Assets Catalog - Compression - Lossy, Basic``.
    * Unavailable. Other image will render incorrectly.
* Check image bit, if image is 4 bit or another, convert to 8 bit.
    * Works. But the problem is some 8 bit image also have wrong render.
* Convert all images to 8 bit use PIL.
    * I choose this as the final solution.



#### Question

Can we write a script to scan images that may be rendering incorrectly? This avoids potential problems caused by full conversion.



#### Thanks

PIL script from [simpossible](https://developer.apple.com/forums/profile/simpossible).

# zify


Zify (read "zee-ify") will add depth to icons.  As input, it takes:

 * A black and white image.
 * A Blender 3D template (see `design` directory).

It then traces the outlines of the black material in the image, and
substitutes that for the letter `A` in the template.  The result
is then rendered and output as an image.

## Examples

IN: ![2d frog](https://user-images.githubusercontent.com/118367/51000550-7abc0500-14fb-11e9-8f5a-3c32966068c3.png)
OUT: ![70-bronze](https://user-images.githubusercontent.com/118367/51293540-7b620900-19dd-11e9-9002-1bc609583168.png) ![96-polished-gold](https://user-images.githubusercontent.com/118367/51293546-83ba4400-19dd-11e9-91d3-b3a2329398f5.png) ![49-material-of-3laseray](https://user-images.githubusercontent.com/118367/51293512-64231b80-19dd-11e9-903b-f40eb81b1961.png) ![50-white-marble](https://user-images.githubusercontent.com/118367/51293528-6e451a00-19dd-11e9-8265-cf349786fe27.png) ![5-camouflage](https://user-images.githubusercontent.com/118367/51293535-74d39180-19dd-11e9-8a20-7b4bd57de325.png) ![90-lava](https://user-images.githubusercontent.com/118367/51293552-887ef800-19dd-11e9-8ca2-bad8f43e26cf.png) ![61-abstract-glass](https://user-images.githubusercontent.com/118367/51293562-903e9c80-19dd-11e9-8f96-3a680d28f788.png) ![91-water](https://user-images.githubusercontent.com/118367/51293572-959be700-19dd-11e9-8509-c5b7715b2632.png) ![67-polystyrene](https://user-images.githubusercontent.com/118367/51293597-a64c5d00-19dd-11e9-95e6-5db463e78595.png) ![80-chocolate](https://user-images.githubusercontent.com/118367/51293603-ab111100-19dd-11e9-8607-7837fb38128f.png)
![frog forest](https://user-images.githubusercontent.com/118367/51010030-6cccab00-1520-11e9-9c6c-067366c9f1b1.png)
![glass frog](https://user-images.githubusercontent.com/118367/51064634-acea6700-15ce-11e9-8bbb-f92509026455.png)


## Running zify

If you have docker, you can run:

```
./zify_with_docker.sh design/example.blend input/frog.png out.png
```

If you are willing to install everything mentioned in the
`docker/Dockerfile` file, then you can run:

```
./zify.sh design/example.blend input/frog.png out.png
```

You can control some parameters with environment variables:

```
ZIFY_SCALE=50 ZIFY_SAMPLES=20 ./zify.sh design/example.blend input/frog.png out.png
```

 * `ZIFY_SCALE` sets the render resolution as a percentage.
 * `ZIFY_SAMPLES` sets the number of samples to make (set to 0 to use the setting for
   previews in blender).

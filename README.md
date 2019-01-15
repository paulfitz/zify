# zify


Zify (read "zee-ify") will add depth to icons.  As input, it takes:

 * A black and white image.
 * A Blender 3D template (see `design` directory).

It then traces the outlines of the black material in the image, and
substitutes that for the letter `A` in the template.  The result
is then rendered and output as an image.

## Examples

IN: ![2d frog](https://user-images.githubusercontent.com/118367/51000550-7abc0500-14fb-11e9-8f5a-3c32966068c3.png)
OUT: ![golden frog](https://user-images.githubusercontent.com/118367/51060088-73106500-15bc-11e9-83f7-b5b1a0663429.png)

Other outputs:

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

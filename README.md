zify
====

Zify (read "zee-ify") will add depth to images.  As input, it takes:

 * A Blender 3D template of how the letter "A" should be rendered.
 * A (more or less) black and white image.

It then traces the outlines of the black material in the image, and
substitutes that for the letter "A" in the template.  The result
is then rendered and output as an image.

Running zify
------------

If you have docker, you can run:

```
./zify_with_docker.sh design/example.blend input/frog.png out.png
```

If you are willing to install everything mentioned in the
`docker/Dockerfile` file, then you can run:

```
./zify.sh design/example.blend input/frog.png out.png
```
